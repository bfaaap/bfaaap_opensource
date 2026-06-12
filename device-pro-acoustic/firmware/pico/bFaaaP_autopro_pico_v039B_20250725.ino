
/*
bFaaaP_autopro_v039B_20250725 for raspberry pi pico or pico2
prog. by Hiroyuki Narusawa
2025/07/25

// raspberry pi pico or raspberry pi pico2
Serial                        for USB
Serial1 TX1/GP00 RX1/GP01　　　for BLEデータ   1pin 2pin
Serial2 TX2/GP04 RX2/GP05　　　for IQモーター　 6pin 7pin  
I2C.    SDA/GP02 SCL/GP03.    for 圧力センサー　HX711 4pin 5pin
GPIO.   OUTPUT.     /GP12     for MOSFET 駆動ポート　

// IQ Motor 端子
         12-48V
          ^ ^
          | |
          | | 
          - +
        G | |
o o o o o o o
        o tx -----> RX1
        o rx <----- TX1

*/

#include <iq_module_communication.hpp> //
#include "HX711.h"
float   mm=PI/8;         // １ｍｍ動くための回転角度（ラジアン）一回転8mm
float   cu_rad=0;        // current positon　現在の回転角度
uint8_t vol=30;          // Buzzer saund levelブザーの音量値セット
int     def=0;           // 差分値
int     tmp=0;           //
int     incomingByte = 0;// for incoming bluteeth serial data
float   pos=0;           //
float   up_pos=0;        //機械的上限値
float   down_pos=0;      //機械的下限値
float   upoffset=0;
float   downoffset=10;
float   downforce=20;
float   tmp_uos=0;
float   def_ad=0;
float   orig_pos=0;
float   move_pos=0;
// Define the pins for the HX711 communication(I2C)
const int LOADCELL_DOUT_PIN = 2;
const int LOADCELL_SCK_PIN = 3;

HX711 scale;



IqSerial ser(Serial2);               //IQ motor シリアルポート付き　定義
MultiTurnAngleControlClient mult(0); //IQ motorの多回転角度制御　　クライアント名定義
BuzzerControlClient buz(0);          //IQ motorのブザー制御　　　　クライアント名定義
PowerMonitorClient pwr(0);           //IQ motorの電力モニター制御　クライアント名定義

//　モーターから周波数(hz)の発振音をlen（ms）間出す
void booo(uint16_t hz,uint16_t len) {

    ser.set(buz.hz_,hz);        //　周波数
    ser.set(buz.volume_,vol);   //　音量
    ser.set(buz.duration_,len); //　継続時間
    ser.set(buz.ctrl_note_);    //　スタート
    delay(len);                 //　継続時間だけ待つ
}
/*
void move(float mov,float dur){// mov 回転角　dur 所要時間
    ser.set(mult.trajectory_angular_displacement_,mov);// 回転角セット
    dur=abs(mov-move_pos)/20*0.1;
    ser.set(mult.trajectory_duration_,dur);//　回転所要時間セットと回転の開始　実際に回転し始める
    move_pos=mov;
}
*/
void move(float mov,float dur){// mov 回転角　dur 所要時間
    ser.set(mult.trajectory_angular_displacement_,mov);// 回転角セット
    ser.set(mult.trajectory_duration_,dur);//　回転所要時間セットと回転の開始　実際に回転し始める
}
float nibble_float(int gpio_no){
      int tmp=0;
      float ftmp=0;
      tmp=digitalRead(gpio_no);
      if(tmp==0){
        ftmp=ftmp+8.0;
      }
      tmp=digitalRead(gpio_no+1);
      if(tmp==0){ 
        ftmp+=4.0;
      }
      tmp=digitalRead(gpio_no+2);
      if(tmp==0){
        ftmp+=2.0;        
      }
      tmp=digitalRead(gpio_no+3);
      if(tmp==0){
        ftmp+=1.0;        
      }
      return(ftmp);
}
// ペダル位置の自動セット
void auto_set(void){
    float mmm=-mm;
    float cu=cu_rad;
    float watt=0;
    //float down_limt=0;
    int   c=0;
    //ser.get(mult.obs_angular_displacement_,cu_rad);
    ser.get(pwr.watts_,watt);
    Serial.print("watt="); Serial.println(watt);
    // Serial.print(""); Serial.printnl();
    // 駆動電力が１０W以下の間、続ける　1mmずつ上げる
    //物理的に突き当たり駆動しようとして電力が増加する         
    while(watt<10){ 
          move(cu+mmm,0.1f);
          delay(110);
          mmm-=mm;
          ser.get(pwr.watts_,watt);
          Serial.print("watt="); Serial.println(watt);
    }
    Serial.println("auto_up_pos_set_end");
    mmm+=5*mm; // 突き当たっているので５mm下げる
    move(cu+mmm,0.5f);
    delay(510);
    up_pos=cu+mmm;
//    down_limt=up_pos+mm*50;
//    down_limt=mmm+50*mm;
//  駆動電力が3０W以下か下りが50mm以下の間、1mmずつ下げを続ける　
//  物理的に突き当たり駆動しようとして電力が増加する　50mm以上下げると押し棒が抜ける
//    while((watt<30) || ((cu+mmm)<down_limt)){

//　押さえつける力が強すぎると、滑るので、watt数を２０に変更　まだ検討の余地あり　ピアノによって変わる
// 場合によっては、本体に設定スイッチもしくはpinが必要になるかも
// 2025/07/21 ２０wでは弱すぎて突き当たる前に動作する
// 2025/07/22 ディップスイッチにて押さえ込む力（電力値）を設定出来る様にした
// ディップスイッチの値＋２０Wとし２０Wから３５Wまで１W単位で設定
// 2025/07/22 ディップスイッチで突き当たり点より上げる値を5-20mm設定できる様にした 

    downforce=nibble_float(14)+20;
    ser.get(pwr.watts_,watt);
    while((watt<downforce)){ 
          move(cu+mmm,0.1f);
          delay(110);
          mmm+=mm;
          c++;
          if(c>65) break;
          ser.get(pwr.watts_,watt);
          Serial.print("watt="); Serial.println(watt);         
  //        Serial.print("down_limt="); Serial.println(down_limt);
          Serial.print("cu+mmm="); Serial.println(cu+mmm);
  //        Serial.print("watt="); Serial.println(watt);
    }
    Serial.println("auto_down_pos_set_end");
    downoffset=nibble_float(18)+5;
    mmm-=downoffset*mm;       // 突き当たっているのディップスイッチ設定値＋５mm上げる
    move(cu+mmm,0.1f);
    delay(110);
    down_pos=cu+mmm;
    move(up_pos,0.5f);
    Serial.println("auto_set_end");
    delay(510);
}

// map関数の浮動小数化関数
float mapf(float x, float in_min, float in_max, float out_min, float out_max) {
      return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

//エアージャッキによる装置の固定
void auto_air_jack(void){
  long p=0;
  unsigned long tt=0;
  p=scale.read();
  if(p<6000000){  //空気圧が足らない間、空気を送る
     tt=millis();
     digitalWrite(12,1); //
     p=scale.read();
     while(p<8000000){   //空気圧が足らない状態が３０秒続いたら中止
      if(millis()-tt>30000){
         Serial.println("timeout 30Sec");
         break;
      }
      Serial.println(p); 
      p=scale.read();
  
     }
     digitalWrite(12,0); //
     p=scale.read();
     Serial.println("hx711_end");
  }
//  Serial.print("p=");
//  Serial.println(p); 

  if(p<6000000){ //空気圧が足らないのでエラー警告音を鳴らす
    Serial.println("P_err");
    while(1){
      booo(500,1000);
      delay(1000);
      booo(1000,1000);
      delay(1000);
    }
  }
  digitalWrite(12,1);
  delay(10000);
  digitalWrite(12,0);
}

int offset_AD_read(void){
    analogReadResolution(6); // ADの解像度を５ビットとし値を0−３２にしオフセットに使用　単位mm
// 20250725 ADの解像度を6ビットとし値を0−64mmにしオフセットに使用

    int tmp=analogRead(A0);
//        tmp/=2;
        Serial.println(tmp);
    return(tmp);
}
void test_ad(void){
  while(1){
    upoffset=offset_AD_read();//
    def_ad=abs(upoffset-tmp_uos);
    if(def_ad>1){    //
      up_pos+=upoffset;       //
      tmp_uos=upoffset;       //
      Serial.print("offset_AD_read=");
      Serial.println(upoffset);
    } 
  } 
}

void test_dipsw(void){
  float ftmp=0;
    downforce=nibble_float(14)+20;
    Serial.print("downforce=");
    Serial.println(downforce);

    downoffset=nibble_float(18)+5;
    Serial.print("downoffset=");
    Serial.println(downoffset);
  delay(1000);
}

void setup() {
  float check_def=0;
  delay(5000);
  Serial1.setTX(0);                   // for IQmotor TX GP00
  Serial1.setRX(1);                   // for IQmotor RX GP01
  Serial2.setTX(4);                   // for BLE TX GP04
  Serial2.setRX(5);                   // for BLE RX GP05
  Serial.begin(115200);               // Serialボーレート指定　 for USB (debug)
  Serial1.begin(115200);
  Serial2.begin(115200);              // Serial2ボーレート指定　for BLE
  pinMode(12, OUTPUT);                // MOSFET 駆動ポート　GP12
  pinMode(14, INPUT);                // ポート　GP14 GP14-17 for downforce
  pinMode(15, INPUT);                // ポート　GP15 20w+(0-15)W
  pinMode(16, INPUT);                // ポート　GP16 min 20W
  pinMode(17, INPUT);                // ポート　GP17 max 35W
  pinMode(18, INPUT);                // ポート　GP18 GP18-21 for downoffset
  pinMode(19, INPUT);                // ポート　GP19 5mm+(0-15)mm
  pinMode(20, INPUT);                // ポート　GP20 min 5mm
  pinMode(21, INPUT);                // ポート　GP21 max 20mm
  Serial.println("bFaaaP_autopro_pico_v039B 20250725 for raspberry pi pico or 2");
  delay(100);                        // モーターのセットアップ時間の待ち時間  
// Initialize the HX711
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  ser.begin(115200);                  // start IQ motor 
  delay(100);

//  while(1){
//    test_dipsw();
//  }
  ser.get(mult.obs_angular_displacement_,cu_rad); // 電源投入時の回転角位置を取得
  delay(100);



  // ad_test_loop
  //test_ad();
  auto_air_jack();                    // エアージャッキで装置の固定する
  auto_set();                         // 機械的トップとダウン位置を検出後、down 10mm上げ　up 10mm下げ 
  orig_pos=up_pos;                    // この時点の上限値
  upoffset=offset_AD_read();          //　上限値設定AD値の読み込み　0−３１（mm）
  check_def=orig_pos+mm*upoffset;     //　上限値にオフセット分加える
  if(check_def<down_pos){           //　下限値と上述値を比較
     up_pos=check_def;                //　プラスなら上限値に設定値を加え新しいup_posとする
  }else{
     up_pos=down_pos-mm;              //　０かマイナスなら下限値から1mm引いた値を新しいup_posとする 
  }             
  tmp_uos=upoffset;                   //
  //move(up_pos,0.1f);
  //delay(110);
  move(up_pos,1.0f);
  delay(1100);

//  Serial.print("offset_ad_read="); Serial.println(upoffset);         
//  Serial.print("up_pos="); Serial.println(up_pos);
  // orig_pos=up_pos;
  }

//IQ Motor 最高回転数4000rpm 一秒間に67回転　一秒間で533mm（８mmリードスクリュー）50mmでほぼ　100ms 
//移動量に関わらず移動時間を90mSに固定した
//移動量と連動して移動時間を可変にする方法もある今後の課題 
void loop() {
  float check_def=0;
  if(Serial1.available() > 0) {                          // read the incoming byte:　BLEからデータが送られている場合
    incomingByte= Serial1.read();                        // データを読む
//    Serial.print("incomingByte="); Serial.println(incomingByte);
    pos=mapf((float)incomingByte,0,99,up_pos,down_pos);  // BLEから送られて来る０－９９の値をup_pos,down_posの間にマッピング
    def=incomingByte-tmp;                                // 首のブレを考慮して送られて来るデータに２以上の差が有る場合に動作
    def=abs(def);                                        //　差分の絶対値を計算
    if(def>2){                                           //　2以上なら駆動する   
      move(pos,0.09f);                                   //  ９０ｍｓでＰＯＳ位置まで移動
      delay(100);                                        //　１００ｍｓ駆動時間を待つ
      tmp=incomingByte;                                  //　前回との比較のために今回の値を記憶  
    }
    upoffset=offset_AD_read();                           //
    def_ad=abs(upoffset-tmp_uos);
    check_def=orig_pos+mm*upoffset;                        
    if(def_ad>1){                                        //
       if(check_def<down_pos)                            //　下限値より上限設定値が大きい場合
          up_pos=orig_pos+mm*upoffset;
       else
          up_pos=down_pos-mm;                            //　０かマイナスなら下限値から1mm引いた値を新しいup_posとする
      tmp_uos=upoffset;                                  //
//      Serial.print("offset_AD_read=");
//      Serial.println(upoffset);
    }  
  }

}

//
//    APPENDIX   APPENDIX   APPENDIX   APPENDIX   APPENDIX   APPENDIX   APPENDIX   APPENDIX   APPENDIX

/* IQモーターのマルチターンアングルコントローラークラスのファンクション表
　　ファンクション名の末尾にアンダーバーを付けて使用する
（ 例 ) trajectory_angular_displacementとtrajectory_duration の場合

　　　#include <iq_module_communication.hpp>    // include
                      .
　　　MultiTurnAngleControlClient mult(0);      //
                      .
　　　IqSerial ser(Serial1);                    // uart 指定
                      .
　　　ser.set(mult.trajectory_angular_displacement_,mov);// 回転角セット
　　　ser.set(mult.trajectory_duration_,dur);//　所要時間セットと回転の開始　実際に回転し始める

この5行だけで所定、回転角位置に回転し停止する、外部から力が加わっても位置を維持しようとする

Type ID 59 | Multi-turn Angle Controller
SubID  ShortName                       Access          DataType  Unit        Note
    0  ctrl_mode                       get.            int8      enum        no_change = -1, brake=0, coast=1, pwm=2, volts=3, velocity=4, angle=5, trajectory=6
    1  ctrl_brake                      set.                                  Shorts motor phases, slows motor down dissipating energy in motor
    2  ctrl_coast                      set.                                  Disables all drive circuitry, motor passively coasts
    3. ctrl_angle                      get, set        float     rad.        Angular location command
    4. ctrl_velocity                   get, set.       float.    rad/s.      Angular velocity command
    5  angle_Kp.                       get, set, save  float.    V/rad       Proportional gain
    6  angle_Ki.                       get, set, save  float.    V/(rad*s).  Integral gain
    7. angle_Kd                        get, set, save. float.    V/(rad/s).  Derivative gain
    8. timeout.                        get, set, save. float.    s.          The controller must receive a message within this time otherwise it is set to coast mode
    9. ctrl_pwm.                       get, set.       float.    PWM.        Spins motor with this throttle [-1, 1]
   10  ctrl_volts.                     get, set        float     V.          Spins motor with this voltage
   11  obs_angular_displacement        get, set        float.    rad.        Observed angular location
   12. obs_angular_velocity.           get             float.    rad/s.      Observed angular velocity
   13. meter_per_rad.                  get, set, save. float.    m/rad.      Transmission between angular and linear motion
   14  ctrl_linear_displacement.       get, set,       float.    m.          Linear equivalent to ctrl_angle
   15  ctrl_linear_velocity.           get, set,       float.    m/s.        Linear equivalent to ctrl_velocity
   16. obs_linear_displacement.        get, set,       float.    m.          Observed linear location
   17. obs_linear_velocity.            get.            float.    m/s.        Observed linear velocity
   18. angular_speed_max.              get, set, save. float.    rad/s.      The controller will never attempt to exceed this speed
   19. trajectory_angular_displacement get, set        float.    rad.        Final absolute displacement of trajectory.
   20. trajectory_angular_velocity.    get, set.       float.    rad/s.      Final velocity of the trajectory. Defaults to 0.
   21. trajectory_angular_acceleration get, set.       float.                Final acceleration of the trajectory. Defaults to 0.
   22. trajectory_duration.            set.            float.    s.          Duration of trajectory. Trajectory is executed or queued once this is sent.
   23. trajectory_linear_displacement  get, set.       float.    m.          Final absolute displacement of trajectory.
   24. trajectory_linear_velocity      get, set.       float.    m/s.        Final velocity of the trajectory. Defaults to 0.
   25. trajectory_linear_acceleration  get, set.       float.                Final acceleration of the trajectory. Defaults to 0.
   26. trajectory_average_speed.       get, set.       float                 Average speed of a trajectory. Trajectory is executed or queued once this is sent. Must be $>0$.
   27. trajectory_queue_mode.          get, set, save. int8.                 append=0, overwrite=1
   29. ff                              get, set        uint32.               Feed forward term
   30  sample_zero_angle               set. Sets                             the module’s current postiion as the zero angle.
   31. zero_angle.                     get, set, save. float.    rad.        The anglular position that the module considers as its ‘zero’ position.

*/
/*IQモーターのパワーセーフティークラスのファンクション表
ファンクション名の末尾にアンダーバーを付けて使用する
（ 例 ) PowerMonitorClient
#include <iq_module_communication.hpp>    // include
PowerMonitorClient pwr(0);
IqSerial ser(Serial1);                    // uart 指定
ser.get(pwr.watts_,watt);                 // 現在の入力電力



Type ID 84 | Power Safety
Power Safety
Sub ID    Short Name           Access.       Data Type   Unit.           Note

0.       fault_now.         get.              uint8.               The fault(s) that are currently triggering

1.       fault_ever         get, set, save.   uint8.               Record of all faults that were triggered since last modified by user. The user can clear all of the records by setting the value to 0, or individual faults by properly setting bitmask value

2.      fault_latching.     get, set, save.   uint8.               Determines if the motor is latching. When latching, if there are any bits set in fault_ever, motor will stay in Safe Mode until they are cleared. When not latching, motor will enter and exit Safe Mode only on current faults based on fault_now

3.      volt_input_low.     get, set, save.   float.               Minimum threshold value for voltage

4.      volt_input_high.    get, set, save.   float.               Maximum threshold value for voltage

5.      vref_int_low.       get, set, save.   float.               Minimum threshold value for reference voltage

6.      vref_int_high.      get, set, save.   float.               Maximum threshold value for reference voltage

7.    current_input_low.    get, set, save.   float.               Minimum threshold value for current

8.    current_input_high.   get, set, save.   float.               Maximum threshold value for current

9.    motor_current_low.    get, set, save.   float.               Minimum threshold value for motor current

10.   motor_current_high.   get, set, save.   float.               Maximum threshold value for motor current

11.   temperature_uc_low.   get, set, save.   float.               Minimum threshold value for microcontroller temperature

12.   temperature_uc_high   get, set, save.   float.               Maximum threshold value for microcontroller temperature

13.   temperature_coil_low. get, set, save.   float                Minimum threshold value for coil temperature

14.   temperature_coil_high get, set, save.   float.               Maximum threshold value for coil temperature


*/

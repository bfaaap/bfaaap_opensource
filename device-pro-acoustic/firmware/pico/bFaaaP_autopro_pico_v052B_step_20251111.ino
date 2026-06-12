
/*
bFaaaP_pro_v052B_step_20251111 for raspberry pi pico or 2
prog. by Hiroyuki Narusawa
2025/11/09

IQモーターの供給停止に伴って、駆動モーターをクローズドループ型ステッピングモーターに変更

// raspberry pi pico or raspberry pi pico2
Serial                        for USB
Serial1 TX1/GP00 RX1/GP01　　　for BLEデータ   1pin 2pin
I2C.    SDA/GP02 SCL/GP03.    for 圧力センサー　HX711 4pin 5pin
GPIO.   OUTPUT.     /GP12     for MOSFET 駆動ポート
ADC.    A0                    for モーター電流検出ポート　

*/

int   mm=50;           // １ｍｍ動くためのステップ数（マイクロステップ　400）
int   cu_pos=0;        // current positon　現在の回転角度
int   cu_steppos=0;    // current positon 
uint8_t vol=30;        // Buzzer saund levelブザーの音量値セット
int   def=0;           // 差分値
int   tmp=0;           //
int   incomingByte = 0;// for incoming bluteeth serial data
int   pos=0;           //
int   up_pos=mm*5;
int   down_pos=0;      //機械的下限値
int   upoffset=0;
int   tmp_uos=0;
int   def_ad=0;
int   orig_pos=0;
int   move_pos=0;
int   mot_cu_up=0;
int   mot_cu_down=0;
int   cu=0;

/*
p_ad air_pomp_mot cu // エアーポンプモーターの電流値を読む
*/

//　発振音をlen（ms）間出す
void booo(uint16_t len) {
    delay(len);                 //　継続時間だけ待つ
}

void move(int mov, int tim){
  if(mov<0){
    digitalWrite(14,0);
    mov*=-1;
    for(int i=0;i<mov;i++){
        digitalWrite(13,1);
        delayMicroseconds(tim);
        digitalWrite(13,0);
        delayMicroseconds(tim);
    }  
  }else{
    digitalWrite(14,1);
    for(int i=0;i<mov;i++){   
        digitalWrite(13,1);
        delayMicroseconds(tim);
        digitalWrite(13,0);
        delayMicroseconds(tim);
    }    
  }
  cu_pos+=mov;
}
float get_cu(void){
  int tmp=0;
      analogReadResolution(10); // ADの解像度を10ビット
      for(int i=0;i<100;i++){
          tmp+=analogRead(A0);
      }    
      tmp/=100;
      Serial.println(tmp);
      return(tmp);
}
float get_offset(void){
  int tmp=0;
      analogReadResolution(5); // ADの解像度を5ビットとし値を0−３２にしオフセットに使用
      for(int i=0;i<100;i++){
          tmp+=analogRead(A1);
      }    
      tmp/=100;
      Serial.println(tmp);
      return(tmp);
}


// ペダル位置の自動セット
void auto_set(void){
    int mmm=-mm;
    int mot_cu=0;
    int   c=0;
    int watt=0;
    cu=cu_pos;
    //ser.get(mult.obs_angular_displacement_,cu_rad);
    mot_cu=setp_mot_cu_ad();
    Serial.print("current="); Serial.println(mot_cu);
    // Serial.print(""); Serial.printnl();
    // 駆動電力がxxxxA以下の間、続ける　1mmずつ上げる
    //物理的に突き当たり駆動しようとして電力が増加する         
    while(mot_cu<mot_cu_up){ 
          move(-mm);
          cu--;
          mot_cu=get_cu();
          Serial.print("mot_cu="); Serial.println(mot_cu);
    }
    //Serial.println("auto_up_pos_set_end");
    //while(1);
    move(5*mm,100);   // 突き当たっているので５mm下げる
    cu-=5*mm;
    up_pos=cu;
//  駆動電力がxxxxA以下か下りが50mm以下の間、1mmずつ下げを続ける　
//  物理的に突き当たり駆動しようとして電力が増加する　50mm以上下げると押し棒が抜ける
//    while((mot_cu<xxxx) || ((cu+mmm)<down_limt)){

//　押さえつける力が強すぎると、滑るので、電流値をxxxxAに変更　まだ検討の余地あり　ピアノによって変わる
// 場合によっては、本体に設定スイッチもしくはpinが必要になるかも

    while((mot_cu<mot_cu_down)){ 
          move(mm,100);
          cu+=mm;
          c++;
          if(c>65) break;
          mot_cu=setp_mot_cu_ad();
          Serial.print("mot_cu="); Serial.println(mot_cu);         
          Serial.print("cu+mmm="); Serial.println(cu+mmm);
  //        Serial.print("watt="); Serial.println(watt);
    }
    Serial.println("auto_down_pos_set_end");
    move(-10*mm,100);// 突き当たっているので10mm上げる
    cu-=10*mm;
    down_pos=cu;
    Serial.println("auto_set_end");
}

// map関数の浮動小数化関数
float mapf(float x, float in_min, float in_max, float out_min, float out_max) {
      return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

//エアージャッキによる装置の固定
void auto_air_jack(void){
  long p=0;
  unsigned long tt=0;
  p=air_mot_cu_ad();
  if(p<low_p){  //空気圧が足らない間、空気を送る
     tt=millis();
     digitalWrite(12,1); //
     p=air_mot_cu_ad();
     while(p<hi_p){   //空気圧が足らない状態が３０秒続いたら中止
      if(millis()-tt>30000){
         Serial.println("timeout 30Sec");
         break;
      }
      Serial.println(p); 
      // p=scale.read();
      p=air_mot_cu_ad();
     }
     digitalWrite(12,0); //
     P=air_mot_cu_ad();
  }
//  Serial.print("p=");
//  Serial.println(p); 

  if(p<low_p){ //空気圧が足らないのでエラー警告音を鳴らす
    Serial.println("P_err");
    while(1){
      digitalWrite(13,1);
      delay(300);
      digitalWrite(13,0);
      delay(300);
    }
     
  }

}
int air_mot_cu_ad(){
  int tmp=0;
      analogReadResolution(10); // ADの解像度を５ビットとし値を0−３２にしオフセットに使用　単位mm
      for(int i=0;i<100;i++){
          tmp+=analogRead(A0);
      }    
      tmp/=100;
      Serial.println(tmp);
      return(tmp);  

}
int setp_mot_cu_ad(){
  int tmp=0;
      analogReadResolution(10); // ADの解像度を５ビットとし値を0−３２にしオフセットに使用　単位mm
      for(int i=0;i<100;i++){
          tmp+=analogRead(A1);
      }    
      tmp/=100;
      Serial.println(tmp);
      return(tmp);  

}
int offset_AD_read(void){
    analogReadResolution(6); // ADの解像度を５ビットとし値を0−３２にしオフセットに使用　単位mm
    int tmp=analogRead(A3);
        tmp/=2;
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
void setup() {
  float check_def=0;
  delay(5000);
  Serial2.setTX(4);                   // for BLE TX GP04
  Serial2.setRX(5);                   // for BLE RX GP05
  Serial.begin(115200);               // Serialボーレート指定　 for USB (debug)
  //Serial1.begin(115200);
  Serial2.begin(115200);              // Serial2ボーレート指定　for BLE
  pinMode(12,OUTPUT);                 // MOSFET 駆動ポート　GP12
  pinMode(13,OUTPUT);                 // ブザーオン・オフ or SP
  pinMode(14,OUTPUT);                 // ステッピングモーターのステップパルス
  pinMode(15,OUTPUT);                 // ステッピングモーターの回転方向

  Serial.println("bFaaaP_pro_v052B_step_20251111 for raspberry pi pico or 2");

// Initialize the HX711
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);

  cu_rad=0;                           // 電源投入時の回転角位置を取得
  auto_air_jack();                    // エアージャッキで装置の固定する
  auto_set();                         // 機械的トップとダウン位置を検出後、down 10mm上げ　up 10mm下げ 
  check_def=down_pos-up_pos;
  move(-check_def,100);
  cu=cu-check_def;

  /*.   test program */
  while(1){
    move(-check_def,100);
    delay(500);
    move(check_def,100);
    delay(500);
  }

void loop() {


  float check_def=0;
  if(Serial1.available() > 0) {                          // read the incoming byte:　BLEからデータが送られている場合
    incomingByte= Serial1.read();                        // データを読む
//    Serial.print("incomingByte="); Serial.println(incomingByte);
    pos=mapf((float)incomingByte,0,99,up_pos,down_pos);  // BLEから送られて来る０－９９の値をup_pos,down_posの間にマッピング
    def=incomingByte-tmp;                                // 首のブレを考慮して送られて来るデータに２以上の差が有る場合に動作
    def=abs(def);                                        //　差分の絶対値を計算
    if(def>2){                                           //　2以上なら駆動する   
      move(int(pos),10);                                   //  ９０ｍｓでＰＯＳ位置まで移動
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

/*********************************************************************

// UUIDs:6e400001-b5a3-f393-e0a9-e50e24dcca9e
// UUIDc:6e400002-b5a3-f393-e0a9-e50e24dcca9e

*********************************************************************/

#include <bluefruit.h>
#include <Adafruit_LittleFS.h>
#include <InternalFileSystem.h>
#include <Adafruit_DotStar.h>
#include <stdio.h>
#include <string>
#define WAKE_LOW_PIN  PIN_A1
#define WST       "/W.txt"

// There is only one pixel on the board
#define NUMPIXELS 1 
#define DATAPIN    8
#define CLOCKPIN   6
#define on   0
#define off  1

using namespace Adafruit_LittleFS_Namespace;

uint32_t       color=0x000000;      // 'On' color (starts red)

/*
B=0x000000;
b=0x0000ff;
r=0x00ff00;
m=0x00ffff;
g=0xff0000;
c=0xff00ff;
y=0xffff00;
w=0xffffff;
uint32_t y=0xb4f633; 
uint32_t g=0x844624; 
uint32_t m=0x00923b;
*/
uint32_t y=0x0000ff; 
uint32_t g=0xff0000; 
uint32_t m=0x00923b;


char ad_name[4][15]={"bFaaaPSwitch_1","bFaaaPSwitch_2","bFaaaPSwitch_3","bFaaaPSwitch_4"};                    
int               n=0;
int               c=0;
int               rr=1;
unsigned long     tt;
int               b=1;
int               f=0;
unsigned long     btmp=0;
String            Model("pFaaaPSwitch");

Adafruit_DotStar strip(NUMPIXELS, DATAPIN, CLOCKPIN, DOTSTAR_BRG);

File file(InternalFS);

// BLE Service
BLEDfu  bledfu;  // OTA DFU service
BLEDis  bledis;  // device information
BLEUart bleuart; // uart over ble
BLEBas  blebas;  // battery

void setup()
{
  uint32_t readlen;
  char buffer[15]={0}; 
  char buffer2[1000]={0};  
  int i;

  #if CFG_DEBUG
      // Blocking wait for connection when debug mode is enabled via IDE
      while ( !Serial ) yield();
  #endif
  
  pinMode(13, OUTPUT);
  pinMode(A1, INPUT_PULLUP);
//  Serial.begin(115200);
//  while ( !Serial ) delay(10);   // for nrf52840 with native usb

  tt=millis();
  btmp=tt+500;
  tt=tt+30000; 
  // setup for DOTSTAR  
  strip.begin(); // Initialize pins for output
  strip.setBrightness(100);
  LED(off,g);
  LED(on,y);

  Bluefruit.autoConnLed(false); //true/false
  
  // Config the peripheral connection with maximum bandwidth 
  // more SRAM required by SoftDevice
  // Note: All config***() function must be called before begin()
  
  Bluefruit.configPrphBandwidth(BANDWIDTH_MAX);
  Bluefruit.begin();
  Bluefruit.setTxPower(-4);    // Check bluefruit.h for supported values

  // Initialize Internal File System
  InternalFS.begin();
  
  file.open(WST, FILE_O_READ);
  // file existed
  if ( file ){
      readlen = file.read(buffer2, sizeof(buffer2));
      i=buffer2[readlen-1]-0x30;
      file.close();
      Bluefruit.setName(ad_name[i]);
//      Serial.println(buffer);
  }
  // not file existed
  else{
       file.close();
       file.open(WST, FILE_O_WRITE);          
       file.write("0");
       file.close();
       Bluefruit.setName(ad_name[0]);
  }
  
  //Bluefruit.setName(getMcuUniqueID()); // useful testing with multiple central connections
  Bluefruit.Periph.setConnectCallback(connect_callback);
  Bluefruit.Periph.setDisconnectCallback(disconnect_callback);

  // To be consistent OTA DFU should be added first if it exists
  bledfu.begin();

  // Configure and Start Device Information Service
  bledis.setManufacturer("bFaaaP factory");
  bledis.setModel(Model.c_str());
  bledis.begin();

  // Configure and Start BLE Uart Service
  bleuart.begin();

  // Start BLE Battery Service
  blebas.begin();
  blebas.write(100);

  // Set up and start advertising
  startAdv();

  LED(on,y);

}

void startAdv(void)
{
  // Advertising packet
  Bluefruit.Advertising.addFlags(BLE_GAP_ADV_FLAGS_LE_ONLY_GENERAL_DISC_MODE);
  Bluefruit.Advertising.addTxPower();
  
  // Include bleuart 128-bit uuid
  Bluefruit.Advertising.addService(bleuart);
  
  // Secondary Scan Response packet (optional)
  // Since there is no room for 'Name' in Advertising packet
  Bluefruit.ScanResponse.addName();
  Bluefruit.Advertising.restartOnDisconnect(true);
  Bluefruit.Advertising.setInterval(32, 244);    // in unit of 0.625 ms
  Bluefruit.Advertising.setFastTimeout(30);      // number of seconds in fast mode
  Bluefruit.Advertising.start(0);                // 0 = Don't stop advertising after n seconds 
   
}

void LED(int onoff,uint32_t colors)
{
uint32_t tmp;  
  if(onoff==0)
    strip.setPixelColor(0, colors|color);
  else{
    colors=0Xfffff^colors;
    strip.setPixelColor(0, colors&color); 
  }    
  strip.show(); // Update strip with new contents
  
}

void deep_sleep()
{
       LED(off,g);
       LED(off,m);
       digitalWrite(LED_RED, LOW);
       digitalWrite(13,LOW);         
//       while(digitalRead(A1)==LOW);
       pinMode(WAKE_LOW_PIN,  INPUT_PULLUP_SENSE);    // this pin (WAKE_LOW_PIN) is pulled up and wakes up the feather when externally connected to ground.
       // power down nrf52.
       sd_power_system_off();                         // this function puts the whole nRF52 to deep sleep (no Bluetooth).  If no sense pins are setup (or other hardware interrupts), the nrf52 will not wake up.  
}

void loop()
{
  //int plen;
  uint32_t readlen;
  char buffer[15]={0}; 

  // Forward from BLEUART to HW Serial
  while ( bleuart.available() )
  {
    uint8_t ch;
    int i;
    ch = (uint8_t) bleuart.read();
    
    //for N (pedal on)
    if(ch==0x4e){
                 digitalWrite(LED_RED, HIGH); 
                 LED(off,g); 
                 LED(on,m);
                 if(rr==1){
                    digitalWrite(13,HIGH); //on at on mode
                 } 
                 else{ 
                    digitalWrite(13,LOW);  //on at off mode
                 } 
    }
    // for F (pedal off)
    if(ch==0x46){ // F
                 digitalWrite(LED_RED, LOW);
                 LED(off,m); 
                 LED(on,g);
                 
                 if(rr==1){                  
                    digitalWrite(13,LOW);   //off at on mode
                 } 
                 else{
                    digitalWrite(13,HIGH);  //off at off mode
                 } 
    }
    /*
    if(ch==0x43){      // C111200123255128000222111000255/  C111 200 123 255 128 000 222 111 000 255/ 
       char buffer[28] = { 0 };
       char tmp[4]={0,0,0,0};
       String ttmp;
       readlen=0;
       while ( bleuart.available() ) {
             ch=(uint8_t) bleuart.read();
             if(ch==0x2f){ // /
                if(readlen!=29) break;
                else{
                     buffer[readlen]=0;
                     strncpy(tmp,buffer,3);
                     ttmp=tmp;
                     y=ttmp.toInt()*0xff0000;
                     strncpy(tmp,buffer+3,3);
                     ttmp=tmp;
                     y+=ttmp.toInt()*0xff00;
                     strncpy(tmp,buffer+6,3);
                     ttmp=tmp;
                     y+=ttmp.toInt()*0xff;
                     strncpy(tmp,buffer+9,3);
                     ttmp=tmp;
                     g=ttmp.toInt()*0xff0000;
                     strncpy(tmp,buffer+12,3);
                     ttmp=tmp;
                     g+=ttmp.toInt()*0xff00;
                     strncpy(tmp,buffer+15,3);
                     ttmp=tmp;
                     g+=ttmp.toInt()*0xff;
                     strncpy(tmp,buffer+18,3);
                     ttmp=tmp;
                     m=ttmp.toInt()*0xff0000;
                     strncpy(tmp,buffer+21,3);
                     m+=ttmp.toInt()*0xff00;
                     strncpy(tmp,buffer+24,3);
                     ttmp=tmp;
                     m+=ttmp.toInt()*0xff;
                }
             }
             buffer[readlen]=ch;
             readlen++;
             if(readlen==30) break;
       }
    }
    */
    if(ch==0x66){ //f (chenge off mode)
       rr=0;
    }
    if(ch==0x6e){ //n (chenge on mode)
       rr=1;       
    }
    if(ch==0x57){ // chenge ch1 "W"
        file.open(WST, FILE_O_WRITE);          
        file.write("0");
        file.close();
        deep_sleep();
    }
    if(ch==0x58){ // chenge ch2 "X"
        file.open(WST, FILE_O_WRITE);          
        file.write("1");
        file.close();
        deep_sleep();       
    }
    if(ch==0x59){ // chenge ch3 "Y"
        file.open(WST, FILE_O_WRITE);          
        file.write("2");
        file.close();
        deep_sleep();
    }
    if(ch==0x5A){ // chenge ch4 "Z"
        file.open(WST, FILE_O_WRITE);          
        file.write("3");
        file.close();
        deep_sleep();  //void(*resetFunc)(void)=0;     
    }
    
    if(ch==0x50) deep_sleep(); // P
     
  }
  
  // deep_sleep after 30 seconds if c is zero  c is timeout stop flag
  if((millis()>tt)&&(c==0)){    
     deep_sleep();
  }

  if((millis()>btmp)&&(c==0)){
     btmp=btmp+500-b*5;
     if(f==0){
      LED(off,y);
      f=1;
     }else{
      LED(on,y);
      f=0;
     }
     b++;
  }   


  // deep_Sleep when the button is pressed for 5 seconds or longer
  // An alternative button port when the reset button is inconvenient
  if(digitalRead(A1)==LOW){
     delay(5000);
     if(digitalRead(A1)==LOW){
       deep_sleep();
     }
  }

}

// callback invoked when central connects
void connect_callback(uint16_t conn_handle)
{
  // Get the reference to current connection
  BLEConnection* connection = Bluefruit.Connection(conn_handle);
  char central_name[32] = { 0 };
  connection->getPeerName(central_name, sizeof(central_name));
  strip.setBrightness(20);
  digitalWrite(LED_RED, LOW);
  LED(on,g);
  c=1;  // timeout stop flag
}

void disconnect_callback(uint16_t conn_handle, uint8_t reason)
{
  (void) conn_handle;
  (void) reason; 
  c=0;
  tt=millis()+30000;
  btmp=tt-29500;
  digitalWrite(LED_RED, LOW);
  digitalWrite(13,LOW);
  strip.setBrightness(100); 
  LED(off,g); 
  LED(on,y);

}

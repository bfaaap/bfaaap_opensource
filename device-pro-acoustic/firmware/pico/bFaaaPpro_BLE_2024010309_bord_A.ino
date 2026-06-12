/*********************************************************************

// UUIDs:6e400001-b5a3-f393-e0a9-e50e24dcca9e
// UUIDc:6e400002-b5a3-f393-e0a9-e50e24dcca9e

*********************************************************************/

#include <bluefruit.h>
#include <Adafruit_LittleFS.h>
#include <InternalFileSystem.h>
#include <stdio.h>
#include <string>
// #define WAKE_LOW_PIN  PIN_A1
#define WST       "/W.txt"

// There is only one pixel on the board
// #define NUMPIXELS 1 
// #define DATAPIN    8
// #define CLOCKPIN   6
#define on   0
#define off  1

using namespace Adafruit_LittleFS_Namespace;

char ad_name[4][15]={"bFaaaPSwitch_1","bFaaaPSwitch_2","bFaaaPSwitch_3","bFaaaPSwitch_4"};                    
int               n=0;
int               c=0;
int               rr=1;
int               b=1;
int               f=0;
String            Model("pFaaaPSwitch");

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
  
//  pinMode(13, OUTPUT);
  Serial1.begin(115200);
//  while ( !Serial ) delay(10);   // for nrf52840 with native usb


  Bluefruit.autoConnLed(true); //true/false
  
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

void loop()
{
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
                 if(rr==1){
                    digitalWrite(13,HIGH); //on at on mode
                 } 
                 else{ 
                    digitalWrite(13,LOW);  //on at off mode
                 } 
    }
    // for F (pedal off)
    if(ch==0x46){ // F
                 if(rr==1){                  
                    digitalWrite(13,LOW);   //off at on mode
                 } 
                 else{
                    digitalWrite(13,HIGH);  //off at off mode
                 } 
    }

    if(ch==105){      // i
       char buffer[3] = { 0 };
       /*
       if ( bleuart.available() ) {
             ch=(uint8_t) bleuart.read();
             buffer[0]=ch;
       }
       Serial1.print(buffer[0]);
       */
       /*
       if ( bleuart.available() ) {
             ch=(uint8_t) bleuart.read();
             buffer[0]=ch;
       }
       if ( bleuart.available() ) {
             ch=(uint8_t) bleuart.read();
             buffer[1]=ch;
       }
       */
       buffer[0]=(uint8_t) bleuart.read();
       buffer[1]=(uint8_t) bleuart.read();
       buffer[2]=0;
       Serial1.print((char)atoi(buffer));
       Serial.println(buffer);
       Serial.println((char)atoi(buffer));
    }    
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
//      deep_sleep();
    }
    if(ch==0x58){ // chenge ch2 "X"
        file.open(WST, FILE_O_WRITE);          
        file.write("1");
        file.close();
//      deep_sleep();       
    }
    if(ch==0x59){ // chenge ch3 "Y"
        file.open(WST, FILE_O_WRITE);          
        file.write("2");
        file.close();
//      deep_sleep();
    }
    if(ch==0x5A){ // chenge ch4 "Z"
        file.open(WST, FILE_O_WRITE);          
        file.write("3");
        file.close();
//      deep_sleep();  //void(*resetFunc)(void)=0;     
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
}

void disconnect_callback(uint16_t conn_handle, uint8_t reason)
{
  (void) conn_handle;
  (void) reason; 
}

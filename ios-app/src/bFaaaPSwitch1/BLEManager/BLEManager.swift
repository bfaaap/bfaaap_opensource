//
//  BLEManager.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import UIKit
import CoreBluetooth
import PDFKit
import SwiftUI


class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate , CBPeripheralDelegate  {

    
    
    init(uiState:Binding<ViewID>, updateStatus:Binding<Set<Int>>, discoveryOnly:Bool) {
        _uiState = uiState
        _updateStatus = updateStatus
        self.discoveryOnly = discoveryOnly
    }
    var timer = Timer()
    
    var isBLEConnected = false;
    @Binding var uiState:ViewID
    @Binding var updateStatus: Set<Int>
    var discoveryOnly:Bool
    
    /// 接続先ローカルネーム
    //@Binding var connectToLocalName:String
    //var selectableDevices:[String]
    //       private let connectToLocalName:String = "M5Stack-Color"
    //    private let connectToLocalName:String = "DSD TECH"    /// CBCentralManagerインスタンス
    //       private let connectToLocalName:String = "SH-HC-08"
    static private var centralManager: CBCentralManager!
    /// 接続先Peripheral情報
    static private var connectToPeripheral: CBPeripheral!
    /// Write Characteristic
    private var writeCharacteristic: CBCharacteristic?
    /// Notify Characteristic
    private var notifyCharacteristic: CBCharacteristic?
    
    //centralManagerの初期化
    func setup() {
        BLEManager.centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    func deviceConnected() -> Bool {
        return self.isBLEConnected
    }
    
    //MStack側へのtext送信
    
    func changeChannel(channelID: Int){
        switch channelID {
        case 0:
            _ = self.sendString(sendText: "W")
            print("名前を「bFaaaPSwitch_1」に変更しました")
        case  1:
            _ = self.sendString(sendText: "X")
            print("名前を「bFaaaPSwitch_2」に変更しました")
        case 2:
            _ = self.sendString(sendText: "Y")
            print("名前を「bFaaaPSwitch_3」に変更しました")
        case 3:
            _ = self.sendString(sendText: "Z")
            print("名前を「bFaaaPSwitch_4」に変更しました")
        default:
            _ = self.sendString(sendText: "W")
            print("名前を「bFaaaPSwitch_1」に変更しました")
            
        }
    }
    
    func changeSwitchType(switchOn: Bool) {
        if switchOn == true{
            _ = self.sendString(sendText: "n")
            print("ontypeへの切り替え用にnを送信しました")
        } else{
            _ = self.sendString(sendText: "f")
            print("offtypeへの切り替え用にfを送信しました")
        }
    }
    
    func sendString(sendText:String) -> Bool {
        var result = false
        if let sendData = sendText.data(using: .utf8, allowLossyConversion: true) , let characteristic = writeCharacteristic , let peripheral = BLEManager.connectToPeripheral {
            peripheral.writeValue(sendData, for: characteristic , type: .withoutResponse)
            result = true
        }
        return result
    }
    
    
    //disconnectする
    func disconnect() {
        self.isBLEConnected = false
        if let tempconnectToPeripheral = BLEManager.connectToPeripheral {
            BLEManager.centralManager.cancelPeripheralConnection(tempconnectToPeripheral)
        }
    }
    
    func reconnect (isBLEConnected:Binding<Bool>){
        //_isBLEConnected = isBLEConnected
        if let tempBLENameString = UserDefaults.standard.object(forKey: "BLEName")  {
            AppSetting.connectToLocalName = tempBLENameString as! String}
        BLEManager.centralManager.scanForPeripherals(withServices: nil, options: nil)
//        var knownCBUUIDs = [centralManager.retrieveConnectedPeripherals]
////        var peripherals_retrieved = centralManager.retrievePeripherals(withIdentifiers: knownUUIDs)
//        let peripherals_retrieved = centralManager.retrieveConnectedPeripherals(withServices: knownCBUUIDs)
//        if peripherals_retrieved.count != 0{
//            connect(peripherals_retrieved[0],options:nil)
//        }
    }
    
    private func connect(_ peripheral: CBPeripheral,
                         options: [String : Any]? = nil){
        
    }
    
    //Delegateのprotocol関数を含める制御関数
    
    private func scanForPeripherals() {
        BLEManager.centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    private func connectPeripheral() {
        BLEManager.centralManager.stopScan()
        BLEManager.centralManager.connect(BLEManager.connectToPeripheral, options: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            debugLog("poweredOff")
        case .unknown:
            debugLog("unknown")
        case .resetting:
            debugLog("resetting")
        case .unsupported:
            debugLog("unsupported")
        case .unauthorized:
            debugLog("unauthorized")
        case .poweredOn:
            debugLog("poweredOn")
            scanForPeripherals()
        @unknown default:
            debugLog("unknown error")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let uuid = UUID(uuid: peripheral.identifier.uuid)
        if let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            debugLog("UUID=[\(uuid)] Name=[\(localName)]")
            print("didDiscover peripheralが呼ばれました。")
            let localName = localName.trimmingCharacters(in: .whitespacesAndNewlines)
            print("localNameは\(localName)")

            if DeviceCache.knownDeviceNames().contains(localName) {
                self.updateStatus.insert(Int(String(localName.last!))!)
//              print("localNamesは\(self.localNames)")
                //print("localNamesは\(self.localNames)")
                print("connectToLocalNameは\(AppSetting.connectToLocalName)")
                if localName == AppSetting.connectToLocalName {
                    print("connectToPeriferal = periferalの処理の前を通過")
                    BLEManager.connectToPeripheral = peripheral
                    connectPeripheral()
                    //send true back to the SwiftUI View
                    
                    self.isBLEConnected = true
                    if !self.discoveryOnly {
                        self.uiState = ViewID.start_play
                    }
                    print("didDiscover peripheralでself.isBLEConnected = trueに設定しました")

                } else {
                    //send false back to the SwiftUI View
                    debugLog("UUID=[\(uuid)] Name=[\(localName)] connectToLocalName[\(AppSetting.connectToLocalName)]")
                    debugLog("in=[\(localName.count)] ble=[\(AppSetting.connectToLocalName.count)]")
                    self.isBLEConnected = false
                    
                    print("didDiscover peripheralでself.isBLEConnected = falseに設定しました")
                }
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheralDiscoverServices()
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            debugLog("error:unkown")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        BLEManager.connectToPeripheral = nil
        writeCharacteristic = nil
        notifyCharacteristic = nil
        scanForPeripherals()
    }
    
    //MARK:- CBPeripheralDelegate
    private func peripheralDiscoverServices() {
        BLEManager.connectToPeripheral.delegate = self
        BLEManager.connectToPeripheral.discoverServices(nil)
    }
    
    private func peripheralDiscoverCharacteristics(service: CBService) {
        BLEManager.connectToPeripheral.discoverCharacteristics(nil, for: service)
    }
    
    private func peripheralNotifyStart() {
        if let characteristic = notifyCharacteristic {
            BLEManager.connectToPeripheral.setNotifyValue(true, for: characteristic)
            debugLog(characteristic.uuid)
        }
    }
    
    private func peripheralNotifyStop() {
        if let characteristic = notifyCharacteristic {
            BLEManager.connectToPeripheral.setNotifyValue(false, for: characteristic)
            debugLog(characteristic.uuid)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            if let services = peripheral.services {
                for service in services {
                    debugLog("service uuid = \(service.uuid.uuidString)")
                    peripheralDiscoverCharacteristics(service: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                    debugLog("characteristic = \(characteristic)")
                    switch characteristic.properties {
                    case .write:
                        debugLog("write")
                        writeCharacteristic = characteristic
                    case .notify:
                        debugLog("notify")
                        notifyCharacteristic = characteristic
                        peripheralNotifyStart()
                    default:
                        //CBUUID.init(string:"6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
                        if characteristic.uuid == CBUUID.init(string:"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"){
                            writeCharacteristic = characteristic
                            // notifyCharacteristic = characteristic
                            peripheralNotifyStart()
                            debugLog("writte/notify")
                            
                        }
                        
                        
                        debugLog("unknown")
                    }
                }
            }
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        if let error = error {
            debugLog("error:\(error)")
        } else {
            debugLog("ok")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            debugLog("error:\(error) uuid:\(characteristic.uuid)")
        } else {
            debugLog("ok uuid:\(characteristic.uuid)")
            //labelWrite(text: "notify ok")
        }
    }
    
    
    //peripheralのM5Stackからの信号の処理によりpdfを譜めくりする
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            debugLog("error:\(error) uuid:\(characteristic.uuid)")
        } else {
            if let value = characteristic.value , let str = String(data: value, encoding: .utf8) {
                debugLog("\(str)")
                DispatchQueue.main.async {
                    debugLog("\(str)")
                }
            }
        }
    }
}






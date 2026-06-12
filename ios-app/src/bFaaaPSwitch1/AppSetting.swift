//
//  AppSetting.swift
//  bFaaaPSwitch1
//
//  Created by J O on 10/4/21.
//

import Foundation

enum ViewID {
    case connect_ble
    case start_play
    case show_support
    case edit_channel
}

class AppSetting: NSObject, ObservableObject {
    
    static let BLE_INITIAL_NAME = "bFaaaPSwitch_1"
    static var connectToLocalName: String = AppSetting.BLE_INITIAL_NAME
    static var isSwitchOnType: Bool = true
    static var isGlobalSwitchOnType: Bool = true
    static var tempBLEChangeName: String = AppSetting.BLE_INITIAL_NAME
    static var showInitialMessage = true
    
    override init() {
        if let tempBLEName = UserDefaults.standard.object(forKey: "BLEName")  {
            AppSetting.connectToLocalName = tempBLEName as! String
            AppSetting.tempBLEChangeName = AppSetting.connectToLocalName
        } else {
            //初回は定数値を入れる
            AppSetting.connectToLocalName = AppSetting.BLE_INITIAL_NAME
        }
        //UserDefaultsの値の読み込み(selectedIndex)
        if let tempIndex = UserDefaults.standard.object(forKey: "selectedIndex")  {
            DeviceCache.selectRowBySwitchId(id: tempIndex as! Int)
            DeviceCache.selectedIndex = tempIndex as! Int
        } else {
            //初回は定数値を入れる
            DeviceCache.selectRowBySwitchId(id: 0)
        }

        if let tempIsSwitchOnType = UserDefaults.standard.object(forKey: "isSwitchOnType") {
            AppSetting.isSwitchOnType = tempIsSwitchOnType as! Bool
            AppSetting.isGlobalSwitchOnType = tempIsSwitchOnType as! Bool
        }
    }
    
    static func persistBleName(bleName: String) {
        AppSetting.connectToLocalName = bleName
        AppSetting.tempBLEChangeName = bleName
        UserDefaults.standard.set(bleName, forKey: "BLEName")
    }
    
    static func persistBleByChannelId(id: Int) {
        let bleName = DeviceCache.getSwitchNameById(id: id)
        AppSetting.persistBleName(bleName: bleName)
    }
    
    static func persistSelectedIndex(index: Int) {
        DeviceCache.selectedIndex = index
        AppSetting.connectToLocalName = DeviceCache.getSwitchNameById(id: index)
        DeviceCache.selectRowBySwitchId(id: index)
        UserDefaults.standard.set(index, forKey: "selectedIndex")
    }
    
    static func persistSwitchOnType(switchType: Bool) {
        AppSetting.isSwitchOnType = switchType
        AppSetting.isGlobalSwitchOnType = switchType
        UserDefaults.standard.set(switchType, forKey: "isSwitchOnType")
        UserDefaults.standard.synchronize()
    }
    
    static func persistChannelIfChanged(index: Int) {
        if index != DeviceCache.selectedIndex {
            AppSetting.connectToLocalName = DeviceCache.getSwitchNameById(id: index)

            AppSetting.persistBleName(bleName: AppSetting.connectToLocalName)
            AppSetting.persistSelectedIndex(index: index)
            
            DeviceCache.selectedIndex = index
            DeviceCache.selectRowBySwitchId(id: index)
        }
    }
}

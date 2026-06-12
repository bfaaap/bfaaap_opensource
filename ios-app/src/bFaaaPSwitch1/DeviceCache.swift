//
//  SelectableRow.swift
//  bFaaaPSwitch1
//
//  Created by J O on 10/4/21.
//

import Foundation
import SwiftUI

struct SwitchDevice {
    let id = UUID()
    let name: String
    var notFound: Bool
    
    init(name: String, notFound: Bool) {
        self.name = name
        self.notFound = notFound
    }
}

struct DeviceCache {
    
    var deviceName: String
    @State var isSelected = false
    
    static var devicenameToRow: [String: DeviceCache] = [:]
    static let switchNameBase = "bFaaaPSwitch_"
    static var selectedIndex: Int = 0
    var deviceNotFound = true
    static var switchCandidateCount = 4
    static var switchDevices: [SwitchDevice] = []
    
    init(_ deviceName: String, found: Bool) {
        self.deviceName = deviceName
        self.deviceNotFound = found
        DeviceCache.devicenameToRow[deviceName] = self
    }
    
    static func setDeviceSpec(devices: [SwitchDevice]) {
        DeviceCache.switchDevices = devices
    }
    
    static func knownDeviceNames() -> [String]{
        var devices : [String] = []
        for i in 0...self.switchCandidateCount {
            devices.append(switchNameBase + String(i))
        }
        return devices
    }
        
    static func selectRowByName(name: String)
    {
        // reset all devices while searching
        var rowFound : DeviceCache? = nil
        DeviceCache.devicenameToRow.forEach { key, row in
            row.unselect()
            if row.deviceName == name {
                rowFound = row
            }
        }
        
        // select only the found
        if rowFound != nil {
            rowFound!.select()
            DeviceCache.selectedIndex = DeviceCache.knownDeviceNames().firstIndex(of: name)!
        }
    }
    
    static func selectRowBySwitchId(id: Int)
    {
        DeviceCache.selectedIndex = id
        let deviceName = DeviceCache.getSwitchNameById(id: id)
        DeviceCache.selectRowByName(name: deviceName)
    }
    
    // id starts from 0
    static func getSwitchNameById(id: Int) -> String {
        return "bFaaaPSwitch_" + String(id+1)
    }
    
    static func getCurrentSelectedSwitchName() -> String? {
        var name : String? = nil
        if DeviceCache.devicenameToRow.count > 0  {
            name = DeviceCache.getSwitchNameById(id: DeviceCache.selectedIndex)
        }
        return name
    }
    
    func unselect() {
        self.isSelected = false
    }
    
    func unselectAll() {
        DeviceCache.devicenameToRow.forEach { key, device in
            device.unselect()
        }
    }
    
    func select() {
        isSelected = true
        let indexFound = DeviceCache.knownDeviceNames().firstIndex(of: self.deviceName)
        if indexFound != nil {
            DeviceCache.selectedIndex = indexFound!
            UserDefaults.standard.set(DeviceCache.getSwitchNameById(id: DeviceCache.selectedIndex), forKey: "BLEName")
            UserDefaults.standard.set(DeviceCache.selectedIndex, forKey: "selectedIndex")
        }
    }
    
    static func resetDevicesCache() {
        DeviceCache.devicenameToRow.removeAll()
    }
}

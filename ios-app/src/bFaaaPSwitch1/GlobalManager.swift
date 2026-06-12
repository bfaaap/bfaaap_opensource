//
//  GlobalManager.swift
//  bFaaaPSwitch1
//
//  Created by J O on 10/4/21.
//

import Foundation

class GlobalManager: ObservableObject {
    @Published var bleManager: BLEManager!;
    @Published var appSetting: AppSetting;
    @Published var deviceSpec: [SwitchDevice]
    
    init() {
        appSetting = AppSetting()
        deviceSpec = [
            SwitchDevice(name: "bFaaaPSwitch_1", notFound: true),
            SwitchDevice(name: "bFaaaPSwitch_2", notFound: true),
            SwitchDevice(name: "bFaaaPSwitch_3", notFound: true),
            SwitchDevice(name: "bFaaaPSwitch_4", notFound: true),
        ]
        DeviceCache.setDeviceSpec(devices: deviceSpec)
    }
}

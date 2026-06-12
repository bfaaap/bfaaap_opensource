//
//  AudioManager.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import Foundation
import SwiftUI
import AVFoundation

final class AudioManager: NSObject, ObservableObject {
    
    init (isSoundOn: Binding<Bool>) {
        self._isSoundOn = isSoundOn
    }
    
    @Binding var isSoundOn:Bool
    private var switchOnCount = 0
    
    //Sound to be transmitted via Bluetooth
    private let Sound_A3 = try! AVAudioPlayer(data: NSDataAsset(name: "Sound_8000")!.data)
    
    func switchSoundOn() {
        
        if switchOnCount > 0  {
            switchOnCount += 1
        } else {
            Sound_A3.prepareToPlay()
            switchOnCount += 1
        }
        
        DispatchQueue.global().async {
            
            while self.isSoundOn {
                self.Sound_A3.play()
            }
            self.Sound_A3.stop()
            //最初の位置まで巻き戻す。
            self.Sound_A3.currentTime = 0
        }
    }
    func switchSoundOff() {
        self.isSoundOn = false
        self.Sound_A3.stop()
        //最初の位置まで巻き戻す。
        self.Sound_A3.currentTime = 0
    }
}


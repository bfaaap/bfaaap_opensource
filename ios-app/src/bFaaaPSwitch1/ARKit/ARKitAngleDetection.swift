//
//  ARKitAngleDetection.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import ARKit
import Combine
import SwiftUI

final class ARKitAngleDetection: NSObject, ObservableObject, ARSessionDelegate {

    //BLE通信のため
    //@State変数で規定するBluetooth制御
    var managerForBLE: BLEManager!
    
    init(managerForBLE: BLEManager, leftY: Binding<Float>) {
        self.managerForBLE = managerForBLE
        _leftY = leftY
        
    }
     
    // ARSession
    let session = ARSession()
    
    //Left Eye Angle Data
    @Published var leftX:Float = 0.0
    @Binding var leftY: Float

    //ある幅以上に変わった場合にBLE通信するための前回設定値とその幅
    var previousLeftY: Float = 0.0
    let margineForLeftY:Float = 1.0
    
    //PageAction
    // var angleThreshold: Float =  5.0 UserDataでpublicに指定
    @Published var pageAction = PageAction.neutral
    
    //時間差でBLEを動かすためのreference変数
    var previousTimeInterval = Date().timeIntervalSince1970
    
    //Pedal state
    @Published var pedalState = OnOffState.off
    
    
    func resetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        //delegate設定
        self.session.delegate = self
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func stopTracking() {
        
        self.session.pause()
        
    }
    
    
    
    //MARK:- ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        frame.anchors.forEach { anchor in
            guard #available(iOS 12.0, *), let faceAnchor = anchor as? ARFaceAnchor else { return }
            //Y方向の動き
            let leftYRadian = faceAnchor.transform.columns.2.y //顔の角度だけにする目の角度は入れない+ faceAnchor.leftEyeTransform.columns.2.y
            self.leftY = leftYRadian.radiansToDegrees
 //GlobalOffset以上の場合にある一定間隔（ここでは0.01s)でBLE信号を送る。isGlobalSwitchOnTypeのTypeに依存して切り替え
            let date = Date()
            let timeInterval = date.timeIntervalSince1970
            
            //switchOnTypeの場合もoffの場合もペダルを踏み込むオンの際にはN、オフの場合はFを送る
            if ((timeInterval - self.previousTimeInterval) > 0.01), (-(Int(self.leftY)) >= globalOffset), (pedalState == OnOffState.off){
//                _ = self.managerForBLE.sendString(sendText: "\(-Int(self.leftY*100))\n")
                //適当な文字列を成澤さんよりもらって変更:sendText: "SwitchOn\n"
                _ = self.managerForBLE.sendString(sendText: "N")
                print("onシグナルNを送信しました")
                //pedalStateをonにする
                pedalState = OnOffState.on
                //previousTimeIntervalも更新する
                self.previousTimeInterval = timeInterval
                print("timeintervalは\(timeInterval)")
            }
            
            if ((timeInterval - self.previousTimeInterval) > 0.01), (-(Int(self.leftY)) < globalOffset -  1), (pedalState == OnOffState.on){
//                _ = self.managerForBLE.sendString(sendText: "\(-Int(self.leftY*100))\n")
                //適当な文字列を成澤さんよりもらって変更:sendText: "SwitchOn\n"
                _ = self.managerForBLE.sendString(sendText: "F")
                print("offシグナルFを送信しました")
                //pedalStateをofにする
                pedalState = OnOffState.off
                //previousTimeIntervalも更新する
                self.previousTimeInterval = timeInterval
                print("timeintervalは\(timeInterval)")
            }
            
             
        }
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {}
    
    
    
    
    
}



extension FloatingPoint {
    
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
    
}

enum PageAction {
    case back
    case neutral
    case next
    
}

enum OnOffState {
    case on
    case off
}
//AngleDetectionの角度域値
public var angleThreshold:Float = 5.0

//Globalなoffsetとmultiplierの
public var globalOffset = 0
public var globalMultiplier = 1.0

//Switch on-type or off-type切り替えのため
public var isGlobalSwitchOnType = true

struct ARKitAngleDetection_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}


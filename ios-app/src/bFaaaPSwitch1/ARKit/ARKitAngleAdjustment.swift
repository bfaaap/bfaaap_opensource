//
//  ARKitAngleAdjustment.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2021/05/21.
//

import ARKit
import Combine
import SwiftUI

final class ARKitAngleAdjustment: NSObject, ObservableObject, ARSessionDelegate {
    
    init(leftY: Binding<Float>) {
        _leftY = leftY
    }
    
    // ARSession
    let session = ARSession()
    
    //Left Eye Angle Data
    @Published var leftX:Float = 0.0
    @Binding var leftY: Float
    
    
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
            
            // FaceAnchor
            //let left = faceAnchor.leftEyeTransform
            //X方向の動き
            let leftXRadian = faceAnchor.transform.columns.2.x // 顔の角度だけにする目の角度は入れない+ faceAnchor.leftEyeTransform.columns.2.x
            self.leftX = leftXRadian.radiansToDegrees
            
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {}
    
}


//
//  SettingView.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import SwiftUI
import ARKit

struct SettingView: View {
    
    //bFaaaP設定値
    @State private var offset: Int = 5
//    @State private var isSwitchOnType = true
    
    //ARKitでの制御用変数
    //Button State
    @State private var ARKitFlag = false
    @State private var angleDetector:ARKitAngleAdjustment!
    @State private var leftY: Float = 0.0
    
    //ARKitがsupportされていない時のAlertFlag
    @State private var showingARNotSupportedAlert = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            //            if !self.isBLEConnected {
            VStack{
//                Spacer()
//                Text("BLE Setting")
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(Color.white)
                
//                //Switch on-type or off-type切り替え
//                Button(action :{
//                    self.isSwitchOnType.toggle()
//                    isGlobalSwitchOnType = self.isSwitchOnType
//                    UserDefaults.standard.set(self.isSwitchOnType, forKey: "isSwitchOnType")
//                }) {
//                    if self.isSwitchOnType {
//                        Text("On-type")
//                            .font(.title2)
//                            .frame(width: 120, height: 60, alignment: .center)
//                            .foregroundColor(Color.white)
//                            .background(Color.red)
//                            .cornerRadius(15, antialiased: true)
//                    } else {
//                        Text("Off-type")
//                            .font(.title2)
//                            .frame(width: 120, height: 60, alignment: .center)
//                            .foregroundColor(Color.white)
//                            .background(Color.blue)
//                            .cornerRadius(15, antialiased: true)
//                    }
//                }
//
                
                Spacer()
                Text("Offset Setting")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
                
                HStack{
                    if ARKitFlag {
                        //   print("頭の傾き角度：\(Int(self.angleDetector.leftY))")
                        Text("Head Angle：\(-Int(self.leftY))")
                            .font(.title)
                        
                        //                           _ = self.managerForBLE.sendString(sendText: self.leftY)
                        //                        }
                        
                    } else {
                        
                        Text("AR Not Supported")
                            .font(.title)
                            .foregroundColor(.black)
                            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 5))
                        
                    }
                    
                }
                .padding()
                
                Button(action:{
                    //UserDefaultsに値を保存
                    UserDefaults.standard.set(-Int(self.leftY), forKey: "offset")
                    self.offset = -Int(self.leftY)
                    //ARKitを止める
                    self.angleDetector.stopTracking()
                    
                })
                {
                    Text("Save")
                        .font(.title)
                        .frame(width: 360, height: 60, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(15, antialiased: true)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                HStack{
                    Text("Set Offset Value: ")
                        .font(.title)
                    Text("\(self.offset)")
                        .font(.title)
                }
                
                Spacer()
                
            }//VStack最後の}
            .onAppear{
                //UserDefaultsの値の読み込み
                if let tempoffset = UserDefaults.standard.object(forKey: "offset")  {
                    globalOffset = tempoffset as! Int
                    
                }
                if let tempIsSwitchOnType = UserDefaults.standard.object(forKey: "isSwitchOnType") {
                    isGlobalSwitchOnType = tempIsSwitchOnType as! Bool
                }
                
                self.managerSettingUp()
            }//onAppearの最後の}
            .onDisappear{
                //画面が変わるとARKitのセッションをoffにしてbluetoothを止める
                self.angleDetector.stopTracking()
                self.ARKitFlag = false
                
            }
            
        }//ZStackの最後の}
        .edgesIgnoringSafeArea(.all)
        .padding(.top, 1)
        .padding(.bottom, 5)
        //.padding(.leading, 60)
        //.padding(.trailing, 60)
        .onAppear{
            //UserDefaultsの値の読み込み
            
            if let tempoffset = UserDefaults.standard.object(forKey: "offset")  {
                self.offset = tempoffset as! Int
                globalOffset = self.offset
            }
//            if let tempIsSwitchOnType = UserDefaults.standard.object(forKey: "isSwitchOnType") {
//                self.isSwitchOnType = tempIsSwitchOnType as! Bool
//                isGlobalSwitchOnType = tempIsSwitchOnType as! Bool
//            }
            
        }//onAppearの最後の}
        .onDisappear{
            //画面が変わるとARKitのセッションをoffにしてbluetoothを止める
            if self.angleDetector != nil {
                self.angleDetector.stopTracking()
                self.ARKitFlag = false
            }
            
        }
    }
    func managerSettingUp() {
        
        //cameraの機能チェック
        guard ARFaceTrackingConfiguration.isSupported else {
            self.ARKitFlag = false
            self.showingARNotSupportedAlert = true
            return }
        //ARSupported
        self.showingARNotSupportedAlert = false
        
        
        //ARKitの準備
        self.angleDetector = ARKitAngleAdjustment(leftY: self.$leftY)
        
        //ARKitをonにする
        self.ARKitFlag = true
        self.angleDetector.resetTracking()
        
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

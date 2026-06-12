//
//  PlayViewTest.swift
//  bFaaaPSwitch1
//
//  Created by ootaki on 2021/09/18.
//

import SwiftUI

struct PlayViewTest: View {
    private var frameWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    private var spacing: CGFloat {
        UIScreen.main.bounds.width / 20
    }
    @State var anglesetTapped = false
    @State private var leftY: Float = 0.0
    
    @State var isSupport = false
    //@State変数で規定するBluetooth制御
    @State var managerForBLE: BLEManager!
    @State var isBLEConnected = false
    @State var connectToLocalName = ""
    @State var BLENoConnectionFlag = false
    
    //on offタイプの切り替え用
    @State private var isSwitchOnType = true
    //name change の画面の表示用
    @State private var isNameChanged = false

    @State private var tempBLEChangeName = ""
    
    //localBLEの名前を表示し選択するため
    @State var localNames:[String] = []
    @State private var selectionValue: Int? = nil
 
    private let switchNames:[String] = ["bFaaaPSwitch_1","bFaaaPSwitch_2","bFaaaPSwitch_3","bFaaaPSwitch_4"]
    
    var body: some View {
        VStack{
            HStack {
                //Name changeのためのボタン
                Button(action: {
                    self.isNameChanged = true
                    self.isBLEConnected = false
                    
                }) {
                    Text("« Reset")
                        .font(.title2)
                        .padding()
                        .frame(width: frameWidth / 2 - spacing)
                        .foregroundColor(Color.white)
                        .background(Color.lightGray).opacity(0.6)
                        .cornerRadius(15, antialiased: true)
                }.padding(.trailing)
                //Angleのthresholdの設定
                Button(action: {
                    UserDefaults.standard.set(-Int(self.leftY), forKey: "offset")
                    globalOffset = -Int(self.leftY)
                    
                    self.anglesetTapped.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.anglesetTapped = false
                    }
                }){
                    Text("Angle Set")
                        .font(.title2)
                        .padding()
                        .frame(width: frameWidth / 2 - spacing)
                        .scaleEffect(anglesetTapped ? 1.2 : 1.0)
                        .foregroundColor(Color.white)
                        .background(Color.middleGray).opacity(0.6)
                        .cornerRadius(15, antialiased: true)
                        .animation(.default.repeatCount(3).speed(2.0), value: anglesetTapped)
                }
            }.padding(.top) //ARKitFlag直下のHStack
            
            Spacer()
            ZStack{
                
                Circle()
                    .foregroundColor(anglesetTapped ? Color.red : Color.middleGray).opacity(0.1)
                    .frame(width: frameWidth / 2,height: frameWidth / 2)
                    .scaleEffect(anglesetTapped ? 1.2 : 1.0)
                    .animation(.default.repeatCount(3).speed(2.0), value: anglesetTapped)
                
                Text("\(-Int(self.leftY))")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                    .foregroundColor(Color.middleGray).opacity(0.8)
                    .scaledToFill()
                    
                
            }
            Spacer()
        }
    }
}




struct PlayViewTest_Previews: PreviewProvider {
    static var previews: some View {
        PlayViewTest()
    }
}

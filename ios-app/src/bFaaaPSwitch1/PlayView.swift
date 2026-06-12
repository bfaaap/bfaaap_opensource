//
//  ContentView.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import SwiftUI
import ARKit

class SliderValue: ObservableObject, Equatable {
    @Published var position: Double = 1.0 /*{
        willSet {
            objectWillChange.send()
        }
    }*/

    static func == (lhs: SliderValue, rhs: SliderValue) -> Bool {
        return lhs.position == rhs.position
    }
}

struct VerticalSlider: View {
    var sliderHeight:CGFloat
    @ObservedObject var sliderValue: SliderValue

    var appState: GlobalManager
    
    var body: some View {
        HStack{
            Spacer()

            Slider(
                value: $sliderValue.position,
                in: 0...20,
                step: 1.0
            ).rotationEffect(.degrees(-90.0), anchor: .topLeading)
            .frame(width: sliderHeight)
            .offset(y: sliderHeight)
            .onChange(of: self.sliderValue.position) { newValue in
                self.sliderChanged(to: newValue)
            }

            Spacer()
        }
    }
    func sliderChanged(to: Double) {
        // TODO save multiplier to DefaultStorage
    }
}

struct PlayView: View {
    @Environment(\.presentationMode) var presentationMode
    //@State変数で規定するBluetooth制御
    @State var appState = GlobalManager()
    @State var onTypeFlag = AppSetting.isSwitchOnType
    
    //ARKitでの制御用変数
    //Button State
    @State private var ARKitFlag = false
    @State private var angleDetector:ARKitAngleDetection!
    @State private var leftY: Float = 0.0
    
    //ARKitがsupportされていない時のAlertFlag
    @State private var showingARNotSupportedAlert = false
    @State private var selectionValue: Int? = nil
    
    private var frameWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    private var spacing: CGFloat {
        UIScreen.main.bounds.width / 20
    }
    
    @State private var userSelectedIndex = 0
    @State var anglesetTapped = false
    
    @State var updateStatus : Set<Int> = []
    @State var _selector: [DeviceCache] = []
        
    @State private var uiState : ViewID = ViewID.connect_ble
    
    @StateObject var sliderValue = SliderValue()
    
    private func connectAndUpdateBleList(discoveryOnly: Bool = false){
        // disconnect if connected
        if self.appState.bleManager != nil {
            self.appState.bleManager.disconnect()
        }
        
        // selection not happened as list does not appear yet
        self.appState.bleManager = BLEManager(uiState:self.$uiState, updateStatus: self.$updateStatus, discoveryOnly: discoveryOnly)
        
        self.appState.bleManager.setup()
    }
    @State private var timer: Timer?;
    
    //i05等の値を指定時間ごとに送るためのコード（0.005は5ms)
    private func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true){ _timer in
            let newLeftY = self.leftY
            let angleOffsetDiff = max(0, (-newLeftY) - Float(globalOffset))
            let multipliedAngleOffsetDiff = Int(angleOffsetDiff * Float(self.sliderValue.position))
            let multipliedAngle = min(Int(99), multipliedAngleOffsetDiff)
            let msgToSend = String(format: "i%02d", multipliedAngle);
            print(msgToSend);
            _ = self.appState.bleManager.sendString(sendText: msgToSend)
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        startTimer()
    }
    
    var body: some View {
        switch uiState {
        case .show_support:
            SupportPageView(uiState: self.$uiState)
        case .connect_ble:
            //show an initial BLE Name setting view
            ZStack {
                Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                VStack{
                    Spacer()
                    
                    VStack{
                        Text("チャネル確認")
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(Color.black)
                            .cornerRadius(15, antialiased: true)
                            .onTapGesture(count: 5) {
                                self.uiState = .start_play
                            }
                        
                        
                        HStack {
                            /*
                             Image(systemName: "circlebadge.fill")
                             .resizable()
                             .foregroundColor(Color.white)
                             .frame(width: 20, height: 20)
                             */
                            Text("青で表示されたチャネルボタンを押してください")
                                .font(.title3)
                                .foregroundColor(Color.black).opacity(0.8)
                            
                        }.padding([.top, .leading, .trailing])
                            .frame(width: frameWidth - spacing * 3, alignment: .leading)
                        
                    }// vstack
                    
                    Spacer()
                    
                    VStack{
                        HStack {
                            Button(action: {
                                let switchId = 0
                                AppSetting.persistBleByChannelId(id: switchId)
                                //self.appState.bleManager.changeChannel(channelID: switchId)
                                self.connectAndUpdateBleList()
                            })
                            {
                                Text("チャネル1")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(self.updateStatus.contains(1) ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }.disabled(!self.updateStatus.contains(1))
                        
                        HStack {
                            Button(action: {
                                let switchId = 1
                                AppSetting.persistBleByChannelId(id: switchId)
                                //self.appState.bleManager.changeChannel(channelID: switchId)
                                self.connectAndUpdateBleList()
                            })
                            {
                                Text("チャネル2")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(self.updateStatus.contains(2) ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }.disabled(!self.updateStatus.contains(2))
                        
                        HStack {
                            Button(action: {
                                let switchId = 2
                                AppSetting.persistBleByChannelId(id: switchId)
                                //self.appState.bleManager.changeChannel(channelID: switchId)
                                self.connectAndUpdateBleList()
                            })
                            {
                                Text("チャネル3")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(self.updateStatus.contains(3) ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }.disabled(!self.updateStatus.contains(3))
                        
                        HStack {
                            Button(action: {
                                let switchId = 3
                                AppSetting.persistBleByChannelId(id: switchId)
                                //self.appState.bleManager.changeChannel(channelID: switchId)
                                self.connectAndUpdateBleList()
                            })
                            {
                                Text("チャネル4")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(self.updateStatus.contains(4) ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }.disabled(!self.updateStatus.contains(4))
                        
                    }.padding([.top, .leading, .trailing])
                        .frame(width: frameWidth - spacing * 3, alignment: .leading)
                    
                    Spacer()
                    
                    
                }.padding([.top, .leading, .trailing])
                    .frame(width: frameWidth - spacing * 3, alignment: .leading)
                Spacer()
            }
            .onAppear{
                self.timer?.invalidate();
                //画面をbackgroundへ移行させない。
                UIApplication.shared.isIdleTimerDisabled = true
                
                self.connectAndUpdateBleList(discoveryOnly: true)
            }
        case .edit_channel:
            ZStack {
                Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                
                Spacer()
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            uiState = .start_play
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.black).opacity(0.3)
                                    .frame(width: 50,height: 50)
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, spacing * 1.0)
                        .padding(.leading, spacing)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text("チャネル変更")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    VStack{
                        HStack {
                            Button(action: {
                                self.userSelectedIndex = 0
                                self.appState.bleManager.changeChannel(channelID: self.userSelectedIndex)
                            })
                            {
                                Text("チャネル1を選択")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(userSelectedIndex == 0  ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                self.userSelectedIndex = 1
                                self.appState.bleManager.changeChannel(channelID: self.userSelectedIndex)
                            })
                            {
                                Text("チャネル2を選択")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(userSelectedIndex == 1  ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                self.userSelectedIndex = 2
                                self.appState.bleManager.changeChannel(channelID: self.userSelectedIndex )
                            })
                            {
                                Text("チャネル3を選択")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(userSelectedIndex == 2  ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }
                        
                        HStack {
                            Button(action: {
                                self.userSelectedIndex = 3
                                self.appState.bleManager.changeChannel(channelID: self.userSelectedIndex )
                            })
                            {
                                Text("チャネル4を選択")
                                    .font(.title2)
                                    .frame(width: frameWidth - spacing * 6, height: spacing * 4, alignment: .center)
                                    .foregroundColor(Color.white)
                                    .background(userSelectedIndex == 3  ? Color.blue : Color.gray).opacity(0.8)
                                    .cornerRadius(15, antialiased: true)
                            }
                        }
                        
                        Spacer()
                        
                        Text("選択後Switchの電源を入れてください")
                            .padding()
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                    } /* .padding([.top, .leading, .trailing])
                       .frame(width: frameWidth - spacing * 3, alignment: .leading) */
                    Spacer()
                    
                } /* .padding([.top, .leading, .trailing])
                   .frame(width: frameWidth - spacing * 3, alignment: .leading) */
                
            }/* .edgesIgnoringSafeArea(.all) */
            .onAppear{
                //画面をbackgroundへ移行させない。
                UIApplication.shared.isIdleTimerDisabled = true
                self.timer?.invalidate();
            }
        case .start_play:
            ZStack {
                //isSoundOnで色の切り替えをする
                if -(Int(self.leftY)) < globalOffset {
                    Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                } else {
                    Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
                }
                
                VStack(alignment: .center) {
                    if ARKitFlag {
                        HStack {
                            Button(action: {
                                self.uiState = .edit_channel
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
                                    .animation(.default.repeatCount(1).speed(1.0), value: anglesetTapped)
                            }
                        }.padding(.top) //ARKitFlag直下のHStack
                        
                        Spacer()
                        //   initial messageを10秒だけOnにする
                        if AppSetting.showInitialMessage {
                            Text("To start, move your head up and down once!")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(Color.middleGray).opacity(0.8)
                        }
                        HStack{
                            VStack{
                                ZStack{

                                    Circle()
                                        .foregroundColor(anglesetTapped ? Color.red : Color.middleGray).opacity(0.1)
                                        .frame(width: frameWidth / 2.5,height: frameWidth / 2.5)
                                        .scaleEffect(anglesetTapped ? 1.0 : 1.25)
                                        .animation(.default.repeatCount(1).speed(1.0), value: anglesetTapped)

                                    Text("\(-Int(self.leftY))")
                                        .font(.system(size: 80))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.middleGray).opacity(0.8)
                                        .scaledToFill()
                                }
                                /*
                                .onChange(of: self.leftY) { newLeftY in
                                    let angleOffsetDiff = max(0, (-newLeftY) - Float(globalOffset))
                                    let multipliedAngleOffsetDiff = Int(angleOffsetDiff * Float(self.sliderValue.position))
                                    let multipliedAngle = min(Int(99), multipliedAngleOffsetDiff)
                                    let msgToSend = String(multipliedAngle)
                                    _ = self.appState.bleManager.sendString(sendText: msgToSend)
                                }*/
                                Text("Head angle")
                                    .font(.title)
                                    .foregroundColor(Color.lightGray).opacity(0.6)
                                    .padding()
                                    .padding(.top)

                                Text("Multiplier: \(Int(self.sliderValue.position))")
                                    .font(.title)
                                    .foregroundColor(Color.lightGray).opacity(0.6)
                                    //.padding()
                                    //.padding(.top)
                                
                            }.frame(width: frameWidth - 80)
                            
                            Spacer()
                            
                            GeometryReader { geo in
                                VerticalSlider(
                                    sliderHeight: geo.size.height,
                                    sliderValue: sliderValue,
                                    appState: self.appState
                                )
                            }.frame(width: 80, height: frameWidth / 1.2)

                            Spacer()
                        }
                    } //ARKitFlagの終わり
                    
                    Spacer()
                    
                    HStack {
                        
                        if !self.ARKitFlag  {
                            Text("AR not supported.")
                                .font(.title)
                                .foregroundColor(.black)
                                .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 5))
                        } else{
                            //Supportに移動
                            Button(action: {
                                self.uiState = .show_support
                            }) {
                                Text("« Support")
                                    .font(.title2)
                                    .padding()
                                    .frame(width: frameWidth / 2 - spacing)
                                    .foregroundColor(Color.white)
                                    .background(Color.lightGray).opacity(0.6)
                                    .cornerRadius(15, antialiased: true)
                                
                            }.padding(.trailing)
                            //Switch on-type or off-type切り替え
                            Button(action :{
                                AppSetting.isSwitchOnType.toggle()
                                self.onTypeFlag = AppSetting.isSwitchOnType
                                AppSetting.persistSwitchOnType(switchType: AppSetting.isSwitchOnType)
  
                                //deviceに送信する
                                self.appState.bleManager.changeSwitchType(switchOn: AppSetting.isSwitchOnType)
                                
                            }) {
                                if self.onTypeFlag {
                                    Text("On-type")
                                        .font(.title2)
                                        .padding()
                                        .frame(width: frameWidth / 2 - spacing)
                                        .foregroundColor(Color.white)
                                        .background(Color.middleGray).opacity(0.6)
                                        .cornerRadius(15, antialiased: true)
                                } else {
                                    Text("Off-type")
                                        .font(.title2)
                                        .padding()
                                        .frame(width: frameWidth / 2 - spacing)
                                        .foregroundColor(Color.white)
                                        .background(Color.middleGray).opacity(0.6)
                                        .cornerRadius(15, antialiased: true)
                                }
                            }
                        }
                    }.padding(.bottom)
                    
                }//VStackの最後の}
            }//ZStackの最後の}
            
            // .navigationBarTitle("", displayMode: .inline)
            .edgesIgnoringSafeArea(.all)
            .padding(.top, 1)
            .padding(.bottom, 5)
            .onAppear
            {
                self.resetTimer();
                //画面が変わるとARKitのセッションをoffにしてbluetoothを止める
                if self.angleDetector != nil {
                    self.angleDetector.stopTracking()
                    self.ARKitFlag = false
                }
                //Play画面が出ると10秒だけinitial messageを表示する
                AppSetting.showInitialMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    AppSetting.showInitialMessage = false
                }
                
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

                //画面をbackgroundへ移行させる。
                UIApplication.shared.isIdleTimerDisabled = false
            }
        }
    }
    
    func managerSettingUp() {
        
        print("managerSettingUP中を通過しました。 ")
        //cameraの機能チェック
        guard ARFaceTrackingConfiguration.isSupported else {
            self.ARKitFlag = false
            self.showingARNotSupportedAlert = true
            return }
        //ARSupported
        self.showingARNotSupportedAlert = false
        
        
        //ARKitの準備
        if self.angleDetector != nil {
            self.angleDetector.stopTracking()
            self.angleDetector = ARKitAngleDetection(managerForBLE: self.appState.bleManager, leftY: self.$leftY)
        } else {
            self.angleDetector = ARKitAngleDetection(managerForBLE: self.appState.bleManager, leftY: self.$leftY)
        }
        //ARKitをonにする
        self.ARKitFlag = true
        self.angleDetector.resetTracking()
        
    }
    
}

extension Color {
    static let gainsboro = Color(red: 0.8, green: 0.8, blue: 0.8)
    static let lightGray = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let middleGray = Color(red: 0.4, green: 0.4, blue: 0.4)
    static let darkGray = Color(red: 0.2, green: 0.2, blue: 0.2)
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



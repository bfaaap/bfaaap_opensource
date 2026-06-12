//
//  bfaaapSwitchNameTest3.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2021/09/24.
//

import SwiftUI
 
 struct ContentView4: View {
     private var frameWidth: CGFloat {
         UIScreen.main.bounds.width
     }
     private var spacing: CGFloat {
         UIScreen.main.bounds.width / 20
     }
     private let switchNames:[String] = ["bFaaaPSwitch_1","bFaaaPSwitch_2","bFaaaPSwitch_3","bFaaaPSwitch_4"]
//     init (switchNames:[String]){
//         self.switchNames =  ["bfaaapSwitch_1","bfaaapSwitch_2","bfaaapSwitch_3","bfaaapSwitch_4"]
//     }
     
//     @State var bfaaapSwitchName = "bfaaapSwitch_1"
     @State private var selectedIndex = 0
     @State var managerForBLE: BLEManager!
     @State var connectToLocalName = ""
     //name change の画面の表示用
     @State private var isNameChanged = false

     @State private var tempBLEChangeName = ""
     
     var body: some View {
         ZStack {
             Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
             
             VStack {
                 Spacer()
                 Text("bFaaaP Switch")
                     .font(.largeTitle)
                     .foregroundColor(Color.black).opacity(0.8)
                 Spacer()
                 HStack {
                     Image(systemName: "circlebadge.fill")
                         .resizable()
                         .foregroundColor(Color.green)
                         .frame(width: 20, height: 20)
                     Text("複数使う場合は、どちらかのチャンネルを変えてください")
                         .font(.body)
                         .foregroundColor(Color.black).opacity(0.8)
                 }
                 
                 Picker("", selection: self.$selectedIndex) {
                     Text("CH 1")
                         .tag(0)
                     Text("CH 2")
                         .tag(1)
                     Text("CH 3")
                         .tag(2)
                     Text("CH 4")
                         .tag(3)
                 }
                 .pickerStyle(SegmentedPickerStyle())
                 .padding()
                 
                 Text(switchNames[self.selectedIndex])
                     .font(.title)
                     .frame(width: frameWidth - spacing * 4, height: spacing * 4, alignment: .center)
                     .foregroundColor(Color.black)
                     .background(Color.white).opacity(0.5)
                     .cornerRadius(15, antialiased: true)
                     .padding()
                 
                 Button(action :{
                     self.tempBLEChangeName =
                     switchNames[self.selectedIndex]
                     if self.tempBLEChangeName != self.connectToLocalName{
                         self.connectToLocalName = self.tempBLEChangeName
                         //UserDefaultsに値を保存
                         UserDefaults.standard.set(self.connectToLocalName, forKey: "BLEName")
                         
                         switch self.selectedIndex {
                         case 0:
                             _ = self.managerForBLE.sendString(sendText: "W")
                             print("名前を「bFaaaPSwitch_1」に変更しました")
                         case  1:
                             _ = self.managerForBLE.sendString(sendText: "X")
                             print("名前を「bFaaaPSwitch_2」に変更しました")
                         case 2:
                             _ = self.managerForBLE.sendString(sendText: "Y")
                             print("名前を「bFaaaPSwitch_3」に変更しました")
                         case 3:
                             _ = self.managerForBLE.sendString(sendText: "Z")
                             print("名前を「bFaaaPSwitch_4」に変更しました")
                         default:
                             _ = self.managerForBLE.sendString(sendText: "W")
                             print("名前を「bFaaaPSwitch_1」に変更しました")
                             
                         }
                         self.isNameChanged = false
                     }
                 }){
                     Text("チャンネル設定")
                         .font(.title)
                         .frame(width: frameWidth - spacing * 4, height: spacing * 4, alignment: .center)
                         .foregroundColor(Color.black)
                         .background(Color.white).opacity(0.5)
                         .cornerRadius(15, antialiased: true)
                         .padding()
                 }
                 
                 Button(action :{
                     self.isNameChanged = false
                 }){
                     Text("初期画面へ")
                         .font(.title)
                         .frame(width: frameWidth - spacing * 4, height: spacing * 4, alignment: .center)
                         .foregroundColor(Color.black)
                         .background(Color.white).opacity(0.5)
                         .cornerRadius(15, antialiased: true)
                         .padding()
                 }
                 
                 
                 
                 
                 HStack {
                     Image(systemName: "circlebadge.fill")
                         .resizable()
                         .foregroundColor(Color.green)
                         .frame(width: 20, height: 20)
                     Text("チャンネルを変えた後、本体左上のスイッチを押し、リセットしてください")
                         .font(.body)
                         .foregroundColor(Color.black).opacity(0.8)
                 }.padding(.top)
                 Spacer()
             } //VStackここまで
             .padding()
         } //ZStackここまで
         .edgesIgnoringSafeArea(.all)
     }
 }
 
 struct ContentView4_Previews: PreviewProvider {
     static var previews: some View {
         ContentView4()
     }
 }

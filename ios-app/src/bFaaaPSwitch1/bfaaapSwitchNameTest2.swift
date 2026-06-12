//  bfaaapSwitchNameTest
//  ContentView.swift
//  z978-1923
//
//  Created by ootaki on 2021/09/23.
//

import SwiftUI

struct ContentView3: View {
    private var frameWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    private var spacing: CGFloat {
        UIScreen.main.bounds.width / 20
    }
    
    @State var bfaaapSwitchName = "bfaaapSwitch"
    @State private var selectedIndex = 0
    
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
                
                Text("bfaaapSwitch_\(selectedIndex+1)")
                    .font(.title)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 4, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding()
                
                HStack {
                    Image(systemName: "circlebadge.fill")
                        .resizable()
                        .foregroundColor(Color.green)
                        .frame(width: 20, height: 20)
                    Text("チャンネルを変えた後、本体左上のスイッチを押し、リセットしてください（チャンネルの変更は 20回までです）")
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

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}


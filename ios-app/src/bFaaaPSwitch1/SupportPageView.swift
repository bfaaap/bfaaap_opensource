//
//  SupportPageView.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import SwiftUI

struct SupportPageView: View {
    @Binding var uiState: ViewID
    
    @Environment(\.openURL) var openURL
    private var frameWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var spacing: CGFloat {
        UIScreen.main.bounds.width / 20
    }
    
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            VStack {
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
                    .padding(.top, spacing * 2.5)
                    .padding(.leading, spacing)
                    Spacer()
                }
                Text("Support")
                    .font(.largeTitle)
                    .foregroundColor(Color.black).opacity(0.8)
                    .padding()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width: 20, height: 20)
                        Text("iPhoneに接続していません")
                            .foregroundColor(Color.black).opacity(0.8)
                            .padding(.leading, 3)
                    }
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .foregroundColor(Color.green)
                            .frame(width: 20, height: 20)
                        Text("iPhoneに接続しています")
                            .foregroundColor(Color.black).opacity(0.8)
                            .padding(.leading, 3)
                    }
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 20, height: 20)
                        Text("ペダルを踏み込んでいます")
                            .foregroundColor(Color.black).opacity(0.8)
                            .padding(.leading, 3)
                    }
                    
                }
                
                Spacer()
                
                Image("bfaaap_logo")
                    .resizable()
                    .frame(width: frameWidth / 2.5,height: frameWidth / 2.5)
                    .cornerRadius(25)
                    .padding([.top, .leading, .trailing])
                VStack{
                    Button("取扱説明書") {
                        openURL(URL(string: "https://scrapbox.io/bfaaap/SwitchInstructions")!)
                    }
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .padding([.leading, .trailing, .bottom])
                    
                    Button("プライバシーポリシー") {
                        openURL(URL(string:"https://bfaaap.com/privacypolicy/")!)
                    }
                    .font(.title3)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding(.horizontal)
                    
                    Button("健康上の注意") {
                        openURL(URL(string: "https://bfaaap.com/healthsafety-information/")!)
                    }
                    .font(.title2)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding()
                    
                    Button("利用規約") {
                        openURL(URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                    }
                    .font(.title2)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding()
                }//VStackここまで
                Spacer()
            }//VStackここまで
        }//ZStackここまで
        .edgesIgnoringSafeArea(.all)
    }
}
//
//struct SupportPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        SupportPageView()
//    }
//}

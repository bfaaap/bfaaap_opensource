//
//  SupportPageView.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import SwiftUI

struct SupportPageViewTest: View {
    //@Binding var isSupport: Bool
    var isSupport: Bool
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
                        //self.isSupport = false
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
                    .padding([.top, .leading])
                    Spacer()
                }
                Text("Support")
                    .font(.largeTitle)
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .foregroundColor(Color.yellow)
                            .frame(width: 20, height: 20)
                        Text("iPhoneに接続していません")
                            .padding(.leading, 3)
                    }
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .foregroundColor(Color.green)
                            .frame(width: 20, height: 20)
                        Text("iPhoneに接続しています")
                            .padding(.leading, 3)
                    }
                    HStack {
                        Image(systemName: "circlebadge.fill")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 20, height: 20)
                        Text("ペダルを踏み込んでいます")
                            .padding(.leading, 3)
                    }
                    
                }
                Spacer()
                Image("bfaaap_logo")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(28)
                    .padding()
                Button("Visit bFaaaP") {
                    openURL(URL(string: "https://bfaaap.com")!)
                }
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.yellow)
                .padding()
                Text("bfaaapのサイトに飛びます")
                    .font(.body)
                    .padding(.bottom, 3)
                Text("https://bfaaap.com")
                    .font(.body)
                Spacer()
            }//VStackここまで
        }//ZStackここまで
        .edgesIgnoringSafeArea(.all)
    }
}

struct SupportPageViewTest_Previews: PreviewProvider {
   static var previews: some View {
       SupportPageViewTest()
  }
    
}

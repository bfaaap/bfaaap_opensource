//
//  SupportPageView.swift
//  bFaaaPSwitch1
//
//  Created by 宍戸知行 on 2020/12/02.
//

import SwiftUI

/// Central place for the in-app links.
/// NOTE: point `githubRepo` / `aiSupport` to the official bFaaaP open-source
/// repository (GitHub Discussions is used for AI-assisted Q&A support).
private enum AppLinks {
    static let projectSite  = URL(string: "https://bfaaap.com/")!
    static let aiSupport    = URL(string: "https://github.com/")!   // TODO: https://github.com/<org>/<repo>/discussions
    static let githubRepo   = URL(string: "https://github.com/")!   // TODO: https://github.com/<org>/<repo>
    static let instructions = URL(string: "https://scrapbox.io/bfaaap/SwitchInstructions")!
    static let privacy      = URL(string: "https://bfaaap.com/privacypolicy/")!
    static let healthSafety = URL(string: "https://bfaaap.com/healthsafety-information/")!
    static let eula         = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!
}

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
                ScrollView {
                VStack{
                    Button("取扱説明書") {
                        openURL(AppLinks.instructions)
                    }
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .padding([.leading, .trailing, .bottom])

                    Button("オープンソースプロジェクト") {
                        openURL(AppLinks.projectSite)
                    }
                    .font(.title3)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding(.horizontal)

                    Button("サポート・Q&A（AI対応）") {
                        openURL(AppLinks.aiSupport)
                    }
                    .font(.title3)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding(.horizontal)

                    Button("プライバシーポリシー") {
                        openURL(AppLinks.privacy)
                    }
                    .font(.title3)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding(.horizontal)

                    Button("健康上の注意") {
                        openURL(AppLinks.healthSafety)
                    }
                    .font(.title2)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding()

                    Button("利用規約") {
                        openURL(AppLinks.eula)
                    }
                    .font(.title2)
                    .frame(width: frameWidth - spacing * 4, height: spacing * 3, alignment: .center)
                    .foregroundColor(Color.black)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(15, antialiased: true)
                    .padding()
                }//VStackここまで
                }//ScrollViewここまで
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

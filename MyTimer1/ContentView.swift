//
//  ContentView.swift
//  MyTimer1
//
//  Created by 森田晋 on 2021/12/03.
//

import SwiftUI

struct ContentView: View {
    @State var timerHandler : Timer?//タイマー変数
    @State var count = 0//経過時間の変数
    @AppStorage("timer_value") var timerValue = 10//永続化する秒数変数
    @State var showAlert = false//アラート表示FL
    var body: some View {
        NavigationView {//この中にNavigationViewの画面を構成する
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    HStack{
                        Button(action: {
                            startTimer()//タイマーをスタートさせる
                        }) {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                            
                        }//Button start
                        Button(action: {
                            if let unwrapedTimerHandler = timerHandler {
                                if unwrapedTimerHandler.isValid == true {
                                    unwrapedTimerHandler.invalidate()
                                }//if true
                            }//if
                        }) {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                            
                        }//Button stop

                    }//HStack
                }//Vstak
            }//Zstak
            .onAppear {
                //画面が更新されたら
                count = 0
            }//onAppear
            //trailingは右端
            .navigationBarItems(trailing: NavigationLink(destination: SettingView()) {
                Text("秒数設定")
            }//NavigationLink　destinationで設定画面
            )//.navigationBarItems
            .alert(isPresented: $showAlert) {
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK")))
                //ここで音を鳴らす
            }
            
        }//NavigationView
    }//body
    func countDownTimer() {
        count += 1
        if timerValue - count <= 0 {
            timerHandler?.invalidate()//残りが０なら止める
            showAlert = true//アラート表示
        }
    }//countDonwimer
    func startTimer() {
        if let unwrapedTimerHandler = timerHandler{
            if unwrapedTimerHandler.isValid == true {
                return
            }
        }//if
        if timerValue - count <= 0 {
            count = 0
        }
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
        }
    }//startTimer
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

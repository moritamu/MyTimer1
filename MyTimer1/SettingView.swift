//
//  SettingView.swift
//  MyTimer1
//
//  Created by 森田晋 on 2021/12/03.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("timer_value") var timerValue = 10//タイマー秒数
    //@AppStorageは情報を保存していつでも取り出せる。UserDefault
    var body: some View {
        ZStack {
            Color("backgroundSetting")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                Spacer()
                Picker(selection: $timerValue) {
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                } label: {
                    Text("選択")
                }
                .pickerStyle(.wheel)
                Spacer()
            }
        }//ZStack
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

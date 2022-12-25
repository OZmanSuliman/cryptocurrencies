//
//  TopView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Image("appLogo")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Weather App")
                        .foregroundColor(.white)
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                Text("One Month free, then $4.99/month.")
                    .foregroundColor(.white)
                    .font(.caption)
                    .foregroundColor(.black)
                    .foregroundColor(.gray)
            }
            Spacer(minLength: 0)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
        .padding([.leading, .bottom])
        .background(BlurBG())
        .ignoresSafeArea()
    }
}


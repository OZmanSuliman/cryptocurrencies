//
//  AnimatedTopView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import Combine
import SwiftUI

// MARK: - AnimatedTopView

struct AnimatedTopView: View {
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @Binding var appBarHeight: CGFloat
    @Binding var show: Bool
    init(appBarHeight: Binding<CGFloat>, show: Binding<Bool>) {
        self._appBarHeight = appBarHeight
        self._show = show
        if UIDevice.current.orientation.isLandscape {
            self.appBarHeight = 1.5
        }
    }

    var body: some View {
        GeometryReader { g in
            ZStack {
                Image(Strings.banner.fullString())
                    .resizable()
                VStack {
                    // head content
                    setHead()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / appBarHeight + g.frame(in: .global).minY : UIScreen.main.bounds.height / appBarHeight)
            .onReceive(self.time) { _ in
                // its not a timer...
                // for tracking the image is scrolled out or not...
                let y = g.frame(in: .global).minY
                if -y > (UIScreen.main.bounds.height / appBarHeight) - 50 {
                    withAnimation {
                        self.show = true
                    }
                } else {
                    withAnimation {
                        self.show = false
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.size.width, alignment: .center)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        // fixing default height...
        .frame(height: UIScreen.main.bounds.height / appBarHeight + 0.2)
        // body content
    }
}

extension AnimatedTopView {
    
    func setHead() -> AnyView {
        return AnyView(
            HStack {
                VStack(alignment: .leading) {
                    Spacer(minLength: 0)
                    HStack(alignment: .top) {
                        Image(Strings.appLogo.fullString())
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text(Strings.appName.fullString())
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    Text(Strings.appCost.fullString())
                        .font(.caption)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
            .padding([.leading, .bottom])
        )
    }
}

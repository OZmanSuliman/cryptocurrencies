//
//  CurrencyListLoadingView.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

// MARK: - CurrencyListLoadingView

struct CurrencyListLoadingView: View {
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var appBarHeight: CGFloat = 3.5
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown

    init() {
        if UIDevice.current.orientation.isLandscape {
            appBarHeight = 2.0
        }
    }
    var body: some View {
        ZStack(alignment: .top, content: {
            List {
                GeometryReader { g in
                    ZStack {
                        Image("cloud")
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
                setBody()
                    .frame(width: UIScreen.main.bounds.size.width, alignment: .center)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            if self.show {
                TopView()
            }
        })
            .foregroundColor(.white)
            .ignoresSafeArea(edges: .top)
            .onRotate { newOrientation in
                orientation = newOrientation
                switch newOrientation {
                case .landscapeLeft, .landscapeRight:
                    appBarHeight = 2.0
                case .unknown, .portrait, .portraitUpsideDown, .faceUp, .faceDown:
                    appBarHeight = 3.5
                @unknown default:
                    appBarHeight = 3.5
                }
            }
    }
}

extension CurrencyListLoadingView {
    func setHead() -> AnyView {
        return AnyView(
            VStack {
                ActivityIndicatorView()
            }
        )
    }

    func setBody() -> AnyView {
        AnyView(
            VStack {
                Spacer(minLength: 100)
                ActivityIndicatorView()

            }
            .padding()
        )
    }
}

#if DEBUG
    struct CurrencyListLoadingView_Previews: PreviewProvider {
        static var previews: some View {
            CurrencyListLoadingView()
        }
    }
#endif

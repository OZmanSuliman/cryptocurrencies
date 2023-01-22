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
    @State var animateTrimPath = false
    @State var rotaeInfinity = false

    var body: some View {
        ZStack(alignment: .top, content: {
            List {
                AnimatedTopView(appBarHeight: $appBarHeight, show: $show)
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
                    appBarHeight = 1.5
                case .unknown, .portrait, .portraitUpsideDown, .faceUp, .faceDown:
                    appBarHeight = 3.5
                @unknown default:
                    appBarHeight = 3.5
                }
            }
    }
}

extension CurrencyListLoadingView {
    func setBody() -> AnyView {
        AnyView(
            VStack {
                Spacer(minLength: 100)
                setIndicator()
                    .frame(width: 50, height: 50)
                    

            }
            .padding()
        )
    }
    
    func setIndicator() -> AnyView {
        AnyView(
        ZStack {
            Path { path in
                path.addLines([
                    .init(x: 2, y: 1),
                    .init(x: 1, y: 0),
                    .init(x: 0, y: 1),
                    .init(x: 1, y: 2),
                    .init(x: 3, y: 0),
                    .init(x: 4, y: 1),
                    .init(x: 3, y: 2),
                    .init(x: 2, y: 1)
                ])
            }
            .trim(from: animateTrimPath ? 1/0.99 : 0, to: animateTrimPath ? 1/0.99 : 1)
            .scale(50, anchor: .topLeading)
            .stroke(.yellow, lineWidth: 20)
            .offset(x: 110, y: 350)
            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
            .onAppear() {
                self.animateTrimPath.toggle()
            }
        }
        .rotationEffect(.degrees(rotaeInfinity ? 0 : -360))
        .scaleEffect(0.3, anchor: .center)
        .animation(Animation.easeInOut(duration: 1.5)
        .repeatForever(autoreverses: false))
        .edgesIgnoringSafeArea(.all)
        .onAppear(){
            self.rotaeInfinity.toggle()
        }
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

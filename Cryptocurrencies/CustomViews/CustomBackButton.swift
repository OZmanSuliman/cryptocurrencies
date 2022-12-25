//
//  CustomBackButton.swift
// cryptocurrencies
//
//  Created by Osman Ahmed on 23/12/2022.
//

import SwiftUI

struct CustomBackButton: View {
    var presentationMode: Binding<PresentationMode>

    init(presentationMode: Binding<PresentationMode>) {
        self.presentationMode = presentationMode
    }

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                Text("Back")
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

//
//  ContentView.swift
//  OpenActions
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.openURL) var openURL

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 24, content: {
                Spacer()
                Image("logo").frame(width: 100, height: 100, alignment: .center)
                Text("Open you Shortcuts app to use actions from\nOpen Actions")
                    .font(.body)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                Spacer()
                Button("Contribute on GitHub") {
                    guard let url = URL(string: "https://github.com/abiaad/OpenActions")
                    else {
                        return
                    }
                    self.openURL(url)
                }
                .foregroundColor(Color.white)
                .padding()
                .background(Color(.init(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)))
                .cornerRadius(8)
                Spacer()
            })
            Spacer()
        }
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

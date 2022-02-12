//
//  HomeView.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 05/01/2022.
//

import SwiftUI

public class MainApplicationFactory {
    public static func createHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
}

struct HomeView: View {

    var body: some View { self.createView() }
    let viewModel: HomeViewModelable

    private func createView() -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 24, content: {
                Spacer()
                Image(self.viewModel.logoImageName).frame(width: 100, height: 100, alignment: .center)
                Text(self.viewModel.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                Spacer()
                Button(self.viewModel.contributionTitle) {
                    self.viewModel.openContributionURL()
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

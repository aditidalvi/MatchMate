//
//  ContentView.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                ForEach(viewModel.profileViewModels, id: \.self) { cardViewModel in
                    ProfileCardView(cardViewModel: cardViewModel)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 80)
                        .background(.white)
                        .cornerRadius(12)
                        .shadow(radius: 8.0)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}

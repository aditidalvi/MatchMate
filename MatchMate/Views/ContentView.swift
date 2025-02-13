//
//  ContentView.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.bold)
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(viewModel.profileViewModels, id: \.name) { cardViewModel in
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
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}

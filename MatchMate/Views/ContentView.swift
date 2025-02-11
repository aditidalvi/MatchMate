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
        VStack {
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.bold)
            ProfileCardView(cardViewModel: ProfileCardViewModel(image: UIImage(systemName: "rectangle.fill")!,
                                                                name: "Florenece Gagne",
                                                                detail: "43, Keswick, Yukon"))
            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .background(.white)
            .cornerRadius(12)
            .shadow(radius: 10.0)
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}

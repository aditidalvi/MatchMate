//
//  ProfileCardView.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import SwiftUI

struct ProfileCardView: View {
    var cardViewModel: ProfileCardViewModel?
    var body: some View {
        if let cardViewModel {
            VStack(spacing: 10) {
                Image(uiImage: cardViewModel.image)
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.bottom, 10)
                Text(cardViewModel.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.cyan)
                Text(cardViewModel.detail)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ProfileCardView(cardViewModel: ProfileCardViewModel(image: UIImage(systemName: "rectangle.fill")!,
                                                        name: "Florenece Gagne",
                                                        detail: "43, Keswick, Yukon"))
}

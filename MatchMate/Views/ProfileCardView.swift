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
            VStack {
                AsyncImage(url: cardViewModel.imageUrl)
                    .padding(.bottom, 10)
                Text(cardViewModel.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.cyan)
                Text(cardViewModel.detail)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                HStack(spacing: 40) {
                    Button(action: {
                        print("Profile did not match")
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.red)
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        print("Profile matched")
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.green)
                            .frame(width: 40, height: 40)
                    })
                }
            }
        }
    }
}

#Preview {
    ProfileCardView(cardViewModel: ProfileCardViewModel(image: URL(string: "https://randomuser.me/api/portraits/med/women/12.jpg"),
                                                        name: "Florenece Gagne",
                                                        detail: "43, Keswick, Yukon"))
}

//
//  ProfileCardView.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import SwiftUI

struct ProfileCardView: View {
    @ObservedObject var cardViewModel: ProfileCardViewModel
    
    var body: some View {
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
            if cardViewModel.status == .none {
                HStack(spacing: 40) {
                    Button(action: {
                        cardViewModel.status = .rejected
                        cardViewModel.tapAction(.rejected, cardViewModel.name)
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.red)
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        cardViewModel.status = .accepted
                        cardViewModel.tapAction(.accepted, cardViewModel.name)
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.green)
                            .frame(width: 40, height: 40)
                    })
                }
            } else {
                HStack {
                    Spacer()
                    Text(cardViewModel.status.rawValue)
                        .padding()
                    Spacer()
                }
                .background(.cyan)
            }
        }
    }
}

#Preview {
    ProfileCardView(cardViewModel: ProfileCardViewModel(image: URL(string: "https://randomuser.me/api/portraits/med/women/12.jpg"),
                                                        name: "Florenece Gagne",
                                                        detail: "43, Keswick, Yukon", status: .accepted, tapAction: { _,_  in })!)
}

//
//  ProfileCardViewModel.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import Foundation
import UIKit

class ProfileCardViewModel: ObservableObject, Identifiable {
    let imageUrl: URL
    let name: String
    let detail: String
    @Published var status: ProfileMatchState
    let tapAction:(ProfileMatchState, _ id: String) -> ()
    
    init?(image: URL?,
          name: String?,
          detail: String?,
          status: ProfileMatchState,
          tapAction: @escaping (ProfileMatchState, _ id: String) -> ()) {
        guard let image,
              let name,
              let detail else {
            return nil
        }
        self.imageUrl = image
        self.name = name
        self.detail = detail
        self.status = status
        self.tapAction = tapAction
    }
    
    static func == (lhs: ProfileCardViewModel, rhs: ProfileCardViewModel) -> Bool {
        return (lhs.name + lhs.detail) == (rhs.name + rhs.detail)
    }
}

enum ProfileMatchState: String {
    case accepted = "Accepted"
    case rejected = "Rejected"
    case none = "None"
}

//
//  ProfileCardViewModel.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import Foundation
import UIKit

struct ProfileCardViewModel: Hashable {
    let imageUrl: URL
    let name: String
    let detail: String
    
    init?(image: URL?,
         name: String?,
         detail: String?) {
        guard let image,
              let name,
              let detail else {
            return nil
        }
        self.imageUrl = image
        self.name = name
        self.detail = detail
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(name + detail)
    }
}

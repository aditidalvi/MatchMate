//
//  ProfileCardViewModel.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import Foundation
import UIKit

struct ProfileCardViewModel: Hashable {
    let image: UIImage
    let name: String
    let detail: String
    
    init(image: UIImage,
         name: String,
         detail: String) {
        self.image = image
        self.name = name
        self.detail = detail
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(name + detail)
    }
}

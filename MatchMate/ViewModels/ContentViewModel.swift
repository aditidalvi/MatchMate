//
//  ContentViewModel.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import Foundation

class ContentViewModel: ObservableObject {
    let title: String = "Profile Matches"
    @Published var profileViewModels: [ProfileCardViewModel] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else {
            assertionFailure("Invalid url.")
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {[weak self](data, response, error) in
            guard let data,
                  error == nil else {
                assertionFailure("Error encounterd in fetching data. \(error.debugDescription)")
                return
            }
            let profile = try? JSONDecoder().decode(ProfileCardModel.self, from: data)
            self?.setUpProfileViewModels(profileModel: profile)
        }).resume()
    }
    
    func setUpProfileViewModels(profileModel: ProfileCardModel?) {
        if let results = profileModel?.results {
            var profileViewModels: [ProfileCardViewModel] = []
            for profile in results {
                let profileCardViewModel = ProfileCardViewModel(image: profile.picture.large,
                                                                name: "\(profile.name.first) \(profile.name.last)",
                                                                detail: "\(profile.dob.age),\(profile.location.city),\(profile.location.country)")
                profileViewModels.append(profileCardViewModel)
            }
            DispatchQueue.main.async(execute: {[weak self] in
                self?.profileViewModels = profileViewModels
            })
        }
    }
}

//
//  ContentViewModel.swift
//  MatchMate
//
//  Created by Abcom on 11/02/25.
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
    let title: String = "Profile Matches"
    @Published var isFetchingData: Bool = true
    let container: NSPersistentContainer
    @Published var profileViewModels: [ProfileCardViewModel] = []
    
    init() {
        container = NSPersistentContainer(name: "ProfileInfo")
        container.loadPersistentStores(completionHandler: { [weak self] (description, error) in
            if let error {
                print("eror loading coredata: \(error)")
            } else {
                let entities = self?.fetchDataFromDB()
                if entities?.isEmpty == true {
                    self?.fetchDataFromApi()
                } else {
                    self?.setUpProfileViewModels(profiles: entities)
                }
            }
        })
    }
    
    func fetchDataFromDB() -> [ProfileEntity]? {
        let request = NSFetchRequest<ProfileEntity>(entityName: "ProfileEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
            return nil
        }
    }
    
    func addDataToDatabase(_ data: ProfileCardModel?) {
        if let results = data?.results {
            for profile in results {
                let newProfile = ProfileEntity(context: container.viewContext)
                newProfile.age = Int64(profile.dob.age)
                newProfile.city = profile.location.city
                newProfile.country = profile.location.country
                newProfile.name = "\(profile.name.first) \(profile.name.last)"
                newProfile.imageUrl = URL(string: profile.picture.large)
                newProfile.status = ProfileMatchState.none.self.rawValue
                try? container.viewContext.save()
            }
            setUpProfileViewModels(profiles: fetchDataFromDB())
        }
    }
    
    func fetchDataFromApi() {
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
            self?.addDataToDatabase(profile)
        }).resume()
    }
    
    func setUpProfileViewModels(profiles: [ProfileEntity]?) {
        if let profiles {
            var profileViewModels: [ProfileCardViewModel] = []
            for profile in profiles {
                if let profileCardViewModel = ProfileCardViewModel(image: profile.imageUrl,
                                                                   name: profile.name,
                                                                   detail: "\(profile.age),\(String(describing: profile.city ?? "")),\(String(describing: profile.country ?? ""))",
                                                                   status: ProfileMatchState(rawValue: profile.status ?? "") ?? .none,
                                                                   tapAction: {[weak self] value, id in
                    do {
                        let request = NSFetchRequest<ProfileEntity>(entityName: "ProfileEntity")
                        let results = try self?.container.viewContext.fetch(request)
                        if let objectToUpdate = results?.first(where: {
                            $0.name == id
                        }) {
                            // Proceed to update the attribute
                            objectToUpdate.status = value.self.rawValue
                            try? self?.container.viewContext.save()
                        }
                    } catch {
                        print("Failed to fetch object: \(error)")
                    }
                }) {
                    print("Match state is \(profile.status)")
                    profileViewModels.append(profileCardViewModel)
                }
            }
            DispatchQueue.main.async(execute: {[weak self] in
                self?.isFetchingData = false
                self?.profileViewModels = profileViewModels
            })
        }
    }
}

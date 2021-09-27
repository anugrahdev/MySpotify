//
//  MockNetworkService.swift
//  MySpotifyTests
//
//  Created by Anang Nugraha on 27/09/21.
//

import Foundation
@testable import MySpotify

struct MockNetworkService: NetworkServiceDelegate {
    let getCurrentUserProfileResult: Result<ProfileModel, Error> = .success(ProfileModel())

    func getCurrentUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        completion(getCurrentUserProfileResult)
    }
    
    
}

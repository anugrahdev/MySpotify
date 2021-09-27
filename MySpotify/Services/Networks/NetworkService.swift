//
//  NetworkService.swift
//  MySpotify
//
//  Created by Anang Nugraha on 27/09/21.
//

import Foundation

protocol NetworkServiceDelegate {
    func getCurrentUserProfile(completion: @escaping (Result<ProfileModel, Error>)->Void)
}

struct NetworkService: NetworkServiceDelegate {
    func getCurrentUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        AuthManager.shared.withValidToken { token in
            
        }
    }
    
    
}

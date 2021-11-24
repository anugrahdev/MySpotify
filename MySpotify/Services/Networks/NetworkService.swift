//
//  NetworkService.swift
//  MySpotify
//
//  Created by Anang Nugraha on 27/09/21.
//

import Foundation
import Alamofire

protocol NetworkServiceDelegate {
    func getCurrentUserProfile(completion: @escaping (Result<ProfileModel, Error>)->Void)
}

struct NetworkService: NetworkServiceDelegate {
    func getCurrentUserProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        makeRequest(endPoint: "me", method: .get, params: nil, expectingReturnType: ProfileModel.self) { response in
            switch response.result{
            case .success(let model):
                completion(.success(model))
            case .failure(let e):
                completion(.failure(e))
            }
        }
    }
    
    func makeRequest<T: Codable>(endPoint:String, method: HTTPMethod, params: [String: Any]?, expectingReturnType:T.Type,  completion: @escaping (DataResponse<T, AFError>) -> Void){
        
        AuthManager.shared.withValidToken { token in
            let header: HTTPHeaders = [
                .authorization(bearerToken: token)
            ]
            
            AF.request(Constants.BASE_URL+endPoint, method: method, parameters: params, headers: header).responseDecodable(of: T.self){ response in
                completion(response)
            }
            
        }

    }

    
}

//
//  AuthManager.swift
//  MySpotify
//
//  Created by Anang Nugraha on 17/09/21.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() { }
    
    public var signInURL: URL? {
        let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read"
        let redirectURI = "https://www.iosacademy.io"
        let base = "https://accounts.spotify.com"
        let stringUri = "\(base)/authorize?response_type=code&client_id=\(Keys.CLIENT_ID)&scopes=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: stringUri)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken:String? {
        return AuthUserDefault.shared.accessToken
    }
    
    private var refreshToken:String? {
        return AuthUserDefault.shared.refreshToken
    }
    
    private var tokenExpirationDate: Date? {
        return AuthUserDefault.shared.expirationDate
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(
        code:String,
        completion: @escaping ((Bool) -> Void)
    ){
        //Get Token
        guard let url = URL(string: Constants.TOKEN_API_URL) else {
            print("url wrong")
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.iosacademy.io"),
            
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = "\(Keys.CLIENT_ID):\(Keys.CLIENT_SECRET_ID)"
        let data = basicToken.data(using: .utf8)
        
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            
            guard let data = data, error == nil else{
                completion(false)
                print("data guard error")
                return
            }
            
            do {
                
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(json)
                completion(true)
                
            }catch(let error){
                print("do error occured \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool)->Void){
        
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        guard let url = URL(string: Constants.TOKEN_API_URL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
            
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = "\(Keys.CLIENT_ID):\(Keys.CLIENT_SECRET_ID)"
        let data = basicToken.data(using: .utf8)
        
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Success refresh")
                self?.cacheToken(json)
                completion(true)
                
            }catch(let error){
                print("Error Occured \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    public func cacheToken(_ result: AuthResponse){
        AuthUserDefault.shared.accessToken = result.access_token
        
        if let refresh = result.refresh_token {
            AuthUserDefault.shared.refreshToken = refresh
        }
        AuthUserDefault.shared.expirationDate = Date().addingTimeInterval(TimeInterval(result.expires_in ?? 0) )
    }
    
}

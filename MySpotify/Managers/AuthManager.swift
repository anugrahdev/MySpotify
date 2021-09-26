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
        let scopes = "user-read-private"
        let redirectURI = "https://www.iosacademy.io"
        let base = "https://accounts.spotify.com"
        let stringUri = "\(base)/authorize?response_type=code&client_id=\(Constants.CLIENT_ID)&scopes=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: stringUri)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken:String? {
        return nil
    }
    
    private var refreshToken:String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(
        code:String,
        completion: @escaping ((Bool) -> Void)
    ){
        
    }
}

//
//  AuthUserDefault.swift
//  MySpotify
//
//  Created by Anang Nugraha on 27/09/21.
//

import Foundation


struct AuthUserDefault {
    
    public static var shared = AuthUserDefault()
    
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refresh_token"
    private static let expirationDateTokenKey = "expiration_date"
    
    var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: AuthUserDefault.accessTokenKey)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthUserDefault.accessTokenKey)
        }
    }
    
    var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: AuthUserDefault.refreshTokenKey)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthUserDefault.refreshTokenKey)
        }
    }
    
    
    var expirationDate: Date? {
        get {
            UserDefaults.standard.object(forKey: AuthUserDefault.expirationDateTokenKey) as? Date
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: AuthUserDefault.expirationDateTokenKey)
        }
    }
}

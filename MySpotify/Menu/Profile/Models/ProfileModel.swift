//
//  ProfileModel.swift
//  MySpotify
//
//  Created by Anang Nugraha on 27/09/21.
//

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let country, displayName, email: String?
    let externalUrls: ExternalUrlsModel
    let followers: FollowersModel?
    let href: String?
    let id: String?
    let images: [ImageModel]?
    let product, type, uri: String?
    
    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case externalUrls = "external_urls"
        case followers, href, id, images, product, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrlsModel: Codable {
    let spotify: String?
}

// MARK: - Followers
struct FollowersModel: Codable {
    let href: String?
    let total: Int?
}

// MARK: - Image
struct ImageModel: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

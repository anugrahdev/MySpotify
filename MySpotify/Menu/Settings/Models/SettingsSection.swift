//
//  Section.swift
//  MySpotify
//
//  Created by Anang Nugraha on 27/09/21.
//

import Foundation

struct SettingsSection {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}

//
//  SettingsData.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation

// MARK: - Root
struct SettingsData: Codable {
    let screenTitle: String
    let appVersion: String
    let profile: UserProfile
    let sections: [SettingSection]
    let logoutAction: LogoutAction

    enum CodingKeys: String, CodingKey {
        case screenTitle = "screen_title"
        case appVersion = "app_version"
        case profile, sections
        case logoutAction = "logout_action"
    }
}

// MARK: - User Profile Card
struct UserProfile: Codable {
    let name: String
    let tier: String
    let avatarImage: String

    enum CodingKeys: String, CodingKey {
        case name, tier
        case avatarImage = "avatar_image"
    }
}

// MARK: - Sections & Items
struct SettingSection: Codable {
    let items: [SettingItem]
}

struct SettingItem: Codable {
    let id: String
    let title: String
    let subtitle: String?
    let icon: String
    let type: SettingItemType
    var isEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, icon, type
        case isEnabled = "is_enabled"
    }
}

enum SettingItemType: String, Codable {
    case toggle
    case navigation
}

// MARK: - Logout
struct LogoutAction: Codable {
    let title: String
    let icon: String
}

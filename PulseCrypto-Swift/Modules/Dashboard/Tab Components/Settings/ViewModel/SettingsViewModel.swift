//
//  SettingsViewModel.swift
//  PulseCrypto-Swift
//
//  Created by Ramesh on 10/11/26.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    @Published var settingsData: SettingsData?
    @Published var sections: [SettingSection] = []
    
    init() {
        loadSettingsJson()
    }
    private func loadSettingsJson() {
        if let data = try? Bundle.main.decode(SettingsData.self, from: "settings.json") {
            self.settingsData = data
            self.sections = data.sections
        }
    }
}

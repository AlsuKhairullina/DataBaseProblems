//
//  SettingsScreenViewModel.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//


import Combine

final class SettingsScreenViewModel: ObservableObject {
    @Published var themePublisher: Themeable = ColorTheme1()
}

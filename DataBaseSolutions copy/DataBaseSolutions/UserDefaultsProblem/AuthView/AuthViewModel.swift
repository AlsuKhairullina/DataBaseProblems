//
//  AuthViewModel.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//

import UIKit
import Combine

final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var buttonIsActive = false

    @Published var usernameTextColor: UIColor?
    @Published var emailTextColor: UIColor?
    
    private let dataManager = UserDefaultsManager()

    init() {
       formIsValidPublisher
            .assign(to: &$buttonIsActive)

        usernameIsValidPublisher
            .mapToFieldInputColor()
            .assign(to: &$usernameTextColor)

        emailIsValidPublisher
            .mapToFieldInputColor()
            .assign(to: &$emailTextColor)
    }
    
    func saveCredentials(name: String, email: String) {
        dataManager.saveCredentials(name: name, email: email)
    }
    
    func getCredentials() -> (String, String) {
        return dataManager.getCredentials()
    }

    private var usernameIsValidPublisher: some Publisher<Bool, Never> {
        $username
            .map { $0.count > 3 }
    }

    private var emailIsValidPublisher: some Publisher<Bool, Never> {
        $email
            .map { $0.isValidEmail }
    }

     var formIsValidPublisher: some Publisher<Bool, Never> {
        usernameIsValidPublisher
            .combineLatest(emailIsValidPublisher)
            .map { $0 && $1 }
    }
}

extension Publisher where Output == Bool, Failure == Never {
    func mapToFieldInputColor() -> some Publisher<UIColor?, Never> {
        map { $0 ? .label : .systemRed }
    }
}


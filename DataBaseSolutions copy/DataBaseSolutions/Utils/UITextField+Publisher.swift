//
//  UITextField+Publisher.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//

import UIKit
import Combine

extension UITextField {

    var textPublisher: some Publisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
    }
}

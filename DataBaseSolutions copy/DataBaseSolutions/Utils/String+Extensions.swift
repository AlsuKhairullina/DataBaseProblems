//
//  String+Extensions.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        return NSPredicate(
            format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        )
        .evaluate(with: self)
    }
}

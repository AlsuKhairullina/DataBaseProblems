////
////  Color.swift
////  DataBaseSolutions
////
////  Created by Alexander Korchak on 13.12.2023.
////
//
import UIKit

protocol Themeable {
    var background: UIColor { get set }
    var green: UIColor { get set }
    var blue: UIColor { get set }
    var secondaryText: UIColor { get set }
}

enum Theme {
    case themeOne
    case themeTwo

    var theme: Themeable {
        switch self {
        case .themeOne:
            return ColorTheme1()
        case .themeTwo:
            return ColorTheme2()
        }
    }
}

struct ColorTheme1: Themeable {
    var background = UIColor(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
    var green = UIColor(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))
    var blue = UIColor(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1))
    var secondaryText = UIColor(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
}

struct ColorTheme2: Themeable {
    var background = UIColor(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))
    var green = UIColor(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1))
    var blue = UIColor(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 1))
    var secondaryText = UIColor(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}

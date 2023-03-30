//
//  UIFont + Extension.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import Foundation
import UIKit

extension UIFont {

    static func custom(_ name: FontBook,_ size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: name.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}

//
//  String + Extension.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import Foundation
import UIKit

extension String {

    func setAttributedString(range: String,
                             secondRange: String? = nil,
                             font: UIFont,
                             textColor: UIColor,
                             rangeColor: UIColor,
                             rangeFont: UIFont? = nil,
                             underline: Bool? = false) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self,
                                                        attributes: [
                                                            .font: font,
                                                            .foregroundColor: textColor
                                                        ])
        var nameAttribute: [NSAttributedString.Key: Any] = [:]
        if let rangeFont = rangeFont {
            nameAttribute = [.foregroundColor: rangeColor, .font: rangeFont ] as [NSAttributedString.Key : Any]
        } else if let underline = underline, underline {
            nameAttribute = [.foregroundColor: rangeColor, .underlineStyle: NSUnderlineStyle.thick.rawValue] as [NSAttributedString.Key : Any]
        } else {
            nameAttribute = [.foregroundColor: rangeColor ] as [NSAttributedString.Key : Any]
        }
        let range = (self as NSString).range(of: range)
        if let secondRange = secondRange {
            let secondRangeString = (self as NSString).range(of: secondRange)
            attributeString.addAttributes(nameAttribute, range: secondRangeString)
        }
        attributeString.addAttributes(nameAttribute, range: range)
        return attributeString
    }
}

//
//  NSLayoutConstraint + Extensions.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation
import UIKit

extension NSLayoutConstraint {

    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}

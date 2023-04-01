//
//  UIView + Extensions.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation
import UIKit

extension UIView {

    func gradientColor(bounds: CGRect,
                       gradientLayer: CAGradientLayer) -> UIColor? {

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        gradientLayer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image)
    }

    //BLUR BACKGROUND
    func createBlurBackgroundView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

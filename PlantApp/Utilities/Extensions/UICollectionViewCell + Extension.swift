//
//  UICollectionViewCell + Extension.swift
//  PlantApp
//
//  Created by Mert Gökduman on 31.03.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    //BLUR BACKGROUND
    func createBlurBackgroundView(color: UIColor) {
        guard !UIAccessibility.isReduceTransparencyEnabled else { return }

        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = color
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.insertSubview(blurView, at: 0)
        blurView.frame = self.contentView.frame
        blurView.layer.cornerRadius = 14
        blurView.clipsToBounds = true

//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.contentView.addSubview(vibrancyView)
//        vibrancyView.frame = blurView.frame
    }
}

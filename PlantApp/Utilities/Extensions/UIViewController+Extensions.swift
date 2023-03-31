//
//  UIViewController+Extensions.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import Foundation
import UIKit

extension UIViewController {

    func getScreenSize() -> CGRect{
        let screenSize: CGRect = UIScreen.main.bounds
        return screenSize
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func makeViewDismissKeyboard(cancelsTouchesInView: Bool? = nil) {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        if let cancelsTouchesInView = cancelsTouchesInView {
            tapGesture.cancelsTouchesInView = cancelsTouchesInView
        }
        view.addGestureRecognizer(tapGesture)
    }

    //BLUR BACKGROUND
    func createBlurBackgroundView(color: UIColor) {
        guard !UIAccessibility.isReduceTransparencyEnabled else { return }

        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = color
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        blurView.frame = self.view.frame

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)
        vibrancyView.frame = blurView.frame
    }
}

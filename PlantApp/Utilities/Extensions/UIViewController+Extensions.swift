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
}

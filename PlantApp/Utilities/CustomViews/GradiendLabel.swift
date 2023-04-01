//
//  GradiendLabel.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation
import UIKit

final class GradientLabel: UILabel {

    private var colors: [UIColor] = [CustomColors.premiumLabelColor, CustomColors.premiumLabelColorTwo]
    private var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
    private var endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)
    private var textColorLayer: CAGradientLayer = CAGradientLayer()

    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyColors()
    }

    // MARK: - Public functions
    func update(colors: [UIColor],
                startPoint: CGPoint,
                endPoint: CGPoint) {

        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        applyColors()
    }

    // MARK: - Private functions
    private func setup() {

        isAccessibilityElement = true
        applyColors()
    }

    private func applyColors() {

        let gradient = getGradientLayer(bounds: self.bounds)
        textColor = gradientColor(bounds: self.bounds, gradientLayer: gradient)
    }

    private func getGradientLayer(bounds: CGRect) -> CAGradientLayer {

        textColorLayer.frame = bounds
        textColorLayer.colors = colors.map{ $0.cgColor }
        textColorLayer.startPoint = startPoint
        textColorLayer.endPoint = endPoint
        return textColorLayer
    }

}

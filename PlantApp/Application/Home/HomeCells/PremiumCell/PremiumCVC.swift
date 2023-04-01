//
//  PremiumCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import UIKit

class PremiumCVC: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.cornerRadius = 12
            mainView.clipsToBounds = true
        }
    }
    @IBOutlet weak var lblTitle: GradientLabel!
    @IBOutlet weak var lblDescription: GradientLabel! {
        didSet {
            lblDescription.update(colors: [CustomColors.premiumLabelColor.withAlphaComponent(0.8),
                                           CustomColors.premiumLabelColorTwo.withAlphaComponent(0.8) ],
                                  startPoint: CGPoint(x: 0.0, y: 0.5),
                                  endPoint: CGPoint(x: 1.0, y: 0.5))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.setupCell()
    }

    private func setupCell() {

        let titleText = "FREE Premium Available"
        lblTitle.attributedText = titleText.withBoldText(text: "FREE",
                                                         font: .systemFont(ofSize: 16,
                                                                           weight: .semibold),
                                                         rangeFont: .systemFont(ofSize: 16,
                                                                                weight: .bold))
        lblDescription.text = "Tap to upgrade your account!"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

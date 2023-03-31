//
//  OnboardingTwoCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 31.03.2023.
//

import UIKit

class OnboardingTwoCVC: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var overlayView: UIView! {
        didSet {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor.white.withAlphaComponent(0.1).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = overlayView.bounds

            overlayView.layer.insertSublayer(gradientLayer, at:0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    // MARK: - FILL CELL
    func fillCell(with title: String,
                  rangeString: String,
                  image: UIImage?) {
        let attributedString = title.setAttributedString(range: rangeString,
                                                         font: .custom(.rubikMedium, 28),
                                                         textColor: CustomColors.labelColor,
                                                         rangeColor: CustomColors.labelColor,
                                                         rangeFont: .custom(.rubikExtraBold, 28))
        lblTitle.attributedText = attributedString
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

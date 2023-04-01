//
//  OnboardingCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import UIKit

class OnboardingCVC: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgOnboard: UIImageView!

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
        imgOnboard.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

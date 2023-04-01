//
//  QuestionCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import UIKit

class QuestionCVC: UICollectionViewCell {

    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var blurView: UIView! {
        didSet {
            blurView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupCell()
    }

    private func setupCell() {

        self.contentView.layer.cornerRadius = 12
        self.contentView.clipsToBounds = true

        imgBG.contentMode = .scaleAspectFill
        imgBG.image = UIImage(named: "payWallBG")

        blurView.createBlurBackgroundView()
        blurView.bringSubviewToFront(lblTitle)
        let text = "How to identify plants easily with PlantApp?"
        lblTitle.attributedText = text.setAttributedString(range: "How to identify",
                                                           font: .custom(.rubikMedium, 15),
                                                           textColor: .white,
                                                           rangeColor: .white,
                                                           rangeFont: .custom(.rubikRegular, 15))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

//
//  QuestionCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import UIKit
import Kingfisher

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

        blurView.createBlurBackgroundView()
        blurView.bringSubviewToFront(lblTitle)
    }

    func fillCell(with model: GetStartedResponseModel) {
        lblTitle.text = model.title
        if let urlString = model.imageUrl,
           let imageUrl = URL(string: urlString) {
            imgBG.kf.setImage(with: imageUrl)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

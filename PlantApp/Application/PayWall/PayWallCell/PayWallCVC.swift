//
//  PayWallCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 31.03.2023.
//

import UIKit

class PayWallCVC: UICollectionViewCell {

    @IBOutlet weak var imgContainer: UIView! {
        didSet {
            imgContainer.backgroundColor = .black.withAlphaComponent(0.24)
            imgContainer.layer.cornerRadius = 8
            imgContainer.clipsToBounds = true
        }
    }
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.contentView.layer.cornerRadius = 14
        self.contentView.backgroundColor = .clear
        self.contentView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.08).cgColor
//        self.createBlurBackgroundView(color: .black)
        self.clipsToBounds = true
    }

    func fillCell(with model: PayModel) {
        imgCell.image = model.image
        lblTitle.text = model.title
        lblDescription.text = model.description
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

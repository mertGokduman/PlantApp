//
//  CategoryCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import UIKit

class CategoryCVC: UICollectionViewCell {

    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupCell()
    }

    private func setupCell() {

        self.contentView.backgroundColor = CustomColors.categoryCellBGColor
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = CustomColors.categoryCellBorderColor.withAlphaComponent(0.18).cgColor
        self.contentView.layer.cornerRadius = 12
        self.contentView.clipsToBounds = true

        imgBG.image = UIImage(named: "bg")
        lblTitle.text = "Edible\nPlants"
    }

    func fillCell(with model: Category) {
        lblTitle.text = model.title
        if let urlString = model.image?.url,
           let imageUrl = URL(string: urlString) {
            imgBG.kf.setImage(with: imageUrl)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

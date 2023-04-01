//
//  CategoriesCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import UIKit

class CategoriesCVC: UICollectionViewCell {

    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewFlowLayout.minimumLineSpacing = 11
            collectionViewFlowLayout.minimumInteritemSpacing = 10
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = .clear
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            collectionView.isScrollEnabled = false
            collectionView.registerNib(withClassAndIdentifier: CategoryCVC.self)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesCVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVC",
                                                            for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoriesCVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

    }
}

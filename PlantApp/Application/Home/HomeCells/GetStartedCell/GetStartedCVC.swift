//
//  GetStartedCVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import UIKit

class GetStartedCVC: UICollectionViewCell {


    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewFlowLayout.itemSize = CGSize(width: 240,
                                                       height: 164)
            collectionViewFlowLayout.minimumLineSpacing = 10
            collectionViewFlowLayout.minimumInteritemSpacing = 0
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            collectionView.registerNib(withClassAndIdentifier: QuestionCVC.self)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
        }
    }

    lazy var dataArray: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func fillCell(with model: String) {
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - UICollectionViewDataSource
extension GetStartedCVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCVC",
                                                            for: indexPath) as? QuestionCVC else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GetStartedCVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

    }
}

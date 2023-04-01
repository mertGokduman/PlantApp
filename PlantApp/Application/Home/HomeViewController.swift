//
//  HomeViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var viewModel = HomeViewModel()

    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - SETUP UI
    private func setupUI() {

        view.backgroundColor = CustomColors.bgColor

        headerView.setupView(titleText: "Welcome, plant lover!",
                             greetingText: "Good Afternoon! ⛅",
                             searchPlaceholderText: "Search for plants")
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 185)
        ])

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.setupCollectionView()
        self.collectionView.reloadData()
    }

    // MARK: - COLLECTIONVIEW SETUPS
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.registerCollectionView()
    }

    private func registerCollectionView() {
        let nibs = [PremiumCVC.self, GetStartedCVC.self, CategoriesCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
        collectionView.register(UINib(nibName: "HomeHeader",
                                      bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HomeHeader")
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.typeArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.typeArray[section]
        switch section {
        case .premium:
            return 1
        case .getStarted:
            return 1
        case .categories:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.typeArray[indexPath.section]
        switch section {
        case .premium:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PremiumCVC",
                                                                for: indexPath) as? PremiumCVC else { return UICollectionViewCell() }
            return cell
        case .getStarted:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetStartedCVC",
                                                                for: indexPath) as? GetStartedCVC else { return UICollectionViewCell() }
            return cell
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCVC",
                                                                for: indexPath) as? CategoriesCVC else { return UICollectionViewCell() }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = viewModel.typeArray[indexPath.section]
        switch section {
        case .premium:
            return CGSize(width: getScreenSize().width,
                          height: 112)
        case .getStarted:
            return CGSize(width: getScreenSize().width,
                          height: 224)
        case .categories:
            let height = CGFloat(3 * 152) + 20
            return CGSize(width: getScreenSize().width,
                          height: height)
        }
    }
}

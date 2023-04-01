//
//  OnboardingViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.isUserInteractionEnabled = false
        let nibs = [OnboardingCVC.self, OnboardingTwoCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var btnContinue: UIButton = {
        let button = UIButton()
        button.backgroundColor = CustomColors.buttonColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,
                                                    weight: .bold)
        button.setTitleColor(.white,
                             for: .normal)
        button.setTitle("Continue",
                        for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = CustomColors.labelColor
        pageControl.pageIndicatorTintColor = CustomColors.labelColor.withAlphaComponent(0.25)
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    lazy var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {

        self.createBlurBackgroundView(color: .white)

        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 608/812)
        ])

        btnContinue.addTarget(self,
                              action: #selector(btnContinueTapped),
                              for: .touchUpInside)
        view.addSubview(btnContinue)
        NSLayoutConstraint.activate([
            btnContinue.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -145),
            btnContinue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            btnContinue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            btnContinue.heightAnchor.constraint(equalTo: btnContinue.widthAnchor, multiplier: 56/327)
        ])

        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: btnContinue.bottomAnchor, constant: 30),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            pageControl.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 20)
        ])
    }

    // MARK: - CONTINUE BUTTON TAPPED TARGET
    @objc private func btnContinueTapped() {
        if index == 0 {
            index += 1
            let indexPath = IndexPath(row: 0, section: index)
            collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
            pageControl.currentPage = 1
        } else {
            let vc = PayWallViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCVC",
                                                                for: indexPath) as? OnboardingCVC else { return UICollectionViewCell() }
            cell.fillCell(with: "Take a photo to identify the plant!",
                          rangeString: "identify",
                          image: UIImage(named: "onboardOne"))
        return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingTwoCVC",
                                                                for: indexPath) as? OnboardingTwoCVC else { return UICollectionViewCell() }
            cell.fillCell(with: "Get plant care guides",
                          rangeString: "care guides",
                          image: UIImage(named: "onboardTwo"))
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate {

}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getScreenSize().width,
                      height: collectionView.frame.height)
    }
}

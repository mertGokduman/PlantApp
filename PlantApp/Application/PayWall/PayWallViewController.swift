//
//  PayWallViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 31.03.2023.
//

import UIKit

struct PayModel {
    var title: String
    var description: String
    var image: UIImage?
}

class PayWallViewController: UIViewController {

    private lazy var btnClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Close"),
                        for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var imgTop: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "payWallBG")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblDescription: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikLight, 17)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Access All Features"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: 156,
                                     height: 130)
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.registerNib(withClassAndIdentifier: PayWallCVC.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return collectionView
    }()

    private lazy var priceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var oneMonthView: PayWallPriceView = {
        let view = PayWallPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var oneYearView: PayWallPriceView = {
        let view = PayWallPriceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var btnTryFree: UIButton = {
        let button = UIButton()
        button.backgroundColor = CustomColors.buttonColor
        button.titleLabel?.font = .custom(.rubikMedium, 16)
        button.setTitleColor(.white,
                             for: .normal)
        button.setTitle("Try free for 3 days",
                        for: .normal)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var lblPriceDescription: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikLight, 9)
        label.textColor = .white.withAlphaComponent(0.52)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "After the 3-day free trial period you’ll be charged ₺274.99 per year unless you cancel before the trial expires. Yearly Subscription is Auto-Renewable"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblContrats: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikRegular, 11)
        label.textColor = .white.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.text = "Terms • Privacy • Restore"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var closeTimer: Timer?
    private var count: Int = 3

    lazy var dataArray: [PayModel] = [PayModel(title: "Unlimited",
                                               description: "Plant Identify",
                                               image: UIImage(named: "scanner")),
                                      PayModel(title: "Faster",
                                               description: "Process",
                                               image: UIImage(named: "speed")),
                                      PayModel(title: "Detailed",
                                               description: "Plant care",
                                               image: UIImage(named: "scanner"))]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - SETUP UI
    private func setupUI() {

        view.backgroundColor = CustomColors.payWallBGColor

        view.addSubview(imgTop)
        NSLayoutConstraint.activate([
            imgTop.topAnchor.constraint(equalTo: view.topAnchor),
            imgTop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgTop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgTop.heightAnchor.constraint(equalTo: imgTop.widthAnchor, multiplier: 490/375)
        ])


        btnClose.addTarget(self,
                           action: #selector(btnCloseTapped),
                           for: .touchUpInside)
        view.addSubview(btnClose)
        NSLayoutConstraint.activate([
            btnClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            btnClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            btnClose.heightAnchor.constraint(equalToConstant: 48),
            btnClose.widthAnchor.constraint(equalToConstant: 48)
        ])

        let titleText = "PlantApp Premium"
        lblTitle.attributedText = titleText.setAttributedString(range: "PlantApp",
                                                                font: .custom(.rubikLight, 24),
                                                                textColor: .white,
                                                                rangeColor: .white,
                                                                rangeFont: .custom(.rubikExtraBold, 24))
        view.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            lblTitle.heightAnchor.constraint(equalToConstant: 47)
        ])

        view.addSubview(lblDescription)
        NSLayoutConstraint.activate([
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor),
            lblDescription.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor)
        ])

        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])

        view.addSubview(priceStack)
        NSLayoutConstraint.activate([
            priceStack.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            priceStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            priceStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            priceStack.heightAnchor.constraint(equalToConstant: 136)
        ])

        oneMonthView.delegate = self
        oneMonthView.fillView(title: "1 Month",
                              description: "$2.99/month, auto renewable",
                              range: "$2.99/month",
                              isDiscount: false)
        priceStack.addArrangedSubview(oneMonthView)
        oneMonthView.deselectView()
        
        oneYearView.delegate = self
        oneYearView.fillView(title: "1 Year",
                             description: "First 3 days free, then $529,99/year",
                             isDiscount: true)
        oneYearView.isSelected = true
        priceStack.addArrangedSubview(oneYearView)
        oneYearView.selecView()

        view.addSubview(btnTryFree)
        NSLayoutConstraint.activate([
            btnTryFree.topAnchor.constraint(equalTo: priceStack.bottomAnchor, constant: 26),
            btnTryFree.leadingAnchor.constraint(equalTo: priceStack.leadingAnchor),
            btnTryFree.trailingAnchor.constraint(equalTo: priceStack.trailingAnchor),
            btnTryFree.heightAnchor.constraint(equalTo: btnTryFree.widthAnchor, multiplier: 52/327)
        ])

        view.addSubview(lblPriceDescription)
        NSLayoutConstraint.activate([
            lblPriceDescription.topAnchor.constraint(equalTo: btnTryFree.bottomAnchor, constant: 8),
            lblPriceDescription.leadingAnchor.constraint(equalTo: btnTryFree.leadingAnchor),
            lblPriceDescription.trailingAnchor.constraint(equalTo: btnTryFree.trailingAnchor)
        ])

        view.addSubview(lblContrats)
        NSLayoutConstraint.activate([
            lblContrats.topAnchor.constraint(equalTo: lblPriceDescription.bottomAnchor, constant: 10),
            lblContrats.leadingAnchor.constraint(equalTo: lblPriceDescription.leadingAnchor),
            lblContrats.trailingAnchor.constraint(equalTo: lblPriceDescription.trailingAnchor),
            lblContrats.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - CLOSE BUTTON TARGET
    @objc private func btnCloseTapped() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = HomeViewController()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PayWallViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PayWallCVC",
                                                            for: indexPath) as? PayWallCVC else { return UICollectionViewCell() }
        cell.fillCell(with: dataArray[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PayWallViewController: UICollectionViewDelegate {

}

// MARK: - PayWallViewDelegate
extension PayWallViewController: PayWallViewDelegate {

    func viewTapped(view: PayWallPriceView) {

        switch view {
        case oneMonthView:
            oneYearView.deselectView()
        case oneYearView:
            oneMonthView.deselectView()
        default:
            break
        }
    }
}
//
//  GetStartedViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import UIKit

class GetStartedViewController: UIViewController {

    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "bgImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblDescription: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikRegular, 16)
        label.textColor = CustomColors.labelColor.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Identify more than 3000+ plants and 88% accuracy."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imgGetStarted: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "getStarted")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var btnGetStarted: UIButton = {
        let button = UIButton()
        button.backgroundColor = CustomColors.buttonColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,
                                                    weight: .bold)
        button.setTitleColor(.white,
                             for: .normal)
        button.setTitle("Get Started",
                        for: .normal)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var lblContrats: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - SETUP UI
    private func setupUI() {

        view.addSubview(bgImage)
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let titleText = "Welcome to PlantApp"
        lblTitle.attributedText = titleText.setAttributedString(range: "PlantApp",
                                                                font: .custom(.rubikRegular, 28),
                                                                textColor: CustomColors.labelColor,
                                                                rangeColor: CustomColors.labelColor,
                                                                rangeFont: .custom(.rubikSemiBold, 28))
        view.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            lblTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        view.addSubview(lblDescription)
        NSLayoutConstraint.activate([
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 8),
            lblDescription.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor)
        ])

        view.addSubview(imgGetStarted)
        NSLayoutConstraint.activate([
            imgGetStarted.topAnchor.constraint(equalTo: lblDescription.bottomAnchor, constant: 24),
            imgGetStarted.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imgGetStarted.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imgGetStarted.widthAnchor.constraint(equalTo: view.widthAnchor),
            imgGetStarted.heightAnchor.constraint(equalTo: bgImage.heightAnchor, multiplier: 499/812)
        ])

        btnGetStarted.addTarget(self,
                                action: #selector(btnGetStartedTapped),
                                for: .touchUpInside)
        view.addSubview(btnGetStarted)
        NSLayoutConstraint.activate([
            btnGetStarted.topAnchor.constraint(equalTo: imgGetStarted.bottomAnchor),
            btnGetStarted.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            btnGetStarted.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            btnGetStarted.heightAnchor.constraint(equalTo: btnGetStarted.widthAnchor, multiplier: 56/327)
        ])

        let contratsText = "By tapping next, you are agreeing to PlantID Terms of Use & Privacy Policy."
        lblContrats.attributedText = contratsText.setAttributedString(range: "Terms of Use",
                                                                      secondRange: "Privacy Policy",
                                                                      font: .custom(.rubikRegular, 11),
                                                                      textColor: CustomColors.contratsColor.withAlphaComponent(0.7),
                                                                      rangeColor: CustomColors.contratsColor.withAlphaComponent(0.7),
                                                                      underline: true)
        view.addSubview(lblContrats)
        NSLayoutConstraint.activate([
            lblContrats.topAnchor.constraint(equalTo: btnGetStarted.bottomAnchor, constant: 17),
            lblContrats.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            lblContrats.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            lblContrats.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -40)
        ])
    }

    // MARK: - GET STARTED BUTTON TARGET
    @objc private func btnGetStartedTapped() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.setRootViewController(OnboardingViewController())
        }
    }
}

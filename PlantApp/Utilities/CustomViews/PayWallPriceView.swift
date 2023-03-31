//
//  PayWallPriceView.swift
//  PlantApp
//
//  Created by Mert Gökduman on 31.03.2023.
//

import Foundation
import UIKit

protocol PayWallViewDelegate: AnyObject {
    func viewTapped(view: PayWallPriceView)
}

final class PayWallPriceView: UIView {

    weak var delegate: PayWallViewDelegate?

    private lazy var imgSelection: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikMedium, 16)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblDescription: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikRegular, 12)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var discountView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = CustomColors.buttonColor
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private lazy var lblDiscount: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikMedium, 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Save 50%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var btnSelect: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let gradientLayer = CAGradientLayer()
    lazy var isSelected: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    // MARK: - SETUP UI
    private func setupUI() {

        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 14
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        self.clipsToBounds = true

        self.setSelectedGradientBG()

        self.addSubview(imgSelection)
        NSLayoutConstraint.activate([
            imgSelection.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imgSelection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imgSelection.widthAnchor.constraint(equalToConstant: 24),
            imgSelection.heightAnchor.constraint(equalToConstant: 24)
        ])

        self.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            lblTitle.leadingAnchor.constraint(equalTo: imgSelection.trailingAnchor, constant: 12),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])

        self.addSubview(lblDescription)
        NSLayoutConstraint.activate([
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 1),
            lblDescription.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor),
            lblDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -13)
        ])

        self.addSubview(discountView)
        NSLayoutConstraint.activate([
            discountView.topAnchor.constraint(equalTo: self.topAnchor),
            discountView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            discountView.widthAnchor.constraint(equalToConstant: 77),
            discountView.heightAnchor.constraint(equalToConstant: 26)
        ])

        discountView.addSubview(lblDiscount)
        NSLayoutConstraint.activate([
            lblDiscount.topAnchor.constraint(equalTo: discountView.topAnchor),
            lblDiscount.bottomAnchor.constraint(equalTo: discountView.bottomAnchor),
            lblDiscount.leadingAnchor.constraint(equalTo: discountView.leadingAnchor),
            lblDiscount.trailingAnchor.constraint(equalTo: discountView.trailingAnchor)
        ])

        btnSelect.addTarget(self,
                            action: #selector(btnSelectTapped),
                            for: .touchUpInside)
        self.addSubview(btnSelect)
        NSLayoutConstraint.activate([
            btnSelect.topAnchor.constraint(equalTo: self.topAnchor),
            btnSelect.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            btnSelect.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            btnSelect.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.bringSubviewToFront(btnSelect)
    }

    // MARK: - SETUP DATAS
    func fillView(title: String,
                  description: String,
                  range: String? = nil,
                  isDiscount: Bool) {
        lblTitle.text = title
        discountView.isHidden = !isDiscount
        if let range = range {
            lblDescription.attributedText = description.setAttributedString(range: range,
                                                                            font: .custom(.rubikRegular, 12),
                                                                            textColor: .white.withAlphaComponent(0.7),
                                                                            rangeColor: .white.withAlphaComponent(0.7),
                                                                            rangeFont: .custom(.rubikLight, 12))
        } else {
            lblDescription.text = description
        }
    }

    // MARK: - VIEW BUTTON TAPPED TARGET
    @objc private func btnSelectTapped() {
        if !isSelected {
            self.selecView()
        }
        delegate?.viewTapped(view: self)
    }

    func selecView() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = CustomColors.buttonColor.cgColor
        imgSelection.image = UIImage(named: "inactive")
        self.setSelectedGradientBG()
        self.isSelected = true
    }

    func setSelectedGradientBG() {
        gradientLayer.colors = [UIColor.clear.cgColor, CustomColors.buttonColor.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 60)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    func deselectView() {
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 0.5
        imgSelection.image = nil
        self.gradientLayer.removeFromSuperlayer()
        self.isSelected = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

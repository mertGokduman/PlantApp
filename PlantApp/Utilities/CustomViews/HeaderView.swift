//
//  HeaderView.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation
import UIKit

final class HeaderView: UIView {

    private lazy var imgBG: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "headerBG")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikRegular, 16)
        label.textColor = CustomColors.labelColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblDayGreetings: UILabel = {
        let label = UILabel()
        label.font = .custom(.rubikMedium, 24)
        label.textColor = CustomColors.labelColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    // MARK: - SETUP UI
    private func setupUI() {

        self.addSubview(imgBG)
        NSLayoutConstraint.activate([
            imgBG.topAnchor.constraint(equalTo: self.topAnchor),
            imgBG.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imgBG.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imgBG.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.addSubview(lblTitle)
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            lblTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])

        self.addSubview(lblDayGreetings)
        NSLayoutConstraint.activate([
            lblDayGreetings.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 6),
            lblDayGreetings.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblDayGreetings.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor),
            lblDayGreetings.heightAnchor.constraint(equalToConstant: 28)
        ])

        self.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: lblDayGreetings.bottomAnchor, constant: 14),
            searchView.leadingAnchor.constraint(equalTo: lblDayGreetings.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: lblDayGreetings.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 44),
            searchView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
    }

    // MARK: - SETUP VIEW DATA
    func setupView(titleText: String,
                   greetingText: String,
                   searchPlaceholderText: String) {
        lblTitle.text = titleText
        lblDayGreetings.text = greetingText
        searchView.setupSearchTF(placeholder: searchPlaceholderText)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

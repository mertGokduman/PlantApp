//
//  SearchView.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation
import UIKit

protocol SearchViewDelegate: AnyObject {
    func beginEditing(text: String)
}

class SearchView: UIView {

    weak var delegate: SearchViewDelegate?

    private lazy var tfSearch: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.font = .custom(.rubikRegular, 16)
        textField.textColor = CustomColors.labelColor
        textField.layer.borderColor =  CustomColors.searchBorderColor.withAlphaComponent(0.25).cgColor
        textField.layer.borderWidth = 0.2
        textField.layer.cornerRadius = 12
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode = .always
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    //LEFT VIEW OF TEXTFIELD
    private lazy var imgSearch: UIView = {
        let tempView = UIView()
        let tempImageView = UIImageView(image: UIImage(named: "search")?.withRenderingMode(.alwaysTemplate))
        tempImageView.tintColor = CustomColors.searchIconColor
        tempImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        tempView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        tempView.addSubview(tempImageView)
        return tempView
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

        tfSearch.addTarget(self,
                           action: #selector(textFieldDidChange(_:)),
                           for: .editingChanged)
        tfSearch.leftView = imgSearch
        self.addSubview(tfSearch)
        NSLayoutConstraint.activate([
            tfSearch.topAnchor.constraint(equalTo: self.topAnchor),
            tfSearch.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tfSearch.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tfSearch.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    //SETUP TEXTFIELD PLACEHOLDER
    func setupSearchTF(placeholder: String) {
        tfSearch.attributedPlaceholder = NSAttributedString( string: placeholder,
                                                             attributes: [
                                                                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14,
                                                                                                               weight: .semibold)
                                                             ])
    }

    // MARK: - Dynamic Search
    @objc private func textFieldDidChange(_ textfield: UITextField) {
        delegate?.beginEditing(text: textfield.text~)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

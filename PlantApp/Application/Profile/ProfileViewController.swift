//
//  ProfileViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 2.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColors.bgColor
    }
}

// MARK: - TabBarItemable
extension ProfileViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Profile",
                       image: UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate),
                       selectedImage: UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate),
                       isEnable: true)
    }
}

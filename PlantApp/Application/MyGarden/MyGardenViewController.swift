//
//  MyGardenViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 2.04.2023.
//

import UIKit

class MyGardenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColors.bgColor
    }
}

// MARK: - TabBarItemable
extension MyGardenViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "My Garden",
                       image: UIImage(named: "myGarden")?.withRenderingMode(.alwaysTemplate),
                       selectedImage: UIImage(named: "myGarden")?.withRenderingMode(.alwaysTemplate),
                       isEnable: true)
    }
}

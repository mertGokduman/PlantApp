//
//  ScanViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 2.04.2023.
//

import UIKit

class ScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColors.bgColor
    }
}

// MARK: - TabBarItemable
extension ScanViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "",
                       image: nil,
                       selectedImage: nil,
                       isEnable: false)
    }
}

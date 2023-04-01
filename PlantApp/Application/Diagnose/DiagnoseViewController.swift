//
//  DiagnoseViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 2.04.2023.
//

import UIKit

class DiagnoseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = CustomColors.bgColor
    }
}

// MARK: - TabBarItemable
extension DiagnoseViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Diagnose",
                       image: UIImage(named: "diagnose")?.withRenderingMode(.alwaysTemplate),
                       selectedImage: UIImage(named: "diagnose")?.withRenderingMode(.alwaysTemplate),
                       isEnable: true)
    }
}

//
//  BaseTabbarController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation
import UIKit

protocol TabBarItemable {
    var tabItem: TabItem { get }
}

class TabItem {
    var title: String = ""
    var image: UIImage?
    var selectedImage: UIImage?
    var isEnable: Bool?

    init(title: String,
         image: UIImage?,
         selectedImage: UIImage?,
         isEnable: Bool?) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.isEnable = isEnable
    }
}

class BaseTabbarController: UITabBarController {

    lazy var btnScan: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 74, height: 64)
        let centerY = getScreenSize().height < 700 ? view.frame.maxY - self.tabBar.frame.height : view.frame.maxY - self.tabBar.frame.height - 22.5
        button.center = CGPoint(x: view.frame.width / 2, y: centerY)
        button.setImage(UIImage(named: "midButton"), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(tabChildren: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        var viewControllers: [UIViewController] = []
        for tabChild in tabChildren {
            guard let tabItem = getTabBarItemable(from: tabChild)?.tabItem else { return }
            tabChild.tabBarItem.image = tabItem.image?.withRenderingMode(.alwaysOriginal)
            tabChild.tabBarItem.selectedImage = tabItem.selectedImage?.withRenderingMode(.alwaysTemplate)
            tabChild.tabBarItem.isAccessibilityElement = true
            tabChild.tabBarItem.title = tabItem.title
            tabChild.tabBarItem.isEnabled = tabItem.isEnable~
            viewControllers.append(tabChild)
        }
        self.viewControllers = viewControllers
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.selectedIndex = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        applyStyles()
        addAddButton()
    }

    private func getTabBarItemable(from viewController: UIViewController) -> TabBarItemable? {
        if let tabBarItemable = viewController as? TabBarItemable {
            return tabBarItemable
        } else if let tabBarItemable = (viewController as? UINavigationController)?.viewControllers.first as? TabBarItemable {
            return tabBarItemable
        }
        return nil
    }

    // MARK: - Tabbar UI
    private func applyStyles() {
        selectedIndex = 0
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white.withAlphaComponent(0.92)
        let tabbarItemAppearance = UITabBarItemAppearance()
        appearance.shadowColor = UIColor(named: "TabbarSelectedColor")
        tabbarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.custom(.rubikRegular, 10),
                                                           NSAttributedString.Key.foregroundColor: CustomColors.tabbarUnselectedColor]
        tabbarItemAppearance.normal.iconColor = CustomColors.tabbarUnselectedColor
        tabbarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.custom(.rubikRegular, 10),
                                                             NSAttributedString.Key.foregroundColor: CustomColors.buttonColor]
        tabbarItemAppearance.selected.iconColor = CustomColors.buttonColor
        appearance.stackedLayoutAppearance = tabbarItemAppearance
        self.tabBarItem.image?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBarItem.image?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
            self.tabBar.itemPositioning = .centered
        }
    }

    // MARK: - ADD MIDDLE BUTTON
    private func addAddButton() {
        self.view.addSubview(btnScan)
        view.bringSubviewToFront(btnScan)
        btnScan.addTarget(self,
                         action: #selector(btnScanTapped),
                         for: .touchUpInside)
    }

    @objc private func btnScanTapped() {
        self.selectedIndex = 2
    }
}

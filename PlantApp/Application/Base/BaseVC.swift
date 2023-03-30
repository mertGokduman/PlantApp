//
//  BaseVC.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import UIKit

class BaseVC<VM>: UIViewController where VM: BaseViewModel {

    lazy var viewModel: VM = VM()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

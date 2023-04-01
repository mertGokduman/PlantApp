//
//  HomeViewModel.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation

enum HomeCollectionType {
    case premium
    case getStarted
    case categories
}

final class HomeViewModel {

    var typeArray: [HomeCollectionType] = [.premium, .getStarted, .categories]
}

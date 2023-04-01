//
//  CategoriesRequestModel.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation

final class CategoriesRequestModel: RequestModel {

    override var path: String {
        return ServiceConstants.categories
    }
}

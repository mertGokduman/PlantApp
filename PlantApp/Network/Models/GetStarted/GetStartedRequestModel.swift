//
//  GetStartedRequestModel.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation

final class GetStartedRequestModel: RequestModel {

    override var path: String {
        return ServiceConstants.getStarted
    }
}

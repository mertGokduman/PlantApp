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

    var categories: ObservableObject<[Category]?> = ObservableObject([])
    var questions: ObservableObject<[GetStartedResponseModel]> = ObservableObject([])

    func getCategories() {
        let request = CategoriesRequestModel()

        NetworkManager.shared.sendRequest(request: request,
                                          type: CategoriesResponseModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.categories.value = response.data
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

    func getQuestions() {
        let request = GetStartedRequestModel()
        NetworkManager.shared.sendRequest(request: request,
                                          type: [GetStartedResponseModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.questions.value = response
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

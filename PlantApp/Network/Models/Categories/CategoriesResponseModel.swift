//
//  CategoriesResponseModel.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation

struct CategoriesResponseModel: Codable {

    var data: [Category]?

    enum CodingKeys: String, CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try? values.decode([Category].self, forKey: .data)
    }
}

struct Category: Codable {

    var id: Int?
    var title: String?
    var rank: Int?
    var image: CategoryImage?

    enum CodingKeys: String, CodingKey {
        case id, title, rank, image
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        rank = try? values.decode(Int.self, forKey: .rank)
        image = try? values.decode(CategoryImage.self, forKey: .image)
    }
}

struct CategoryImage: Codable {

    var url: String?

    enum CodingKeys: String, CodingKey {
        case url
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try? values.decode(String.self, forKey: .url)
    }
}

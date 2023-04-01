//
//  GetStartedResponseModel.swift
//  PlantApp
//
//  Created by Mert Gökduman on 1.04.2023.
//

import Foundation

struct GetStartedResponseModel: Codable {

    var id: Int?
    var title: String?
    var subtitle: String?
    var imageUrl: String?
    var url: String?
    var order: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, order
        case imageUrl = "image_uri"
        case url = "uri"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        subtitle = try? values.decode(String.self, forKey: .subtitle)
        imageUrl = try? values.decode(String.self, forKey: .imageUrl)
        url = try? values.decode(String.self, forKey: .url)
        order = try? values.decode(Int.self, forKey: .order)
    }
}

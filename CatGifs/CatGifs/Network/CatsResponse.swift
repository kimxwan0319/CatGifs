//
//  CatsResponse.swift
//  CatGifs
//
//  Created by 김수완 on 2023/07/20.
//

import Foundation

typealias CatsResponse = [CatResponse]

struct CatResponse: Codable {
    let id: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags
    }
}


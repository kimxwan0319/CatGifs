//
//  CatAPI.swift
//  CatGifs
//
//  Created by 김수완 on 2023/07/20.
//

import Foundation

import Moya

enum CataasAPI {
    case cats(limit: Int, tags: String)
}

extension CataasAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://cataas.com/api")!
    }
    
    var path: String {
        switch self {
        case .cats:
            return "/cats"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .cats(let limit, let tags):
            return .requestParameters(
                parameters: ["limit": limit, "tags": tags],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: [String : String]? {
        return nil
    }
    
}

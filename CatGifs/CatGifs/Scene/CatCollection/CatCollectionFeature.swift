//
//  CatCollectionFeature.swift
//  CatGifs
//
//  Created by 김수완 on 2023/08/03.
//

import Foundation

import ComposableArchitecture

import Moya

struct CatCollectionFeature: Reducer {
    
    private let provider = MoyaProvider<CataasAPI>()
    
    struct State: Equatable {
        var catList = [CatModel]()
        
        var path = StackState<CatDetailFeature.State>()
    }
    
    enum Action: Equatable {
        case viewIsAppear
        case path(StackAction<CatDetailFeature.State, CatDetailFeature.Action>)
        
        case catsResponse([CatModel])
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewIsAppear:
                return .run { send in
                    let catGifUrlList = try? await self.fetchCatGifs()
                    await send(.catsResponse(catGifUrlList ?? []))
                }
            case .catsResponse(let catList):
                state.catList = catList
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            CatDetailFeature()
        }
    }

}

extension CatCollectionFeature {
    private func fetchCatGifs() async throws -> [CatModel] {
        let catsResponse: CatsResponse = try await self.provider.async.request(.cats(limit: 20, tags: "gif"))
        return catsResponse.map {
            CatModel(gifUrl: URL(string: "https://cataas.com/cat/\($0.id)")!, tags: $0.tags)
        }
    }
}

//
//  CatDetailFeature.swift
//  CatGifs
//
//  Created by 김수완 on 2023/08/10.
//

import Foundation

import ComposableArchitecture

struct CatDetailFeature: Reducer {
    
    struct State: Equatable {
        let cat: CatModel
    }
    
    enum Action: Equatable {
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }

}

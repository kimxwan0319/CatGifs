//
//  CatGifsApp.swift
//  CatGifs
//
//  Created by 김수완 on 2023/07/19.
//

import SwiftUI

import ComposableArchitecture

@main
struct CatGifsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CatCollectionView(
                    store: Store(initialState: CatCollectionFeature.State()) {
                        CatCollectionFeature()
                    }
                )
                .navigationTitle("🐈‍⬛ Gifs")
            }
        }
    }
}

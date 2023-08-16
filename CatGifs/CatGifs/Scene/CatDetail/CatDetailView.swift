//
//  CatDetailView.swift
//  CatGifs
//
//  Created by 김수완 on 2023/08/10.
//

import Foundation

import SwiftUI
import ComposableArchitecture

struct CatDetailView: View {
    
    let store: StoreOf<CatDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GIFView(url: viewStore.cat.gifUrl)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

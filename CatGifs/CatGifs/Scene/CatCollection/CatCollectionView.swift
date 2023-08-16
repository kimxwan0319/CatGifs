//
//  CatCollectionView.swift
//  CatGifs
//
//  Created by 김수완 on 2023/08/03.
//

import Foundation

import SwiftUI
import ComposableArchitecture

struct CatCollectionView: View {
    
    let store: StoreOf<CatCollectionFeature>
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            WithViewStore(self.store, observe: { $0 }) { viewStore in
                ScrollView {
                    LazyVGrid(columns: self.columns, spacing: 1) {
                        ForEach(viewStore.catList, id: \.gifUrl) { cat in
                            NavigationLink(state: CatDetailFeature.State(cat: cat)) {
                                GIFView(url: cat.gifUrl)
                                    .aspectRatio(1, contentMode: .fill)
                            }
                        }
                    }
                }
                .onAppear { viewStore.send(.viewIsAppear) }
            }
        } destination: { store in
            CatDetailView(store: store)
        }
    }

}

//struct CatCollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatCollectionView()
//    }
//}

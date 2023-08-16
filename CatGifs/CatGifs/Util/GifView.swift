//
//  GifView.swift
//  CatGifs
//
//  Created by 김수완 on 2023/08/09.
//

import Foundation

import SwiftUI
import Nuke
import Nuke
import FLAnimatedImage

struct GIFView: UIViewRepresentable {
    private var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    private let imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

extension GIFView {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(self.activityIndicator)
        view.addSubview(self.imageView)
        self.imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        activityIndicator.startAnimating()
        Task {
            let image = try! await ImagePipeline(configuration: .withDataCache)
                .imageTask(with: url).response.container.data
            await MainActor.run {
                self.imageView.animatedImage = FLAnimatedImage(animatedGIFData: image)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

//
//  NetworkImage.swift
//  radiostore
//
//  Created by adham khwaldeh on 9/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import SwiftUI
import Kingfisher
import UIKit

public struct NetworkImage: SwiftUI.View {

    // swiftlint:disable:next redundant_optional_initialization
    @State private var image: UIImage? = nil

    public let imageURL: URL?
    public let placeholderImage: UIImage
    public let animation: Animation = .default

    public var body: some SwiftUI.View {
        Image(uiImage: image ?? placeholderImage)
            .resizable()
//            .renderingMode(.template)
//            .foregroundColor(.white)
        .onAppear(perform: loadImage)
            .transition(.opacity)
            .id(image ?? placeholderImage)
    }

    private func loadImage() {
        guard let imageURL = imageURL, image == nil else { return }
//        let options = KingfisherOptionsInfo()
//        options.withca
        KingfisherManager.shared.retrieveImage(with: imageURL,
                                               options: [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)]) { result in
            switch result {
            case .success(let imageResult):
                withAnimation(self.animation) {
                    self.image = imageResult.image
                }
            case .failure:
                break
            }
        }
    }

}

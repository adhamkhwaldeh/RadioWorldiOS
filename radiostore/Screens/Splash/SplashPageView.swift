//
//  SplashPageView.swift
//  radiostore
//
//  Created by adham khwaldeh on 13/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct SplashPageView: View {
    var title: LocalizedStringKey
    var header: LocalizedStringKey
    var content: LocalizedStringKey

    var imageName: String
    var textColor: Color

    let imageWidth: CGFloat = 150
    let textWidth: CGFloat = 350

    var body: some View {
        let size = UIImage(named: imageName)!.size
        let aspect = size.width / size.height

        return VStack(alignment: .center, spacing: 50) {
            Text(title)
                .font(Font.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(textColor)
                .frame(width: textWidth)
                .multilineTextAlignment(.center)
            Image(imageName)
                .resizable()
                .aspectRatio(aspect, contentMode: .fill)
                .frame(width: imageWidth, height: imageWidth)
                .cornerRadius(40)
                .clipped()
            VStack(alignment: .center, spacing: 5) {
                Text(header)
                    .font(Font.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(textColor)
                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                Text(content)
                    .font(Font.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(textColor)
//                    .frame(width: 300, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .padding(60).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, /*alignment: .topLeading*/
                           alignment: .center).navigationBarHidden(true)
    }

}

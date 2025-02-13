//
//  SplashPageModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 13/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct SplashPageModel {
    var title: LocalizedStringKey
    var header: LocalizedStringKey
    var content: LocalizedStringKey
    var imageName: String
    var color: Color
    var textColor: Color

    init(title: LocalizedStringKey, header: LocalizedStringKey, content: LocalizedStringKey,
         imageName: String, color: Color, textColor: Color) {
        self.title = title
        self.header = header
        self.content = content
        self.imageName = imageName
        self.color = color
        self.textColor = textColor
    }

    static var onBoardList: [SplashPageModel] = [

        SplashPageModel(title: Translation.AppName, header: Translation.OurApplication,
                        content: Translation.OurApplicationContent,
                        imageName: "ic_launcher", color: Color(hex: "FFFFFF"), textColor: Color(hex: "4A4A4A")),
        //"007bff" Color(hex: "FFFFFF")),

        SplashPageModel(title: Translation.AppName, header: Translation.SelectYourCountry,
                        content: Translation.SelectYourCountryContent,
                        imageName: "country", color: Color(hex: "4e4e4e"), textColor: Color(hex: "FFFFFF")),
        // "dc3545" Color(hex: "4A4A4A")),"ic_launcher_web" //""

        SplashPageModel(title: Translation.AppName, header: Translation.EnjoyWithUs,
                        content: Translation.EnjoyWithUsContent,
                        imageName: "ic_launcher", color: Color(hex: "FFFFFF"), textColor: Color(hex: "4A4A4A")),
        // "28a745" Color(hex: "4A4A4A"))

    ]


}

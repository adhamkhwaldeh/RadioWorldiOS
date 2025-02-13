//
//  ContentView.swift
//  radiostore
//
//  Created by adham on 12/6/20.
//  Copyright © 2020 adham. All rights reserved.
//

import SwiftUI
import Combine
import ConcentricOnboarding

struct SplashScreenView: View {

//    var link: NavigationView<HomeScreenView>
    var publisher: AnyPublisher<Void, Never>

    @EnvironmentObject var settingsRepository: SettingsRepository

    init() {
        let publisher = PassthroughSubject<Void, Never>()
        self.publisher = publisher.eraseToAnyPublisher()
    }


    @State private var willMoveToNextScreen = false

    var body: some View {

        let pages = (0...2).map { i in
            AnyView(SplashPageView(title: SplashPageModel.onBoardList[i].title, header: SplashPageModel.onBoardList[i].header,
                                   content: SplashPageModel.onBoardList[i].content, imageName: SplashPageModel.onBoardList[i].imageName,
                                   textColor: SplashPageModel.onBoardList[i].textColor)
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).navigationBarHidden(true)
            )
        }


        var a = ConcentricOnboardingView(pages: pages, bgColors: SplashPageModel.onBoardList.map { $0.color })
//        var a = ConcentricOnboardingView(pages: pages, bgColors: [Color(hex: "007bff"), Color(hex: "dc3545"), Color(hex: "28a745")])

//        a.didPressNextButton = {
//            a.goToPreviousPage(animated: true)
//        }
        a.insteadOfCyclingToFirstPage = {
            self.willMoveToNextScreen = true
            self.settingsRepository.afterSplash = true
        }
        a.animationDidEnd = {

        }
        a.didGoToLastPage = {

        }

        return VStack {
            a.navigate(to: HomeScreenView(), when: $willMoveToNextScreen)
        }.environment(\.layoutDirection, LayoutDirection.leftToRight)
//            .edgesIgnoringSafeArea(.all)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).navigationBarHidden(true)
            .navigationViewStyle(.stack)
//        return a.navigatePresentation(to: HomeScreenView(), when: $willMoveToNextScreen)
    }
}


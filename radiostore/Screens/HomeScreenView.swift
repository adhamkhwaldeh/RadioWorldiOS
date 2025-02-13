//
//  HomeScreenView.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeScreenView: View {

    @State private var selectedTab: HomeTabEnum = .home

    @Environment(\.locale) private var locale: Locale

    var body: some View {
        
//        WindowGroup {
            TabView(selection: $selectedTab) {
           
                    NavigationView{
                        HomeViewSection()
                        //                    .edgesIgnoringSafeArea(.all)
                            .navigationBarHidden(false)
                            .navigationBarTitle(Translation.Home, displayMode: .inline)
                    }.tag(HomeTabEnum.home)
                        .tabItem {
                            Text(Translation.Home)
                            Image(systemName: "house.fill") }
                        .navigationBarHidden(true)
                        .navigationViewStyle(.stack) 
            
                
                NavigationView {
                    TrendViewSection().navigationBarHidden(false)
                        .navigationBarTitle(Translation.Trends, displayMode: .inline)
                }.tag(HomeTabEnum.trends)
                    .tabItem {
                        Text(Translation.Trends)
                        Image(ImageAssets.trend)
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }.navigationBarHidden(true)
                    .navigationViewStyle(.stack)
                
                NavigationView {
                    FavouriteViewSection()
                        .navigationBarHidden(false)
                        .navigationBarTitle(Translation.Favorites, displayMode: .inline)
                }.tag(HomeTabEnum.favorites)
                    .tabItem {
                        Text(Translation.Favorites)
                        Image(systemName: "heart") }
                    .navigationBarHidden(true)
                    .navigationViewStyle(.stack)
                
                //            NavigationView { AlarmViewSection()
                //                    .navigationBarHidden(false)
                //                    .navigationBarTitle(Translation.Alarm, displayMode: .inline)
                //            }.tag(HomeTabEnum.alarm)
                //                .tabItem {
                //                Text(Translation.Alarm)
                //                Image(systemName: "person.crop.circle") }
                //                .navigationBarHidden(true)
                
                NavigationView { SettingViewSection()
                        .navigationBarHidden(false)
                        .navigationBarTitle(Translation.Settings, displayMode: .inline)
                }.tag(HomeTabEnum.settings)
                    .tabItem {
                        Text(Translation.Settings)
                        Image(systemName: "gear") }
                    .navigationBarHidden(true)
                    .navigationViewStyle(.stack) 
                //                .environmentObject(settingsRepository)
                
            }.environment(\.layoutDirection, locale.layoutDirection)
            //            .tabViewStyle(PageTabViewStyle())
                .edgesIgnoringSafeArea(.all)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).navigationBarHidden(true)
            
        }
//    }

}

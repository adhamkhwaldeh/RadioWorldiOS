//
//  StationCell.swift
//  radiostore
//
//  Created by adham khwaldeh on 24/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import AVKit
import AVFoundation
import Foundation
import SwiftUI
import Combine
import Kingfisher

struct StationCell: View {

    @ObservedObject var viewModel = StationViewModel()

    @ObservedObject var favoriteViewModel = StationFavoriteViewModel()

    @ObservedObject var alarmViewModel = StationAlarmViewModel()

    @EnvironmentObject var radioPlayer: RadioPlayerViewModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    @State var isDetails: Bool = false

    private var station: Stations

    private var orginalList: [Stations]

    init(poJo: Stations, orginalList: [Stations]) {
        self.station = poJo
        self.orginalList = orginalList
        favoriteViewModel.isFavouriteStation(station: station)
        alarmViewModel.isAlarmStation(station: station)
    }

    var body: some View {

        HStack {
            NetworkImage(imageURL: URL(string: station.favicon ?? ""),
                         placeholderImage: UIImage(named: ImageAssets.app_icon)!)
                .aspectRatio(contentMode: .fill).clipShape(Circle())
                .frame(width: 75, height: 75, alignment: .center)

            VStack {

                HStack {
                    Text(station.name ?? "").font(.headline).lineLimit(1)
                        .allowsTightening(true).multilineTextAlignment(.leading)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: .infinity, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                               maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                    Image(systemName: favoriteViewModel.isFavourite ? "heart.fill" : "heart")
                        .onTapGesture {
                        favoriteViewModel.isFavourite ? favoriteViewModel.deleteFavouriteStation(station: station)
                        : favoriteViewModel.addFavouriteStation(station: station)
                    }.frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50, alignment: .trailing)
                        .foregroundColor(.red)
                        .cornerRadius(8)
                }

                HStack {
                    Text(station.tags?.replacingOccurrences(of: ",", with: " ") ?? "").font(.subheadline)
                        .lineLimit(2).allowsTightening(true).multilineTextAlignment(.leading)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                    Text("\(station.countrycode?.flag() ?? "")")
                        .frame(width: 30, height: 30, alignment: .trailing)

                    Image(ImageAssets.ic_website_24dp)
                        .renderingMode(.template)
                        .foregroundColor((colorScheme == ColorScheme.dark) ? Color(.white) : Color(.gray))
                        .onTapGesture {
                        if((station.homepage ?? "").isEmpty) {

                        } else {
                            isDetails = true
                        }
                    }.frame(width: 30, height: 30, alignment: .trailing)

                    NavigationLink(destination: WebViewScreen(url: station.homepage ?? ""), isActive: $isDetails) {
                        EmptyView()
                    }.opacity(0.0).frame(width: 0, height: 0, alignment: .trailing)
                }

            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
            radioPlayer.stationList = orginalList
            let ind = self.orginalList.firstIndex { (itm) -> Bool in
                itm.stationuuid == station.stationuuid
            } ?? 0
            radioPlayer.currentIndex = ind
        }

    }

}


//                Button(action: {
//                    alarmViewModel.isAlarm ? alarmViewModel.deleteAlarmStation(station: station)
//                    : alarmViewModel.addAlarmStation(station: station)
//                }) {
//                    Text(alarmViewModel.isAlarm ? Translation.UnAlarm : Translation.Alarm)
//                        .padding()
//                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
//                    .foregroundColor(.white)
//                    .background(Color.red)
//                    .cornerRadius(8)


//            switch(viewModel.stationPlayableState) {
//            case NetworkState.content(let playableStation): //(let playableStation):
//                if #available(iOS 14.0, *) {
////                    AVAudioPlayer()
////                    VideoPlayer(player: AVPlayer(url: URL(string: playableStation.url!)!))
////                    VideoPlayer(player: player)
//
//                } else {
//                    // Fallback on earlier versions
//                }
//            case .loading: HStack { } // break
//
//            case .loadingDismiss: HStack { } //break
//
//            case .error(_): HStack { } //break
//
//            }


//                KFImage.url(URL(string: station.favicon ?? "") ))
////                         .placeholder(placeholderImage)
////                         .setProcessor(processor)
//                .resizable()
//                    .loadDiskFileSynchronously()
//                    .cacheMemoryOnly()
////                         .lowDataModeSource(.network(lowResolutionURL))
//                .onProgress { receivedSize, totalSize in }
//                    .onSuccess { result in }
//                    .onFailure { error in }
//                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

//
//  NowPlayingView.swift
//  FRadioPlayer_SwiftUI
//
//  Created by Urayoan Miranda on 12/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import FRadioPlayer
import URLImage

struct NowPlayingView: View {

    @EnvironmentObject var radioPlayer: RadioPlayerViewModel

    var body: some View {

        VStack {
            Divider()
            HStack {
                if(URL(string: radioPlayer.radio.station.favicon ?? "") != nil) {
                    URLImage(url: URL(string: radioPlayer.radio.station.favicon ?? "")!,
                             empty: {
                                 EmptyView()
                             },
                             inProgress: { progress in
                                 Image(uiImage: UIImage(named: ImageAssets.app_icon)!).resizable()
                                     .aspectRatio(contentMode: .fill).clipShape(Circle())
                                     .frame(width: 50, height: 50, alignment: .center)
                             },
                             failure: { error, retry in
                                 Image(uiImage: UIImage(named: ImageAssets.app_icon)!).resizable()
                                     .aspectRatio(contentMode: .fill).clipShape(Circle())
                                     .frame(width: 50, height: 50, alignment: .center)
                             },
                             content: { image, info in
                                 image.resizable()
                                     .aspectRatio(contentMode: .fill).clipShape(Circle())
                                     .frame(width: 50, height: 50, alignment: .center)
                                 //                                 .aspectRatio(contentMode: .fit)
                             })
                } else {
                    Image(uiImage: UIImage(named: ImageAssets.app_icon)!).resizable()
                        .aspectRatio(contentMode: .fill).clipShape(Circle())
                        .frame(width: 50, height: 50, alignment: .center)
                }


                //            NetworkImageBinding(url: radioPlayer.radio.station.favicon,
                //                                placeholderImage: UIImage(named: ImageAssets.app_icon)!)
                //                .aspectRatio(contentMode: .fill).clipShape(Circle())
                ////                .frame(width: 75, height: 75, alignment: .center)
                ////                .resizable()
                //            .foregroundColor(Color.secondary)
                //                .scaledToFit()
                //                .frame(width: 75, height: 75, alignment: .center)
                //                .frame(width: 50, height: 50, alignment: .center)


                VStack(alignment: .leading, spacing: 8, content: {

                    Text(radioPlayer.radio.station.name ?? "")
                        .font(.body)
                        .bold()
                        .lineLimit(1)
                        .allowsTightening(true)
                        .frame(alignment: .leading)

                    Text(radioPlayer.radio.station.tags ?? "")
                        .font(.footnote)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .frame(alignment: .trailing)

                }).frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomLeading)

                //            .frame(width: 0, maxWidth: Double.infinity, height: 0, maxHeight: Double.infinity)

                Spacer().frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomTrailing)

                AirPlayView().frame(width: 50, height: 50).frame(minWidth: 0, maxWidth: .infinity, alignment: .bottomTrailing)
            }

        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .bottom).padding(.horizontal)
//            .background(Color(UIColor.secondarySystemBackground))
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        let state = RadioPlayerViewModel()
        NowPlayingView()
            .environmentObject(state)
            .preferredColorScheme(.dark)
    }
}


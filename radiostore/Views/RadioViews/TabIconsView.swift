//
//  TabIconsView.swift
//  FRadioPlayer_SwiftUI
//
//  Created by Urayoan Miranda on 12/4/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import FRadioPlayer

struct TabIconsView: View {

    @EnvironmentObject var radioPlayer: RadioPlayerViewModel

    @Environment(\.locale) private var locale: Locale

    var body: some View {
        HStack {
            Spacer()

            Button(action: {
                radioPlayer.currentIndex -= 1
            }) {
                Image(systemName: locale.isLTR ? "backward.fill" : "forward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }

            Spacer()

            Button(action: {
                radioPlayer.player.togglePlaying() //1221
//                if(radioPlayer.avPlayer.status == .readyToPlay) {
//                    radioPlayer.avPlayer.play()
//                } else {
//                    radioPlayer.avPlayer.pause()
//                }

            }) {
                Image(systemName: radioPlayer.radio.playbackState == .playing ? "pause.fill" : "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }

            Spacer()

            Button(action: {
                radioPlayer.player.stop()//1221
//                radioPlayer.avPlayer.replaceCurrentItem(with: nil)
            }) {
                Image(systemName: "stop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }

            Spacer()

            Button(action: {
                radioPlayer.currentIndex += 1
            }) {
                Image(systemName: locale.isLTR ? "forward.fill" : "backward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }

            Spacer()

        }.padding(16)
            .foregroundColor(.primary)
    }
}

struct TabIconsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = RadioPlayerViewModel()

        TabIconsView()
            .environmentObject(state)
            .preferredColorScheme(.dark)
    }
}

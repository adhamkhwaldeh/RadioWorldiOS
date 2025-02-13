//
//  RadioPlayerViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/1/21.
//  Copyright © 2021 adham. All rights reserved.
//
import UIKit
import SwiftUI
import GRDB
import AlamofireNetworkActivityLogger
import FRadioPlayer

import AVKit
import AVFoundation
import MediaPlayer
import os.log
import Foundation


class RadioPlayerViewModel: NSObject, FRadioPlayerDelegate, ObservableObject {

    @Published var radio = RadioPlayer()

    var stationList: [Stations] = []

    // Singleton ref to player
    var player: FRadioPlayer = FRadioPlayer.shared

    var currentIndex = 0 {
        didSet {
            defer {
//                stationDidChange(station: stationList[currentIndex])
                playerPlay()
            }

            guard 0 ..< stationList.endIndex ~= currentIndex else {
                currentIndex = currentIndex < 0 ? stationList.count - 1: 0
                return
            }
        }
    }

    var lastTraficMonitorTime: TimeInterval = Date().timeIntervalSince1970
    var lastTrackCommandTime: TimeInterval = Date().timeIntervalSince1970
    var trackCommandInterval: Double = 0.1
    //* background section started *//


    override init() {
        super.init()
        player.delegate = self
        player.artworkSize = 500
        player.isAutoPlay = true

        //** background started *//
        UIApplication.shared.beginReceivingRemoteControlEvents()

        NotificationCenter.default.addObserver(self, selector: #selector(self.handleRouteChange(notification:)), name: AVAudioSession.routeChangeNotification, object: player)//AVAudioSession.sharedInstance())
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleInterruption(notification:)), name: AVAudioSession.interruptionNotification, object: nil)

        //** background ended *//

        setupRemoteTransportControls()
        setBackground()

    }


    /* background listener started */

    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
//            if self.avPlayer.rate == 0.0 {
//                self.avPlayer.play()
//                return .success
//            }//2112
            if self.player.rate == 0.0 {
                self.player.play()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
//            if self.avPlayer.rate == 1.0 {
//                self.avPlayer.pause()
//                return .success
//            }//2112
            if self.player.rate == 1.0 {
                self.player.pause()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Previous Command
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            if NSDate().timeIntervalSince1970 - self.lastTrackCommandTime >= self.trackCommandInterval {
                self.selectPrevious()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Next Command
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
//            if NSDate().timeIntervalSince1970 - self.lastTrackCommandTime >= self.trackCommandInterval {
//                self.selectNext()
//                return .success
//            }
            let sz = stationList.count - 1
            if(currentIndex < sz) {
                currentIndex += 1
                return .success
            }
            return .commandFailed
        }
    }

    func setBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay])
            os_log("Playback OK.", log: OSLog.default, type: .debug)
            try AVAudioSession.sharedInstance().setActive(true)
            os_log("Session is Active.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Error when setBackground(): %@", log: OSLog.default, type: .error, error as CVarArg)
        }
    }

    /* background listener ended */


    /* Player options started */
    func setupNowPlayingInfo() {

        DispatchQueue.main.async {
            let station = self.radio.station
            let url = (station.favicon != nil && !station.favicon!.isEmpty) ? URL(string: station.favicon!) : nil
            if(url != nil) {
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in

                    let downloadedImage = ((data != nil) ? UIImage(data: data!) : nil)
                        ?? UIImage(named: ImageAssets.app_icon)!

                    let artwork = MPMediaItemArtwork.init(boundsSize: CGSize(width: 500, height: 500), //downloadedImage.size,
                    requestHandler: { _ -> UIImage in
                        return downloadedImage
                    })

                    // Define Now Playing Info
                    var nowPlayingInfo = [String: Any]()
                    nowPlayingInfo[MPMediaItemPropertyTitle] = station.name
                    nowPlayingInfo[MPMediaItemPropertyGenre] = station.tags
                    nowPlayingInfo[MPMediaItemPropertyLyrics] = station.country
                    nowPlayingInfo[MPMediaItemPropertyArtist] = station.tags
                    nowPlayingInfo[MPMediaItemPropertyRating] = station.language
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo

                }).resume()
            } else {
                // Define Now Playing Info
                var nowPlayingInfo = [String: Any]()
                nowPlayingInfo[MPMediaItemPropertyTitle] = station.name
                nowPlayingInfo[MPMediaItemPropertyGenre] = station.tags
                nowPlayingInfo[MPMediaItemPropertyLyrics] = station.country
                nowPlayingInfo[MPMediaItemPropertyArtist] = station.tags
                nowPlayingInfo[MPMediaItemPropertyRating] = station.language
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize: CGSize(width: 500, height: 500), //downloadedImage.size,
                requestHandler: { _ -> UIImage in
                    return UIImage(named: ImageAssets.app_icon)!
                })
                MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            }

        }

    }

    func selectPrevious() {
        self.lastTrackCommandTime = NSDate().timeIntervalSince1970
        if(currentIndex > 0) {
            currentIndex -= 1
        } else {
            currentIndex = max(0, stationList.count - 1)
        }
        self.lastTrackCommandTime = NSDate().timeIntervalSince1970
    }

    func selectNext() {
        self.lastTrackCommandTime = NSDate().timeIntervalSince1970
        if (currentIndex >= stationList.count - 1) {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
        self.lastTrackCommandTime = NSDate().timeIntervalSince1970
    }

    func prepareToPlay() {
//        guard let url = URL(string: (stationList[currentIndex].url)!) else { return }
        // Create the asset to play
//        asset = AVAsset(url: url)

        // Create a new AVPlayerItem with the asset and an
        // array of asset keys to be automatically loaded
//        avPlayerItem = AVPlayerItem(asset: asset,
//                                    automaticallyLoadedAssetKeys: requiredAssetKeys)

        // Register as an observer of the player item's status property
//        avPlayerItem.addObserver(self,
//                                 forKeyPath: #keyPath(AVPlayerItem.status),
//                                 options: [.old, .new],
//                                 context: &playerItemContext)

        // Associate the player item with the player
//        avPlayer = AVPlayer(playerItem: avPlayerItem)
//
//        avPlayer.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)

//        avPlayer = AVPlayer(playerItem: avPlayerItem)

        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
    }

    func playerPlay() {
        radio.station = stationList[currentIndex]
        guard let url = URL(string: (self.radio.station.url)!) else { return }
        player.radioURL = url
        setupNowPlayingInfo()
        player.play()


//        let url = URL(string: station.url ?? "")! //URL(string: "http://cassini.shoutca.st:9300/stream")!
////        player.radioURL = url //1221
//        radio.station = station
//        setCurrentStation(station: station, sourceIndex: 0)
//        setupNowPlayingInfo()
//        play()


    }

    func playerPause() {
        player.pause()
    }
    /* Player options started */


    /* Notification status started */

    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        if type == .began {
            // Interruption began, take appropriate actions
            playerPause()
        } else if type == .ended {
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Interruption Ended - playback should resume
                    playerPlay()
                } else {
                    // Interruption Ended - playback should NOT resume
                }
            }
        }
    }

    @objc func handleRouteChange(notification: Notification) -> Void {

        if let userInfo = notification.userInfo,
            let changeResonNumber = userInfo[AVAudioSessionRouteChangeReasonKey] as? AVAudioSession.RouteChangeReason,
            let changeResonDescription = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? [AVAudioSessionPortDescription] {
            print(changeResonNumber)
            switch changeResonNumber {
            case .oldDeviceUnavailable:
                if changeResonDescription[1].portType == AVAudioSession.Port.headphones
                    || changeResonDescription[1].portType == AVAudioSession.Port.bluetoothLE
                    || changeResonDescription[1].portType == AVAudioSession.Port.bluetoothHFP
                    || changeResonDescription[1].portType == AVAudioSession.Port.bluetoothA2DP {
                    playerPause()
                } else {
                    playerPlay()
                }
            default:
                playerPause()
            }
        }

    }

    /* Notification status started */




    /* FRadioPlayer listener started */

    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        radio.playerState = state
    }

    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        radio.playbackState = state
    }

    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
//        guard let artistName = artistName, let trackName = trackName else {
//            radio.station = stationList[currentIndex]
//            return
//        }
//        radio.station = stationList[currentIndex]
//        radio.track.artist = artistName
//        radio.track.name = trackName
    }

    func radioPlayer(_ player: FRadioPlayer, itemDidChange url: URL?) {
        radio.url = url
    }

    func radioPlayer(_ player: FRadioPlayer, metadataDidChange rawValue: String?) {
        radio.rawMetadata = rawValue
    }

    func radioPlayer(_ player: FRadioPlayer, artworkDidChange artworkURL: URL?) {
        // Please note that the following example is for demonstration purposes only, consider using asynchronous network calls to set the image from a URL.
//        guard let artworkURL = artworkURL, let data = try? Data(contentsOf: artworkURL) else {
//            radio.track.image = UIImage(#imageLiteral(resourceName: "screen 4"))
//            return
//        }

//        radio.track.image = UIImage(data: data)
    }

    /* FRadioPlayer listener ended */


}


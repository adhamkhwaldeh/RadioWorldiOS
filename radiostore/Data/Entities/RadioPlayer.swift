//
//  RadioPlayer.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import FRadioPlayer

struct RadioPlayer {
    var station = Stations()
    var playerState = FRadioPlayerState.urlNotSet
    var playbackState = FRadioPlaybackState.stopped
    var url: URL? = nil
    var rawMetadata: String? = nil
}

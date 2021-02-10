//
//  VideoPlayerView.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 09.02.2021.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}


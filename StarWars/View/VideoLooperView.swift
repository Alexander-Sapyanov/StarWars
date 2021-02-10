//
//  VideoLooperView.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 09.02.2021.
//

import UIKit
import AVFoundation

class VideoLooperView: UIView {
    let videos: [Video]
    let videoPlayerView = VideoPlayerView()
    
    
    @objc private let queuePlayer = AVQueuePlayer()
    
    private var token: NSKeyValueObservation?
    
    init(videos: [Video]) {
        self.videos = videos
        
        super.init(frame: .zero)
        
        initilizePlayer()
    }
    
    override func layoutSubviews() {
        addSubview(videoPlayerView)
        videoPlayerView.frame = bounds
    }
    private func initilizePlayer() {
        videoPlayerView.player = queuePlayer
        addAllVideosToPlayer()
        
        
        queuePlayer.volume = 10
        queuePlayer.play()
        
        
        token = queuePlayer.observe(\.currentItem, changeHandler: { (player, _ ) in
            if self.queuePlayer.items().count == 1 {
                self.addAllVideosToPlayer()
            }
        })
    }
    
    func pause() {
        queuePlayer.pause()
    }
    func play() {
        queuePlayer.play()
    }
    
    private func addAllVideosToPlayer() {
        for video in videos {
            let asset = AVURLAsset(url: video.url)
            
            
            let item = AVPlayerItem(asset: asset)
            
            queuePlayer.insert(item, after: queuePlayer.items().last)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

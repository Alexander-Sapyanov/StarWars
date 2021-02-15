//
//  Video.swift
//  StarWars
//
//  Created by Alexander  Sapianov on 09.02.2021.
//

import Foundation
import UIKit


struct Video {
    let url: URL
    let filmImage: UIImage
    let title: String
    
    
    static func localVideos() -> [Video] {
        var videos: [Video] = []
        
        let titles = ["A New Hope",
                      "The Empire strikes back",
                      "Return of the Jedi",
                      "Phantom menace",
                      "Attack of the clones",
                      "Revenge of the sith"]
        let movieNames = ["videos", "videos2", "videos3"]
        
        for (index, name) in movieNames.enumerated() {
            let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
            let url = URL(fileURLWithPath: urlPath)
            let video = Video(url: url, filmImage: UIImage(named: titles[index])!, title: titles[index])
            videos.append(video)
        }
        return videos
    }
}

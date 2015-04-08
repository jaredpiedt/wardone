//
//  VideoViewController.swift
//  googlemapstest
//
//  Created by Camron Godbout on 3/23/15.
//  Copyright (c) 2015 Camron Godbout. All rights reserved.
//

import Foundation
import MediaPlayer


class VideoViewController: UIViewController
{
    var moviePlayer : MPMoviePlayerController?
    var videoName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playVideo()
    {
        println(videoName)
        let path = NSBundle.mainBundle().pathForResource(videoName!, ofType:"mp4")
        println(path)
        let url = NSURL.fileURLWithPath(path!)
        println(url)
        moviePlayer = MPMoviePlayerController(contentURL: url)
        if let player = moviePlayer {
            player.view.frame = self.view.bounds
            player.prepareToPlay()
            player.scalingMode = .AspectFit
            self.view.addSubview(player.view)
        }
    }
}
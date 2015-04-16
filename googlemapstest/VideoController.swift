//
//  VideoController.swift
//  ToolbarCombined
//
//  Created by Olga Agafonova on 4/14/15.
//  Copyright (c) 2015 Olga Agafonova. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class VideoController: PageItemController
{
    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createVideoPlayer()
    }
    
    private func createVideoPlayer()
    {
        
        let path = NSBundle.mainBundle().pathForResource("btw", ofType:"m4v")
        let url = NSURL.fileURLWithPath(path!)
        
        moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)        
        
        self.view.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
        
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "doneButtonClick:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
    }
    
    func doneButtonClick(sender:NSNotification?){
  //     moviePlayer.view.removeFromSuperview()
  // 
  //      let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("NavigationController")
  //      
  //      self.showViewController(vc as! UIViewController, sender: vc)
      performSegueWithIdentifier("unwind", sender: self)
      
      
        
    }
    
    
}
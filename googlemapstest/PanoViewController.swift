//
//  PanoViewController.swift
//  googlemapstest
//
//  Created by Camron Godbout on 3/16/15.
//  Copyright (c) 2015 Camron Godbout. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class PanoViewController: UIViewController, GMSPanoramaViewDelegate
{
    var marker: GMSMarker!
    let manager = CMMotionManager()
    var panoView : GMSPanoramaView!
    var panoCam : GMSPanoramaCamera!
    
    private var motionRate:CGFloat!
    private let minimumXOffset:CGFloat = -360
    private let maximumXOffset:CGFloat = 360

    override func viewDidLoad()
    {
        super.viewDidLoad()
        println("DID WE MAKE IT THIS FAR OR NAH")
        if marker != nil
        {
            panoView = GMSPanoramaView.panoramaWithFrame(CGRectZero,
                nearCoordinate:marker.position)
            var m = GMSMarker(position: marker.position)
            m.title = "Text here"
            m.snippet = "Here is a snippet"
            m.infoWindowAnchor = CGPointMake(0.5, 0.5)
            //m.icon = UIImage(named: "Green pin marker icon-2.jpg")
            m.panoramaView = panoView
            
            self.view = panoView
            if manager.gyroAvailable
            {
                manager.gyroUpdateInterval = 0.01
                manager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (gyroData:CMGyroData!, error:NSError!) -> Void in
                        self.rotatePano(gyroData)
                    
                })
            }
        }
    }
    
    func rotatePano(gyroData:CMGyroData){
        let rotationRate = CGFloat(gyroData.rotationRate.y)
        if abs(rotationRate) >= 0.1{
            var temp : CGFloat = CGFloat(panoView.camera.orientation.heading)
            var offsetX = temp - rotationRate
//            if offsetX > self.maximumXOffset{
//                
//                offsetX = self.maximumXOffset
//            }
//            else if offsetX < self.minimumXOffset{
//                
//                offsetX = self.minimumXOffset
//            }
            panoView.camera = GMSPanoramaCamera(heading: CLLocationDirection(offsetX), pitch: 0, zoom:1)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}






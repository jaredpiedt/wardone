//
//  PanoViewController.swift
//  googlemapstest
//
//  Created by Camron Godbout on 3/16/15.
//  Copyright (c) 2015 Camron Godbout. All rights reserved.
//

import Foundation

class PanoViewController: UIViewController, GMSPanoramaViewDelegate {
    override func viewDidLoad()
    {
        var panoView = GMSPanoramaView.panoramaWithFrame(CGRectZero,
            nearCoordinate:marker.position)
        var m = GMSMarker(position: marker.position)
        m.title = "Text here"
        m.snippet = "Here is a snippet"
        m.infoWindowAnchor = CGPointMake(0.5, 0.5)
        //m.icon = UIImage(named: "image.png")
        m.panoramaView = panoView
        self.view = panoView
    }
}



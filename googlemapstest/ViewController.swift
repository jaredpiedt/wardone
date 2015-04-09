//
//  ViewController.swift
//  googlemapstest
//
//  Created by Camron Godbout on 3/15/15.
//  Copyright (c) 2015 Camron Godbout. All rights reserved.
//

import UIKit
import CoreLocation
import MediaPlayer

class ViewController: UIViewController, GMSPanoramaViewDelegate, GMSMapViewDelegate {

    //@IBOutlet weak var mapView: GMSMapView!
    var mapView: GMSMapView!
    var segMarker: GMSMarker!
    
    
    var moviePlayer : MPMoviePlayerController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        var panoramaNear = CLLocationCoordinate2DMake(50.059139, -122.958391)
//        var panoramaNear = CLLocationCoordinate2DMake(33.995706, -81.033082)
//
//        
//        var panoView = GMSPanoramaView.panoramaWithFrame(CGRectZero,
//                nearCoordinate:panoramaNear)
//        // Create a marker at the Eiffel Tower
//        var position = CLLocationCoordinate2DMake(33.99531,-81.034042)
//        var marker = GMSMarker(position: position)
//        marker.title = "Text here"
//        marker.snippet = "Here is a snippet"
//        marker.infoWindowAnchor = CGPointMake(0.5, 0.5)
//        marker.icon = UIImage(named: "image.png")
//        marker.panoramaView = panoView
//        self.view = panoView
        
        var camera = GMSCameraPosition.cameraWithLatitude(33.995706 ,
            longitude: -81.033082, zoom: 17, bearing: -20, viewingAngle: 0)
        
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.mapView.delegate = self
        self.view = mapView
        
//        mapView.frame = CGRectZero
//        mapView.camera = camera
//
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(33.995706, -81.033082)
        marker.title = "827 Assembly St."
        marker.snippet = "snippet"
        marker.map = mapView
        
        
        var marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2DMake(33.995498, -81.032771)
        marker2.title = "810 Assembly St."
        marker2.snippet = "snippet"
        marker2.map = mapView
        
        var marker3 = GMSMarker()
        marker3.position = CLLocationCoordinate2DMake(33.994251, -81.032216)
        marker3.title = "716 Assembly St."
        marker3.snippet = "snippet"
        marker3.map = mapView
        
        var marker4 = GMSMarker()
        marker4.position = CLLocationCoordinate2DMake(33.994158, -81.032373)
        marker4.title = "713 Assembly St."
        marker4.snippet = "Snippet"
        marker4.map = mapView
        
        //mapView.touchesBegan(<#touches: NSSet#>, withEvent: <#UIEvent#>)
        
        // Add the marker to a GMSMapView object named mapView
//        marker.map = mapView
        
        var southWest = CLLocationCoordinate2DMake(33.984110, -81.038885);
        var northEast = CLLocationCoordinate2DMake(34.005605, -81.028186);
        var overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        
        var icon = UIImage(named: "map.png")
        
        var center = CLLocationCoordinate2DMake(33.99474, -81.033249)
        
        var overlay = GMSGroundOverlay(position: center, icon: icon, zoomLevel: 17)
        //var overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
        overlay.bearing = -20
        overlay.map = mapView
        
    }
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        println(marker.title)
        if let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView {
            infoView.nameLabel.text = marker.title
            println(marker.title + "png")
            infoView.placePhoto.image = UIImage(named: marker.title + "png")
            return infoView
        } else {
            return nil
        }
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {

        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let visitAction = UIAlertAction(title: "Visit", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
                self.segMarker = marker
                self.performSegueWithIdentifier("PanoSegue", sender: self)
        })
        let saveAction = UIAlertAction(title: "Info", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Congrats the user selected other option...")
        })
        let videoAction = UIAlertAction(title: "Video", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("VideoSegue", sender: self)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(visitAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(videoAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.identifier)
        if segue.identifier == "PanoSegue"
        {
            var destVC = segue.destinationViewController as PanoViewController
            destVC.marker = segMarker
        }
        else if segue.identifier == "VideoSegue"
        {
            var destVC = segue.destinationViewController as VideoViewController
            destVC.videoName = "sample_mpeg4" //this will obvious be changed once we get more videos
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

//        var camera = GMSCameraPosition.cameraWithLatitude(33.995706,
//            longitude:-81.033082, zoom:17.5, bearing:30, viewingAngle:40)
//        
//        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
//        self.view = mapView

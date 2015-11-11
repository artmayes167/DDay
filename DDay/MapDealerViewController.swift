//
//  MapDealerViewController.swift
//  DDay
//
//  Created by Mayes, Arthur E. on 11/10/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class Store: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}

class MapDealerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return manager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()

    
        
        
        let washington = Store(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotation(washington)
        
        
        self.displayInFlyoverMode()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
        } else {
            // ...
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if case .AuthorizedWhenInUse = status {
            manager.requestLocation()
        }
    }
    
    func displayInFlyoverMode() {
        mapView.mapType = .SatelliteFlyover
        mapView.showsBuildings = true
        let location = CLLocationCoordinate2D(latitude: 39.9522, longitude: -75.1640233)
        let altitude: CLLocationDistance  = 500
        let heading: CLLocationDirection = 90
        let pitch = CGFloat(45)
        let camera = MKMapCamera(lookingAtCenterCoordinate: location, fromDistance: altitude, pitch: pitch, heading: heading)
        mapView.setCamera(camera, animated: true)
    }
    
    
    
}

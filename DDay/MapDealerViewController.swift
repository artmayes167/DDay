//
//  MapDealerViewController.swift
//  DDay
//
//  Created by Mayes, Arthur E. on 11/10/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//  http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_MKMapItem_Application

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

class MapDealerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    // -- outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    // - vars
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return manager
    }()
    
    let geoCoder = CLGeocoder()
    
    let regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()

        //self.locationManager.requestLocation()
        self.mapView.showsUserLocation = true
        
        
        /*
        //let washington = Store(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        //mapView.addAnnotation(washington)
        */
        
        
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

    // MARK: - Helpers
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
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
    
    func flyByToLocation(location:CLLocation) {
        mapView.mapType = .SatelliteFlyover
        mapView.showsBuildings = true
        let altitude: CLLocationDistance  = 500
        let heading: CLLocationDirection = 90
        let pitch = CGFloat(45)
        let camera = MKMapCamera(lookingAtCenterCoordinate: location.coordinate, fromDistance: altitude, pitch: pitch, heading: heading)
        mapView.setCamera(camera, animated: true)
        
    }
    
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            
            self.flyByToLocation(location)
            
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
    
    
    
    // MARK: - MapView
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.flyByToLocation(userLocation.location!)
    }
    
    
    
    
    // MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
       // print(searchBar.text)
        
        
        // http://stackoverflow.com/questions/10417022/how-to-get-multiple-placemarks-from-clgeocoder
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = self.searchBar.text
        //localSearchRequest.region = MKCoordinateRegionMakeWithDistance(loc, kSearchMapBoundingBoxDistanceInMetres, kSearchMapBoundingBoxDistanceInMetres);
        
        
        
        
        self.geoCoder.geocodeAddressString(self.searchBar.text!) { (placemarks, error) -> Void in
            
            if error != nil {
                print("Geocode failed with error: \(error!.localizedDescription)")
            } else if placemarks?.count > 0 {
                
                //print(placemarks![0])
                print ("location.count:\(placemarks!.count)")
                
                let placemark = placemarks!.first as! CLPlacemark!
                let point = MKPointAnnotation()
                point.coordinate = placemark.location!.coordinate
                point.title = "Sample Location";
                point.subtitle = "Sample Subtitle";
                
                print("point: \(point)")
                
                
                let pointLocation = CLLocation(latitude: (placemark.location?.coordinate.latitude)!, longitude: (placemark.location?.coordinate.longitude)!)
                //self.centerMapOnLocation(pointLocation)
                
                self.mapView.centerCoordinate = point.coordinate
                
                
                self.mapView.addAnnotation(point)
                
                
            }
            
            
        }
    }
    
}

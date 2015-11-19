//
//  MapDealerViewController.swift
//  DDay
//
//  Created by Mayes, Arthur E. on 11/10/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//
//  https://www.appsfoundation.com/post/map-kit-ios-9-custom-pins-transit-mode-3d-flyover-mode
//  http://nshipster.com/ios9/

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
        //self.mapView.showsCompass = true
        //self.mapView.showsTraffic = true
        //self.mapView.showsScale = true
        self.mapView.showsUserLocation = true  // we will also use mapview delegate to do a 3d flyby into user
        //self.mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        
        
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
        //self.flyByToLocation(userLocation.location!)
    }
    func mapViewDidStopLocatingUser(mapView: MKMapView) {
        self.flyByToLocation(mapView.userLocation.location!)
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
        // http://stackoverflow.com/questions/5025339/how-to-make-mapview-zoom-to-5-mile-radius-of-current-location
        
        let searchRegion = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location!.coordinate  , milesToMeters(5.0), milesToMeters(5.0))
        //let searchRegion = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.location!.coordinate  , 5.0/69.0, 5.0/69.0)
        
        //mapView.setRegion(searchRegion, animated: true)
        
        localSearchRequest.region = searchRegion
        
        
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (searchResponse, error) -> Void in
            // make sure placeArray is more than 0
            guard let placeArray = searchResponse?.mapItems where searchResponse?.mapItems.count > 0 else {
                return
            }
            
            self.mapView.setRegion(searchRegion, animated: true)
            
            
            for place:MKMapItem in placeArray {
                print("place:\(place)")
                let point = MKPointAnnotation()
                if let placeCoordinate = place.placemark.location?.coordinate {
                    point.coordinate = placeCoordinate
                }
                point.title = place.name
                point.subtitle = place.phoneNumber
                self.mapView.addAnnotation(point)
                
                
                
            }
            
            
            
            
            
            
            
        } // end local search completion block
        
        
        /*
        
        self.geoCoder.geocodeAddressString(self.searchBar.text!) { (placemarks, error) -> Void in
        
        if error != nil {
        print("Geocode failed with error: \(error!.localizedDescription)")
        } else if placemarks?.count > 0 {
        
        //print(placemarks![0])
        //print ("location.count:\(placemarks!.count)")
        
        let placemark = placemarks!.first as! CLPlacemark!
        let point = MKPointAnnotation()
        point.coordinate = placemark.location!.coordinate
        point.title = "Sample Location";
        point.subtitle = "Sample Subtitle";
        
        //print("point: \(point)")
        
        
        let pointLocation = CLLocation(latitude: (placemark.location?.coordinate.latitude)!, longitude: (placemark.location?.coordinate.longitude)!)
        //self.centerMapOnLocation(pointLocation)
        
        self.mapView.centerCoordinate = point.coordinate
        
        
        self.mapView.addAnnotation(point)
        
        
        }
        
        
        } */
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: "calloutTaped:")
        view.addGestureRecognizer(tapGuesture)
        
        let coordinate = view.annotation?.coordinate
        let pinLocation = CLLocation(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!)
        self.flyByToLocation(pinLocation)
        
        
    }
    
    
    func calloutTaped(sender:AnyObject) {
        
    }
    
    
    func milesToMeters(miles: Double) -> Double {
        // 1 mile is 1609.344 meters
        // source: http://www.google.com/search?q=1+mile+in+meters
        return 1609.344 * miles;
    }
    
}

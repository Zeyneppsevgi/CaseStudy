//
//  ApiKeyViewController.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 26.07.2023.
//

import UIKit
import CoreLocation
import MapKit


protocol ApiKeyViewControllerDelegate: AnyObject {
    func didLatWithLon(_ lat: Double, lon: Double, apiKey: String)
}

class ApiKeyViewController: UIViewController{
    
    var lat : Double = 0.0
    var lon : Double = 0.0
    let apiKey = "5a8907ac912c11c65ef98997c5f71c97"
    var currentPinAnnotation: MKPointAnnotation?
    
    @IBOutlet weak var mapView: MKMapView!
    
    weak var delegate: ApiKeyViewControllerDelegate?
    let locaitonManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locaitonManager.delegate = self
        locaitonManager.requestWhenInUseAuthorization()
        locaitonManager.desiredAccuracy = kCLLocationAccuracyBest
        locaitonManager.startUpdatingLocation()
        locaitonManager.requestLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(getLongPress(gestureRecognizer: )))
        gestureRecognizer.minimumPressDuration = 1
        mapView.addGestureRecognizer(gestureRecognizer)
        
       
            }
  
    @objc func getLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchedPoint = gestureRecognizer.location(in: mapView)
            let convertTouchedPoint = mapView.convert(touchedPoint, toCoordinateFrom: mapView)
            
            if let existingPin = currentPinAnnotation {
                        mapView.removeAnnotation(existingPin)
                    }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = convertTouchedPoint
            mapView.addAnnotation(annotation)
            
            annotation.title = "The place you choose"
            annotation.subtitle = "Go to this location"
            
            lat = annotation.coordinate.latitude
            lon = annotation.coordinate.longitude
            currentPinAnnotation = annotation
            delegate?.didLatWithLon(lat, lon: lon, apiKey: apiKey)
        }
             
    }
   
    
    @IBAction func enterPressed(_ sender: Any) {
        if let location = locaitonManager.location {
//               let lat = location.coordinate.latitude
//               let lon = location.coordinate.longitude

                // Delegate aracılığıyla konum verilerini diğer sayfaya iletiyoruz
                delegate?.didLatWithLon(lat, lon: lon, apiKey: apiKey)
                performRegistration(lat: lat, lon: lon)
           } else {
               print("Konum bilgisi bulunamadı.")
           }
       
    }
    func performRegistration(lat: Double, lon: Double) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let apiVC = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        apiVC.latitude = lat
        apiVC.longitude = lon
        
        navigationController?.pushViewController(apiVC, animated: true)
    }

}
extension ApiKeyViewController: CLLocationManagerDelegate ,MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D.init(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
  
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
  
}

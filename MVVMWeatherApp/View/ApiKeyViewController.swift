//
//  ApiKeyViewController.swift
//  MVVMWeatherApp
//
//  Created by Zeynep Sevgi on 26.07.2023.
//

import UIKit
import CoreLocation


protocol ApiKeyViewControllerDelegate: AnyObject {
    func didLatWithLon(_ lat: Double, lon: Double, apiKey: String)
}

class ApiKeyViewController: UIViewController{
   
    

    weak var delegate: ApiKeyViewControllerDelegate?
    let locaitonManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locaitonManager.delegate = self
        locaitonManager.requestWhenInUseAuthorization()
        locaitonManager.requestLocation()
        
    }
    
    @IBAction func enterPressed(_ sender: Any) {
        if let location = locaitonManager.location {
               let lat = location.coordinate.latitude
               let lon = location.coordinate.longitude
               let apiKey = "5a8907ac912c11c65ef98997c5f71c97"

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
extension ApiKeyViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
  
}

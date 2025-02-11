//
//  LocationDataManager.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 06/06/24.
//

import Foundation
import CoreLocation

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
   @Published var authorizationStatus: CLAuthorizationStatus?
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       switch status {
       case .authorizedWhenInUse:  // Location services are available.
           // Insert code here of what should happen when Location services are authorized
           authorizationStatus = .authorizedWhenInUse
           locationManager.requestLocation()
           
       case .restricted:  // Location services currently unavailable.
           // Insert code here of what should happen when Location services are NOT authorized
           authorizationStatus = .restricted
           
       case .denied:  // Location services currently unavailable.
           // Insert code here of what should happen when Location services are NOT authorized
           authorizationStatus = .denied
           
       case .notDetermined:  // Authorization not determined yet.
           authorizationStatus = .notDetermined
           manager.requestWhenInUseAuthorization()
           
       default:
           break
       }
   }


    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
                    // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
           
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
           
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
           
        default:
           print("haha")
            break
        }
    }
   
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   // Insert code to handle location updates
   }
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
   print("Funny error: \(error.localizedDescription)")
   }
    
    
}

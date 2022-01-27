//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Aiden Choi on 2022/01/27.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    func requestLocation() {
        self.isLoading = true
        self.manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.location = locations.first?.coordinate
        self.isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.isLoading = false
        print("Error getting location: ", error)
    }
}

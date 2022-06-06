//
//  MapManage.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 03/06/22.
//
// Credit: https://stackoverflow.com/questions/62995318/trying-to-get-user-location-using-swiftui-in-the-content-view-but-showing-nil

import Foundation
import CoreLocation

class MapManage: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?
    
    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
        
    }
    
}

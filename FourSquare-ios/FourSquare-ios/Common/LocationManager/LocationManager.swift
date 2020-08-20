//
//  LocationManager.swift
//  FourSquare-ios
//
//  Created by mohammadSaadat on 5/30/1399 AP.
//  Copyright © 1399 mohammad. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func updateLocationManager(latitude: String, longitude: String)
    func showPermisionLocationAlert()
}

class LocationManager: NSObject {
    
    // MARK: - Object lifecycle
    override init() {
        super.init()
        debugPrint("LifeCycle ->" + String(describing: LocationManager.self) + "init")
        locationManager.delegate = self
    }
    
    // MARK: - Deinit
    deinit {
        debugPrint("LifeCycle ->" + String(describing: LocationManager.self) + "deinit")
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private weak var delegate: LocationManagerDelegate?
    private let locationDistance: Double = 0.5
    private let locationManager = CLLocationManager()
}

private extension LocationManager {
    func setUpLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            self.locationManager.distanceFilter = locationDistance
            self.locationManager.allowsBackgroundLocationUpdates = false
        }
    }
}

extension LocationManager {
    func startHandleLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            self.setUpLocation()
        case .restricted, .denied:
            self.delegate?.showPermisionLocationAlert()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func handleLocationManagerState() {
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied:
            self.delegate?.showPermisionLocationAlert()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func getCurrentLocation() -> (lat: String?, lng: String?) {
        let cordinateSystem = self.locationManager.location?.coordinate
        return (cordinateSystem?.latitude.description, cordinateSystem?.longitude.description)
    }
    
    func setDelegate(with delegate: LocationManagerDelegate) {
        self.delegate = delegate
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude.description
        let longitude = location.coordinate.longitude.description
        self.delegate?.updateLocationManager(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            self.setUpLocation()
        case .restricted, .denied:
            self.delegate?.showPermisionLocationAlert()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
}

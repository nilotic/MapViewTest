//
//  LocationManager.swift
//  dailyhotel
//
//  Created by Wayne Kim on 2017. 8. 3..
//  Copyright © 2017년 Daily Co., Ltd. All rights reserved.
//

import MapKit
import CoreLocation

// MARK: - Define
struct LocationNotificationName {
    static let update                  = Notification.Name("DHLocationManagerDidUpdateLocation")
    static let updateFailure           = Notification.Name("DHLocationManagerDidUpdateLocationFail")
    static let updatedAuthorizedStatus = Notification.Name("DHLocationManagerDidUpdateLocationAuthorizedAlwaysNotification")
    static let serviceDisabled         = Notification.Name("LocationManagerSeviceDisabled")
}


@objc final class LocationManager: NSObject {
    
    // MARK: - Value
    // MARK: Public
    @objc static let shared = LocationManager()
    
    @objc private(set) var currentLocation: CLLocation? = nil
    
    var isLocationAuthorized: Bool {
        return (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) && CLLocationManager.locationServicesEnabled()
    }
    
    
    
    // MARK: Private
    private let locationManager = CLLocationManager()
    private var expireTimer: Timer? = nil
    
    
    // MARK: - Public
    // MARK: Public
    @objc @discardableResult
    func requestLocation() -> Bool {
        guard CLLocationManager.locationServicesEnabled() == true else {
            // 시스템의 위치 정보 서비스가 꺼져있을 경우.
            showLocationServiceOffAlert()
            NotificationCenter.default.post(name: LocationNotificationName.serviceDisabled, object: nil)
            log(.error, "System location service disabled.")
            return false
        }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: // 유저가 위치 서비스 사용 여부를 아직 결정하지 않은 상태.
            locationManager.requestWhenInUseAuthorization()
            log(.info, "Application location service not determined. Attempt to authorization.")
            return false
            
        case .denied: // 유저가 위치 서비스 사용을 거부했거나, 사용이 불가능할 때.
            showLocationPermissionAlert()
            NotificationCenter.default.post(name: LocationNotificationName.serviceDisabled, object: nil)
            log(.error, "Location service denied by user.")
            return false
            
        case .restricted: // 앱이 위치 서비스를 사용할 수 없을 때.
            NotificationCenter.default.post(name: LocationNotificationName.updateFailure, object: nil)
            log(.error, "Application not authorized using location service.")
            return false
            
        case .authorizedAlways, .authorizedWhenInUse: // 위치 서비스 사용이 가능할 때.
            currentLocation = nil
            locationManager.requestLocation()
            
            // 타이머 설정.
            expireTimer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(locationUpdatingExpired(_:)), userInfo: nil, repeats: false)
        }
        
        return true
    }
    
    // MARK: Private
    private override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter  = kCLDistanceFilterNone
        locationManager.delegate        = self
    }
    
    @objc func locationUpdatingExpired(_ timer: Timer?) {
        finishUpdateLocation(location: nil)
    }
    
    private func finishUpdateLocation(location: CLLocation?) {
        if let timer = expireTimer, timer.isValid == true {
            timer.invalidate()
        }
        
        // If current location is already set, just return.
        guard currentLocation == nil else { return }
        currentLocation = location

        if currentLocation == nil {
            log(.error, NSLocalizedString("Location Update Error", comment: ""))
        }
        
        // We only have to handle the notification once.
        NotificationCenter.default.post(name: currentLocation != nil ? LocationNotificationName.update : LocationNotificationName.updateFailure, object: nil)
    }

    private func showLocationServiceOffAlert() {
    }
    
    private func showLocationPermissionAlert() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            log(.error, "Failed to set open settings URL.")
            return
        }
        
        UIApplication.shared.openURL(settingsURL)
    }
}

// MARK: - CLLocationManager Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            NotificationCenter.default.post(name: LocationNotificationName.updatedAuthorizedStatus, object: nil)
            requestLocation()
            
        case .denied:       log(.info, "Using location service denied by user.")
        default:            log(.info, "Location service unavailable.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        finishUpdateLocation(location: locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finishUpdateLocation(location: nil)
    }
}














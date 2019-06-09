//
//  ViewController.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/27.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet
    weak var mapView: MKMapView!
    
    private var viewModel: MainViewModel!
    
    private var locationUsedToLocateAirports: CLLocation?
    private var latestUserLocation: CLLocation?
    
    private let regionInMeters: Double = 20000 // 20km
    private let distanceBetweenLocatingAirportsInMeters: Double = 50000 // 50km
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(view: self)
        
        checkLocationServices()
    }
    
}

// MARK: - MainView

extension MainViewController: MainView {
    
    func locatedAirport(_ airport: NearbyAirport) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // TODO: Display found airport on map; on tap should nav to second screen
    }
    
    func failedToLocateNearbyAirports() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // TODO: Prompt user to retry
    }
    
}

// MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            return
        }
        
        latestUserLocation = userLocation
        centerViewOnUserLocation(userLocation.coordinate)
        
        if let lastFoundAirportsAt = locationUsedToLocateAirports {
            if (userLocation.distance(from: lastFoundAirportsAt) < distanceBetweenLocatingAirportsInMeters) {
                return
            }
        }
        
        locateAirports(userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
}

// MARK: - Private

extension MainViewController {
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            promptUserToEnableLocationServices()
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied, .restricted:
            fallthrough
        default:
            promptUserToEnableLocationServices()
            break
        }
    }
    
    private func centerViewOnUserLocation(_ location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    private func promptUserToEnableLocationServices() {
        // TODO: Prompt user that location services are required
    }
    
    private func locateAirports(_ location: CLLocation) {
        locationUsedToLocateAirports = location
        viewModel.locateAirportsTapped(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
    }
}

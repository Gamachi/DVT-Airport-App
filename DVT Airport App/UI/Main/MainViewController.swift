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
    
    private let regionInMeters: Double = 20000
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(view: self)
        
        checkLocationServices()
    }

    @IBAction
    func locateAirportsTapped(_ sender: Any) {
        viewModel.locateAirportsTapped()
    }
    
}

// MARK: - MainView

extension MainViewController: MainView {
    
    
    
}

// MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let userLocation = location.coordinate
        let region = MKCoordinateRegion.init(center: userLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
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
            centerViewOnUserLocation()
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
    
    private func centerViewOnUserLocation() {
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: userLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func promptUserToEnableLocationServices() {
        // Show alert to notify user that location services are required
    }
}

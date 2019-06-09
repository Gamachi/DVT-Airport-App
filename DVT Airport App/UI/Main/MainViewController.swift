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
    private var selectedAirport: NearbyAirport?
    
    private let regionInMeters: Double = 25000 // 25km
    private let distanceBetweenLocatingAirportsInMeters: Double = 50000 // 50km
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(view: self)
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationServices()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? FlightScheduleViewController {
            viewController.airport = selectedAirport
        }
    }
    
    @IBAction
    func unwindToMain(_ segue: UIStoryboardSegue) {
        print("Returning to main screen")
    }
    
}

// MARK: - MainView

extension MainViewController: MainView {
    
    func locatedAirport(_ airport: NearbyAirport) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        guard let lat = Double(airport.latitudeAirport!), let lng = Double(airport.longitudeAirport!) else {
            return
        }
        
        let airportAnnotation = MKPointAnnotation()
        airportAnnotation.title = airport.nameAirport
        airportAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        mapView.addAnnotation(airportAnnotation)
    }
    
    func failedToLocateNearbyAirports() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        let notice = UIAlertController(title: "Whoops!", message: "Retrying to locate airports near you", preferredStyle: .alert)
        notice.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(notice, animated: true, completion: nil)
    }
    
    func navigateToAirportSchedule(_ airport: NearbyAirport) {
        selectedAirport = airport
        performSegue(withIdentifier: "ShowFlightSchedule", sender: nil)
    }
    
}

// MARK: - MKMapViewDelegate

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "MapAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let airportTitle = view.annotation?.title as? String
        guard let tappedAirportTitle = airportTitle else {
            return
        }
        
        viewModel.airportTapped(tappedAirportTitle)
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
        let notice = UIAlertController (title: "We require access to your location", message: "We use your location to locate airports near you", preferredStyle: .alert)
        notice.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        notice.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            UIApplication.shared.open(settingsUrl, completionHandler:nil)
        })
        present(notice, animated: true, completion: nil)
    }
    
    private func locateAirports(_ location: CLLocation) {
        locationUsedToLocateAirports = location
        viewModel.locateAirportsTapped(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
    }
}

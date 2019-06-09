//
//  MainViewModel.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/30.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    
    private let airportRepo: AirportRepository = AirportRepositoryImplementation.shared
    private let disposables = DisposeBag()
    
    private let view: MainView!
    
    private var nearbyAirports: [NearbyAirport]?
    
    init(view: MainView) {
        self.view = view
    }
    
    func locateAirportsTapped(lat: Double, lng: Double) {
        print("Attempting to locate airports near {lat: \(lat) ; lng: \(lng)}")
        
        airportRepo.getAirports(nearbyLat: lat, long: lng)
            .subscribeOn(RxSchedulers.rxBackground)
            .observeOn(RxSchedulers.rxMain)
            .subscribe(onNext: { nearbyAirports in
                self.nearbyAirportsRetrieved(nearbyAirports)
            }, onError: { error in
                self.errorOccurred(error)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposables)
    }
    
}

// MARK: - Private

extension MainViewModel {
    
    private func nearbyAirportsRetrieved(_ airports: [NearbyAirport]) {
        print("Located nearby airports")
        nearbyAirports = airports
        for airport in airports {
            print("Found airport at {lat: \(airport.latitudeAirport ?? "") ; lng: \(airport.longitudeAirport ?? "")})")
            view.locatedAirport(airport)
        }
    }
    
    private func errorOccurred(_ error: Error) {
        let errorInformation = error as? ErrorInformation
        print("Failed to locate nearby airports:\n\(errorInformation?.errorDetail ?? "")")
        view.failedToLocateNearbyAirports()
    }
    
}

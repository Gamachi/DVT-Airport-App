//
//  FlightScheduleViewModel.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/10.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift

class FlightScheduleViewModel {
    
    private let airportRepo: AirportRepository = AirportRepositoryImplementation.shared
    private let disposables = DisposeBag()
    
    private let view: FlightScheduleView!
    
    init(view: FlightScheduleView) {
        self.view = view
    }
    
    func getAirportSchedule(_ airportIataCode: String) {
        print("Attempting to retrieve schedule for airport with IATA Code: \(airportIataCode)")
        
        airportRepo.getDepartureSchedule(forAirportWithIATACode: airportIataCode)
            .subscribeOn(RxSchedulers.rxBackground)
            .observeOn(RxSchedulers.rxMain)
            .subscribe(onNext: { flights in
                self.flightsRetrieved(flights)
            }, onError: { error in
                self.errorOccurred(error)
                self.getAirportSchedule(airportIataCode)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposables)
    }
    
}

// MARK: - Private

extension FlightScheduleViewModel {
    
    private func flightsRetrieved(_ flights: [FlightSchedule]) {
        print("Retrieved schedules for \(flights.count) flights")
        view.presentFlights(flights)
    }
    
    private func errorOccurred(_ error: Error) {
        let errorInformation = error as? ErrorInformation
        print("Failed to retrieve flight schedules:\n\(errorInformation?.errorDetail ?? "")")
        view.failedToRetrieveFlights()
    }
    
}

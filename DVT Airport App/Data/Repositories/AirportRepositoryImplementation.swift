//
//  AirportRepositoryImplementation.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/05.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift
import RxRetroSwift

class AirportRepositoryImplementation {
    
    private let coordinateFormat = "%.7"
    private let airportService: AirportService = AirportServiceImplementation.shared
    
    private init() {
        /* No - Op */
    }
    
}

// MARK: - AirportRepository

extension AirportRepositoryImplementation : AirportRepository {
    
    static var shared: AirportRepository = AirportRepositoryImplementation()
    
    func getAirports(nearbyLat: Double, long: Double) -> Observable<[NearbyAirport]> {
        let latitude = String(format: coordinateFormat, nearbyLat)
        let longitude = String(format: coordinateFormat, long)
        
        return airportService.getAirports(nearbyLat: latitude, long: longitude)
            .subscribeOn(RxSchedulers.rxBackground)
            .flatMap { result -> Observable<[NearbyAirport]> in
                if let error = result.error {
                    return .error(error)
                }
                
                return .just(result.value ?? [])
            }
    }
    
    func getDepartureSchedule(forAirportWithIATACode: String) -> Observable<[FlightSchedule]> {
        return airportService.getDepartureSchedule(forAirportWithIATACode: forAirportWithIATACode)
            .subscribeOn(RxSchedulers.rxBackground)
            .flatMap { result -> Observable<[FlightSchedule]> in
                if let error = result.error {
                    return .error(error)
                }
                
                return .just(result.value ?? [])
            }
    }
    
}

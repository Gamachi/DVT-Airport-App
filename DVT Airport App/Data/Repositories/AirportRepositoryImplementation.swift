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
    
    func getAirports(nearbyLat: Double, long: Double, distance: Int) -> Observable<[NearbyAirport]> {
        let latitude = String(format: coordinateFormat, nearbyLat)
        let longitude = String(format: coordinateFormat, long)
        
        return airportService.getAirports(nearbyLat: latitude, long: longitude, distance: distance.description)
            .subscribeOn(RxSchedulers.rxBackground)
            .flatMap { result -> Observable<[NearbyAirport]> in
                guard result.error == nil && result.value != nil else {
                    return .just([])
                }
                
                return .just(result.value!)
            }
    }
    
    func getDepartureSchedule(forAirportWithIATACode: String) -> Observable<[AirportSchedule]> {
        return airportService.getDepartureSchedule(forAirportWithIATACode: forAirportWithIATACode)
            .subscribeOn(RxSchedulers.rxBackground)
            .flatMap { result -> Observable<[AirportSchedule]> in
                guard result.error == nil && result.value != nil else {
                    return .just([])
                }
                
                return .just(result.value!)
            }
    }
    
}

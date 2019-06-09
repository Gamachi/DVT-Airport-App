//
//  AirportService.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/05.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift
import RxRetroSwift

protocol AirportService {
    
    static var shared: AirportService { get }
    
    func getAirports(nearbyLat: String, long: String) -> Observable<Result<[NearbyAirport], ErrorInformation>>
    
    func getAirports(nearbyLat: String, long: String, distance: String) -> Observable<Result<[NearbyAirport], ErrorInformation>>
    
    func getDepartureSchedule(forAirportWithIATACode: String) -> Observable<Result<[AirportSchedule], ErrorInformation>>
    
}

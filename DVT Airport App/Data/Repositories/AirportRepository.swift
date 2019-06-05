//
//  AirportRepository.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/05.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift

protocol AirportRepository {
    
    static var shared: AirportRepository { get }
    
    func getAirports(nearbyLat: Double, long: Double, distance: Int) -> Observable<[NearbyAirport]>
    
    func getDepartureSchedule(forAirportWithIATACode: String) -> Observable<[AirportSchedule]>
    
}
//
//  AirportScheduleResponse.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct AirportSchedule : Codable {
    // Type of entry (arrival / departure)
    var type: String
    // Status of flight (landed, scheduled, cancelled, active, incident, diverted, redirected, unknown)
    var status: String
    // Information about departure
    var departure: DepartureInformation
    // Information about arrival
    var arrival: ArrivalInformation
    // Information about airline
    var airline: AirlineInformation
    // Information about flight
    var flight: FlightInformation
}

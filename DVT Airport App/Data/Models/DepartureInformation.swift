//
//  DepartureInformation.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct DepartureInformation : Codable {
    // IATA code of departure Airport
    var iataCode: String?
    // ICAO code of departure Airport
    var icaoCode: String?
    // Terminal of departure Airport
    var terminal: String?
    // Gate of departure Airport
    var gate: String?
    // Scheduled time of departure
    var scheduledTime: String?
    // Estimated time of departure
    var estimatedTime: String?
    // Actual time of departure
    var actualTime: String?
    // Estimated time departure on runway
    var estimatedRunway: String?
    // Actual time departure on runway
    var actualRunway: String?
}

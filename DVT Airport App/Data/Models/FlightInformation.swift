//
//  FlightInformation.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct FlightInformation : Codable {
    // Number of flight
    var number: String?
    // IATA prefix with Flight number
    var iataNumber: String?
    // ICAO prefix with Flight number
    var icaoNumber: String?
}

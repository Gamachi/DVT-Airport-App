//
//  AirlineInformation.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct AirlineInformation : Codable {
    // Name of Airline
    var name: String
    // IATA Code of Airline
    var iataCode: String
    // ICAO Code of Airline
    var icaoCode: String
}

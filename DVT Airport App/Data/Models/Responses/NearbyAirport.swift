//
//  NearbyAirportResponse.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct NearbyAirport : Codable {
    // IATA code of Airport
    var code: String
    // ICAO code of Airport
    var icao: String
    // Name of Airport
    var name: String
    // IATA code of City
    var cityCode: String
    // Name of City
    var cityName: String
    // 2 Digit ISO code of Country
    var countryCode: String
    // Name of Country of Airport
    var countryName: String
    // Latitude coordinates of Airport
    var lat: Double
    // Longitude coordinates of Airport
    var lng: Double
    // Timezone name
    var timezone: String
    // Type of autocomplete
    var type: String
    // Flag indicating whether this is a railroad station
    var isRailroad: Int
    // Flag indicating whether this is a bus station
    var isBusStation: Int
    // Distance from location
    var distance: Int
}

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
    var codeIataAirport: String?
    // ICAO code of Airport
    var codeIcaoAirport: String?
    // Name of Airport
    var nameAirport: String?
    // Phone number
    var phone: String?
    // GMT timezone
    var GMT: String?
    // Name translations
    var nameTranslations: String?
    // IATA code of City
    var codeIataCity: String?
    // 2 Digit ISO code of Country
    var codeIso2Country: String?
    // Name of Country of Airport
    var nameCountry: String?
    // Latitude coordinates of Airport
    var latitudeAirport: String?
    // Longitude coordinates of Airport
    var longitudeAirport: String?
    // Timezone name
    var timezone: String?
    // Distance from location
    var distance: String?
}

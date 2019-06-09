//
//  ArrivalInformation.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/31.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct ArrivalInformation : Codable {
    // IATA code of arrival Airport
    var iataCode: String?
    // ICAO code of arrival Airport
    var icaoCode: String?
    // Number of baggage
    var baggage: String?
    // Scheduled time of arrival
    var scheduledTime: String?
    // Estimated time of arrival
    var estimatedTime: String?
    // Actual time of arrival
    var actualTime: String?
}

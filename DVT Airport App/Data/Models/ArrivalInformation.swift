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
    var iataCode: String
    // ICAO code of arrival Airport
    var icaoCode: String
    // Terminal of arrival Airport
    var terminal: String
    // Gate of arrival Airport
    var gate: String
    // Delay of Flight in minutes
    var delay: String
    // Scheduled time of arrival
    var scheduledTime: String
    // Estimated time of arrival
    var estimatedTime: String
    // Actual time of arrival
    var actualTime: String
    // Estimated time arrival on runway
    var estimatedRunway: String
    // Actual time arrival on runway
    var actualRunway: String
}

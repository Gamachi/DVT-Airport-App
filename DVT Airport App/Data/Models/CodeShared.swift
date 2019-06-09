//
//  CodeShared.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/07.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

struct CodeShared : Codable {
    // Information about airline
    var airline: AirlineInformation?
    // Information about flight
    var flight: FlightInformation?
}

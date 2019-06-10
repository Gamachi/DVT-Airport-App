//
//  FlightScheduleView.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/10.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

protocol FlightScheduleView {
    
    func presentFlights(_ flights: [FlightSchedule])
    
    func failedToRetrieveFlights()
    
}

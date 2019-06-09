//
//  MainView.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/30.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

protocol MainView {
    
    func locatedAirport(_ airport: NearbyAirport)
    
    func failedToLocateNearbyAirports()
    
}

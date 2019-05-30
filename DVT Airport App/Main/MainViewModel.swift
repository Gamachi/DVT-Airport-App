//
//  MainViewModel.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/05/30.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation

class MainViewModel {
    
    private let view: MainView!
    
    init(view: MainView) {
        self.view = view
    }
    
    func locateAirportsTapped() {
        print("locateAirportsTapped")
    }
}

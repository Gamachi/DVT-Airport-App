//
//  RxSchedulers.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/05.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxSwift

struct RxSchedulers {
    
    static let rxMain = MainScheduler.instance
    static let rxBackground = ConcurrentDispatchQueueScheduler(qos: .background)
    
    
    private init() {
        /* No - Op */
    }
    
}

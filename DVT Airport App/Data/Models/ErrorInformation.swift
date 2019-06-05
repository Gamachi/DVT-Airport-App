//
//  ErrorInformation.swift
//  DVT Airport App
//
//  Created by Altus Boneschans on 2019/06/04.
//  Copyright © 2019 Altus Boneschans. All rights reserved.
//

import Foundation
import RxRetroSwift

struct ErrorInformation : DecodableError {
    var errorCode: Int?
    var errorDetail: String?
}

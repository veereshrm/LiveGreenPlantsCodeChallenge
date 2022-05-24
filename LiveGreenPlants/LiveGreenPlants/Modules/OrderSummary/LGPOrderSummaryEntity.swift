//
//  LGPOrderSummaryEntity.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation

struct LGPOrderSummmary : Codable{
    var selectedProducts : [LGPProduct]?
    var totalAmmount : Int = 0
    var address : String = ""
}

struct LGPOrderElements{
    var item : Any?
    var type : LGPOrderElementType
}

enum LGPOrderElementType {
    case product
    case totalAmount
    case address
}

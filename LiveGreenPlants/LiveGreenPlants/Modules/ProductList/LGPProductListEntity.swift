//
//  LGPProductListEntity.swift
//  LiveGreenPlants
//
//  Created by Veeresh on 22/05/22.
//

import Foundation

struct LGPProduct: Codable {
    var id: Int
    var title: String
    var price, stock: Int
    var description: String
    var currency: LGPCurrency
    var image: String
    var storeID : String
    var rating: LGPRating
    var quantity : Int? = 0

    enum CodingKeys: String, CodingKey {
        case id, title, price, stock
        case description
        case currency, image, storeID, rating
    }
}

enum LGPCurrency: String, Codable {
    case inr = "INR"
    case usd = "USD"
}
enum LGPSectionType: String, Codable {
    case inr = "INR"
    case usd = "USD"
}


struct LGPRating: Codable {
    var rate: Double
    var count: Int
}

struct LGPStore: Codable {
    var storeID: String
    var country: String
    var currency: String
    var email: String
    var logo: String
    var name: String
    var time: String
    var url: String
    var phone: String
    
}

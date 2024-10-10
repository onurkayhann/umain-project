//
//  Restaurant.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-09.
//

import Foundation

struct Restaurant: Identifiable, Codable {
    var id: String
    var name: String
    var rating: Double
    var deliveryTimeMinutes: Int
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case deliveryTimeMinutes = "delivery_time_minutes"
        case imageUrl = "image_url"
    }
}

struct RestaurantResponse: Codable {
    var restaurants: [Restaurant]
}

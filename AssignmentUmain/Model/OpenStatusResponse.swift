//
//  OpenStatus.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-10.
//

import Foundation

struct OpenStatusResponse: Codable {
    var isCurrentlyOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case isCurrentlyOpen = "is_currently_open"
    }
}

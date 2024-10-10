//
//  Filter.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-10.
//

import Foundation

struct Filter: Codable {
    var id: String
    var name: String
}

struct FilterResponse: Codable {
    var filters: [Filter]
}

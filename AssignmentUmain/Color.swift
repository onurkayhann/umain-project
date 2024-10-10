//
//  Color.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-10.
//

import SwiftUI

extension Color {
    static let darkText = Color(hex: "#1F2B2E")
    static let lightText = Color(hex: "#FFFFFF")
    static let subTitle = Color(hex: "#999999")
    static let background = Color(hex: "#F8F8F8")
    static let selected = Color(hex: "#E2A364")
    static let positive = Color(hex: "#2ECC71")
    static let negative = Color(hex: "#C0392B")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000ff) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

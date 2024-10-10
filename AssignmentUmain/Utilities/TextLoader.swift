//
//  TextLoader.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-10.
//

import SwiftUI

struct TextLoader: View {
    var filterId: String
    @ObservedObject var restaurantViewModel: RestaurantViewModel
    @State private var filterName: String = "Loading..."
    
    var body: some View {
        Text(filterName)
            .onAppear {
                restaurantViewModel.fetchFilterName(by: filterId) { name in
                    self.filterName = name
                }
            }
            .font(.subheadline)
            .foregroundColor(.subTitle)
            .fontWeight(.bold)
    }
}

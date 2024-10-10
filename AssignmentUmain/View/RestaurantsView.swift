//
//  RestaurantsView.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-09.
//

import SwiftUI

struct RestaurantsView: View {
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @State private var showTopRatedOnly = false
    
    
    
    var body: some View {
        

        
        NavigationView {
            List(restaurantViewModel.restaurants) { restaurant in
                
                NavigationLink(
                    destination: RestaurantDetailView(
                        restaurant: restaurant,
                        restaurantViewModel: restaurantViewModel
                    )
                ) {
                    
                    
                    VStack {
                        
                        AsyncImage(url: URL(string: restaurant.imageUrl)) { image in
                            image
                                .resizable()
                                .frame(width: 343, height: 140)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 343, height: 150)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(restaurant.name)
                                    .font(.title3)
                                    .foregroundColor(.darkText)
                                Spacer()
                                HStack(spacing: 1) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 11))
                                        .foregroundStyle(.yellow)
                                    Text("\(restaurant.rating, specifier: "%.1f")")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.darkText)
                                }
                            }
                            
                            let filterNames = restaurant.filterIds.map { filterId -> String in
                                var filterName = "Loading..."
                                restaurantViewModel.fetchFilterName(by: filterId) { name in
                                    filterName = name
                                }
                                return filterName
                            }
                            
                            
                            if !filterNames.isEmpty {
                                Text(filterNames.joined(separator: " • "))
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.subTitle)
                            }
                            
                            
                            HStack(spacing: 2) {
                                Image(systemName: "clock")
                                    .font(.system(size: 11))
                                    .foregroundColor(.negative)
                                
                                Text("\(restaurant.deliveryTimeMinutes) min")
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundColor(.darkText)
                            }
                            
                        }
                        .padding(.bottom, 5)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                    .background(.background)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .frame(width: 343, height: 180)
                    .padding(.vertical, 20)
                    
                }
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color.clear)
                
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .onAppear {
                restaurantViewModel.fetchRestaurants()
            }
        }
    }
}


#Preview {
    RestaurantsView()
}

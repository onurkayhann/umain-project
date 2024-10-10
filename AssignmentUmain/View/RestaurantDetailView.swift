//
//  RestaurantView.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-10.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    @State private var isOpen: Bool? = nil
    @StateObject var restaurantViewModel: RestaurantViewModel
    
    var body: some View {
        VStack { // Remove spacing between image and content
            // Restaurant Image
            AsyncImage(url: URL(string: restaurant.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text(restaurant.name)
                    .font(.title)
                    .foregroundColor(.darkText)

                let filterNames = restaurant.filterIds.compactMap { filterId in
                                   var filterName = "Loading..."
                                   restaurantViewModel.fetchFilterName(by: filterId) { name in
                                       filterName = name
                                   }
                                   return filterName
                               }
                               
                               if !filterNames.isEmpty {
                                   Text(filterNames.joined(separator: " • "))
                                       .fontWeight(.regular)
                                       .foregroundColor(.gray)
                                       .font(.system(size: 14))
                               }


                if let isOpen = isOpen {
                    Text(isOpen ? "Open" : "Closed")
                        .font(.title3)
                        .foregroundColor(isOpen ? .positive : .negative)
                } else {
                    Text("Loading...")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .frame(width: 343, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .offset(y: -40)

            Spacer()
        }
        .onAppear {
            fetchOpenStatus()
        }
    }
    
    func fetchOpenStatus() {
        let openUrl = "https://food-delivery.umain.io/api/v1/open/\(restaurant.id)"
        guard let url = URL(string: openUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(OpenStatusResponse.self, from: data)
                    DispatchQueue.main.async {
                        isOpen = decodedResponse.isCurrentlyOpen
                    }
                } catch {
                    print("Error decoding open status: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

#Preview {
    let mockRestaurant = Restaurant(
        id: "7450001",
        name: "Wayne's Burgers",
        rating: 4.6,
        deliveryTimeMinutes: 15,
        imageUrl: "https://food-delivery.umain.io/images/restaurant/burgers.png",
        filterIds: ["5c64dea3-a4ac-4151-a2e3-42e7919a925d"]
    )
    
    let mockViewModel = RestaurantViewModel() // Your view model
    
    return RestaurantDetailView(restaurant: mockRestaurant, restaurantViewModel: mockViewModel)
}

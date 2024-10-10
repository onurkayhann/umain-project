//
//  RestaurantViewModel.swift
//  AssignmentUmain
//
//  Created by Onur Kayhan on 2024-10-09.
//

import SwiftUI

class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var filters: [String: String] = [:]
    
    private let apiUrl = "https://food-delivery.umain.io/api/v1/restaurants"
    private let filterUrl = "https://food-delivery.umain.io/api/v1/filter/"
    
    
    
    func fetchRestaurants() {
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.restaurants = decodedResponse.restaurants
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchFilterName(by id: String, completion: @escaping (String) -> Void) {
            // If the filter is already cached, return it immediately
            if let cachedFilter = filters[id] {
                completion(cachedFilter)
                return
            }

            // Otherwise, fetch the filter from the API
            guard let url = URL(string: filterUrl + id) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    print("Error fetching filter: \(error?.localizedDescription ?? "Unknown error")")
                    completion("Unknown") // Return "Unknown" if there's an issue
                    return
                }
                
                do {
                    let decodedFilter = try JSONDecoder().decode(Filter.self, from: data)
                    DispatchQueue.main.async {
                        // Cache the filter name and return it
                        self.filters[id] = decodedFilter.name
                        completion(decodedFilter.name)
                    }
                } catch {
                    print("Error decoding filter: \(error.localizedDescription)")
                    completion("Unknown")
                }
            }.resume()
        }
    
    func geFilterName(by id: String) -> String {
        return filters[id] ?? "Unknown"
    }
}



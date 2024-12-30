//
//  HomeViewModel.swift
//  nlw
//
//  Created by Niceplanet T.I on 23/12/24.
//

import Foundation
import CoreLocation

class HomeViewModel {
    private let baseURL = "http://127.0.0.1:3333"
    var userLatitude = -23.5611872
    var userLongitude = -46.656451
    var places: [Place] = []
    var categories: [Category] = []
    var filteredPlaces: [Place] = []
    
    var didUpdateCategories: (() -> Void)?
    var didUpdatePlaces: (() -> Void)?
    
    func fetchInitialData(completion: @escaping ([Category]) -> Void) {
        fetchCategories { categories in
            if let foodCategory = categories.first(where: {$0.name == "Alimentação"}){
                completion(categories)
                self.fetchPlaces(for: foodCategory.id, userLocation: CLLocationCoordinate2D(latitude: self.userLatitude, longitude: self.userLongitude))
            }
        }
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        guard let url = URL(string: "\(baseURL)/categories") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print("Deu erro")
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async{
                    completion(categories)
                }
            } catch{
                print("Deu erro ao pegar catergorias de data")
                completion([])
            }
        }.resume()
    }
    
    func fetchPlaces(for categoryID: String, userLocation: CLLocationCoordinate2D) {
        guard let url = URL(string: "\(baseURL)/markets/category/\(categoryID)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                print("Deu erro")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async{
                    self.didUpdatePlaces?()
                }
            } catch{
                print("Deu erro ao pegar catergorias de data")
            }
        }.resume()
    }
}

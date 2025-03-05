//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation

class ContentViewModel: ObservableObject {
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData] = []
    @Published var searchQuery: String = ""
    
    private let cacheKey = "cachedDevices" 
    var filteredDevices: [DeviceData] {
        if searchQuery.isEmpty {
            return data
        } else {
            return data.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    func fetchAPI() {
        if let cachedData = loadCachedData() {
            self.data = cachedData
            print("Loaded data from cache")
            return
        }        
        apiService.fetchDeviceDetails { result in
            switch result {
            case .success(let devices):
                DispatchQueue.main.async {
                    self.data = devices
                    self.saveDataToCache(devices) // Save data to cache
                    print("Fetched data from API and saved to cache")
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveDataToCache(_ devices: [DeviceData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(devices) {
            UserDefaults.standard.set(encoded, forKey: cacheKey)
        }
    }
    
    private func loadCachedData() -> [DeviceData]? {
        if let savedData = UserDefaults.standard.data(forKey: cacheKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([DeviceData].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }
    
    func clearCache() {
        UserDefaults.standard.removeObject(forKey: cacheKey)
        print("Cache cleared")
    }
    
    func navigateToDetail(_ device: DeviceData) {
        navigateDetail = device
    }
}

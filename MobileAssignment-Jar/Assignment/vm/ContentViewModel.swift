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

    var filteredDevices: [DeviceData] {
        if searchQuery.isEmpty {
            return data
        } else {
            return data.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    func fetchAPI() {
        apiService.fetchDeviceDetails { result in
            switch result {
            case .success(let devices):
                DispatchQueue.main.async {
                    self.data = devices
                }
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }

    func navigateToDetail(_ device: DeviceData) {
        navigateDetail = device
    }
}

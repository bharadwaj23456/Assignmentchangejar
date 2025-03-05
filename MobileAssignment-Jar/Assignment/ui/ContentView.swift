//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    TextField("Search devices...", text: $viewModel.searchQuery)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    if !viewModel.searchQuery.isEmpty {
                        Button(action: {
                            viewModel.searchQuery = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 12)
                    }
                }

                Group {
                    if viewModel.data.isEmpty {
                        ProgressView("Loading...")
                    } else {
                        DevicesList(devices: viewModel.filteredDevices) { selectedDevice in
                            viewModel.navigateToDetail(selectedDevice)
                        }
                    }
                }
            }
            .onChange(of: viewModel.navigateDetail) { newValue in
                if let device = newValue {
                    path.append(device)
                }
            }
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { device in
                DetailView(device: device)
            }
            .onAppear {
                viewModel.fetchAPI()
            }
        }
    }
}

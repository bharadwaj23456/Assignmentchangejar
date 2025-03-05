//
//  NewDetailView.swift
//  Assignment
//
//  Created by Reddy Bharadwaj Chowdary on 05/03/25.
//

import SwiftUI

struct NewDetailView: View {
    let device: DeviceData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Item ID: \(device.id)")
                .font(.title)
                .bold()
                .padding()
            
            if let data = device.data {
                if let price = data.price {
                    Text("Price: $\(price, specifier: "%.2f")")
                        .font(.title2)
                }
                if let description = data.description {
                    Text("Description: \(description)")
                        .font(.body)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

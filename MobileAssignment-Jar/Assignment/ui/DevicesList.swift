//
//  ComputerList.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct DevicesList: View {
    let devices: [DeviceData]
    let onDeviceSelected: (DeviceData) -> Void

    var body: some View {
        List(devices) { device in
            Button {
                onDeviceSelected(device)
            } label: {
                VStack(alignment: .leading) {
                    Text(device.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
            .padding(18)
        }
    }
}

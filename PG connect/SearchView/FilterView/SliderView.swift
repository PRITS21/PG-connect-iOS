//
//  SliderView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 10/03/24.
//

import SwiftUI

struct SliderView: View {
    
        @State private var speed = 50.0
        @State private var isEditing = false


        var body: some View {
            Slider(
                value: $speed,
                in: 0...100,
                step: 5
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            
        }
    
}

#Preview {
    SliderView()
}

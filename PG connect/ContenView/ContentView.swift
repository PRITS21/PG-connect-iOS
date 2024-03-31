//
//  ContentView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 02/03/24.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
            if let token = AuthService.shared.getToken() {
                BottomTabView()
                
            } else {
                StartView2()
            }
        }
}

#Preview {
    ContentView2()
}

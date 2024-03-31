//
//  ContentView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 02/03/24.
//

import SwiftUI

struct StartView1: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Image(uiImage: UIImage(named: "1st_Login")!)
                        .resizable()
                        .scaledToFit()
                        .imageScale(.large)
                        .frame(width: 312, height: 312)
                        .padding()
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .frame(width: geometry.size.width - 20, height: 312)
                            .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                            .cornerRadius(25)
                            .padding(.horizontal, 10)
                        
                        WelcomeView()
                        
                    }
                }
            }
        }
    }
}

#Preview {
    StartView1()
}




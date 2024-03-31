//
//  Rules.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 09/03/24.
//

import SwiftUI

struct Rules: View {
    @State private var rules: [String] = [". Student must keep the Campus & Rooms, clean", ". Power bill separate"]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nearby Places")
                    .font(.system(size: 12.5))
                    .bold()
                    .foregroundColor(Color.black)
                Spacer()
            }.padding(.top, 2).padding(.bottom, 12)
            
            ForEach(rules, id: \.self) { rule in
                Text(rule)
                    .font(.system(size: 11.5))
                    .fontWeight(.medium)
            }.padding(.top, 1).padding(.leading, 5)
            
            
        }.padding(.leading)
    }
}

#Preview {
    Rules()
}

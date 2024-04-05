//
//  Rules.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 09/03/24.
//

import SwiftUI

struct Rules: View {
    let rules: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Rules")
                    .font(.system(size: 12.5))
                    .bold()
                    .foregroundColor(Color.black)
                Spacer()
            }.padding(.top, 2).padding(.bottom, 10)
            
            ForEach(rules.components(separatedBy: "\n"), id: \.self) { rule in
                Text(rule)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
            }.padding(.top, 1).padding(.leading, 5)
            
        }.padding(.leading)
    }
}

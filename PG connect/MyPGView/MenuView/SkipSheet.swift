


import SwiftUI

struct SkipMenuResponse: Codable {
    let skipmenu: [String: [String: Bool]]
}


struct SkipSheet: View {
    @ObservedObject var authService = AuthService.shared
    let daysOfWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    let labels = ["Dinner", "Lunch", "Breakfast"]
    @Environment(\.dismiss) var dismiss
    
    let dayAbbreviations: [String: String] = [
        "sunday": "Sun", "monday": "Mon", "tuesday": "Tue",
        "wednesday": "Wed", "thursday": "Thu", "friday": "Fri",
        "saturday": "Sat"
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            HStack {
                Text("Set Up Skip Setup")
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                
                Spacer()
            }.padding(.leading, 35).padding(.bottom, 10)
            
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 80, height: 40)
                    .overlay(
                        Text("Days")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                    )
                    .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                
                
                ForEach(labels, id: \.self) { label in
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 70, height: 40)
                            .overlay(
                                Text(label)
                                    .foregroundColor(.black)
                                    .font(.system(size: label == "Breakfast" ? 14 : 15)) // Conditional font size
                                    .fontWeight(.semibold)
                            )
                            .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                        
                    }
                }
            }.padding(.horizontal)
            
            //table
            ForEach(authService.skipMenu.sorted(by: { (daysOfWeek.firstIndex(of: $0.key) ?? 7) < (daysOfWeek.firstIndex(of: $1.key) ?? 7) }), id: \.key) { day, items in
                
                HStack(spacing: 0) {
                    Text(dayAbbreviations[day] ?? "")
                        .frame(width: 80, height: 40)
                        .foregroundColor(.black)
                        .font(.system(size: day == "Wednesday" ? 12 : 14)) // Conditional font size
                        .fontWeight(.semibold)
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    
                    ForEach(items.sorted(by: { $0.key < $1.key }), id: \.key) { meal, canSkip in
                        Button(action: {
                            self.authService.toggleSkipMenu(day: day, meal: meal, newValue: !canSkip)
                        }) {
                            Text(canSkip ? "Yes" : "")
                                .frame(width: 70, height: 40)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                        }
                    }
                }
                .padding(.horizontal)
                .cornerRadius(10)
            }
            
            HStack(spacing: 10) {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.system(size: 14))
                        .padding(7)
                        .background(Color(.systemGray3))
                        .foregroundColor(.black)
                        .cornerRadius(5)
                }
                Button(action: {
                    dismiss()
                }) {
                    Text("Update")
                        .font(.system(size: 14))
                        .padding(7)
                        .background(Color(UIColor(hex: "#F25621")))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .cornerRadius(5)
                }
            }.padding(.trailing, 40).padding(.top, 15).padding(.bottom, 10)
        }
        .padding()
        .onAppear {
            authService.fetchSkipMenu()
        }
    }

}

struct SkipSheet_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthService() // Assuming AuthService conforms to ObservableObject
        authService.skipMenu = [
            "sunday": ["Breakfast": true, "Lunch": false, "Dinner": true],
            "monday": ["Breakfast": true, "Lunch": true, "Dinner": true],
            "tuesday": ["Breakfast": false, "Lunch": true, "Dinner": true],
            "wednesday": ["Breakfast": true, "Lunch": true, "Dinner": true],
            "thursday": ["Breakfast": true, "Lunch": true, "Dinner": true],
            "friday": ["Breakfast": true, "Lunch": true, "Dinner": true],
            "saturday": ["Breakfast": true, "Lunch": true, "Dinner": true]
        ]
        return SkipSheet(authService: authService)
    }
}


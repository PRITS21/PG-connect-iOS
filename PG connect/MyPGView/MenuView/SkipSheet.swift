import SwiftUI

struct SkipSheet: View {
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
    @Environment(\.dismiss) var dismiss
    @State private var breakfastStates: [Bool] = Array(repeating: true, count: 6)
    @State private var LunchStates: [Bool] = Array(repeating: true, count: 6)
    @State private var DinnerStates: [Bool] = Array(repeating: true, count: 6)
    
    var body: some View {
        VStack {
            
            Spacer()
            HStack {
                Text("Set Up Skip Setup")
                    .foregroundColor(.black)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                
                Spacer()
            }.padding(.leading, 60).padding(.bottom, 7)
            
            HStack(spacing: 0) {
                // 1st column
                VStack(spacing: 0){
                    
                    
                    ForEach(daysOfWeek, id: \.self) { day in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 50, height: 40)
                            .overlay(
                                Text(day)
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 15))
                            )
                            .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    }
                }
                
                // 2nd column
                VStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 80, height: 40)
                        .overlay(
                            Text("Breakfast")
                                .foregroundColor(.black)
                                .font(.system(size: 14)).fontWeight(.semibold)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    
                    ForEach(0..<6) { index in
                        Button {
                            self.breakfastStates[index].toggle()
                        } label: {
                            Text(self.breakfastStates[index] ? "Yes" : "")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 40)
                                .font(.system(size: 15))
                        }
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    }
                }
                
                // 3rd column
                VStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 70, height: 40)
                        .overlay(
                            Text("Lunch")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    
                    ForEach(0..<6) { index in
                        Button {
                            self.LunchStates[index].toggle()
                        } label: {
                            Text(self.LunchStates[index] ? "Yes" : "")
                                .foregroundColor(.black)
                                .frame(width: 70, height: 40)
                                .font(.system(size: 15))
                        }
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    }
                }
                
                // 4th column
                VStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 70, height: 40)
                        .overlay(
                            Text("Dinner")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    
                    ForEach(0..<6) { index in
                        Button {
                            self.DinnerStates[index].toggle()
                        } label: {
                            Text(self.DinnerStates[index] ? "Yes" : "")
                                .foregroundColor(.black)
                                .frame(width: 70, height: 40)
                                .font(.system(size: 15))
                        }
                        .overlay(RoundedRectangle(cornerRadius: 1).stroke(lineWidth: 0.7).foregroundColor(.gray))
                    }
                }
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
    }
}

struct SkipSheet_Previews: PreviewProvider {
    static var previews: some View {
        SkipSheet()
    }
}

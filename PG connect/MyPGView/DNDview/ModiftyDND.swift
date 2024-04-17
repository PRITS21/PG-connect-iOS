//
//  ModiftyDND.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 13/04/24.
//

import SwiftUI

struct ModiftyDND: View {
    @Environment(\.dismiss) var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedSession = "tiffin"
    var DndID: String
    var DndStartingDate: String
    
    var body: some View {
        NavigationView {
            VStack {
                // 1st part - Header
                ZStack(alignment: .center) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .imageScale(.large)
                                .bold()
                                .padding(.leading, 15)
                            Spacer()
                        }
                    }
                    Text("Do Not Disturb Mode")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 19))
                        .bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                }.padding(.top, 5).padding(.bottom, 10)
                
                //Dates
                HStack(spacing: 10) {
                    
                    VStack {
                        HStack {
                            Text("Exit Date").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                            Spacer()
                        }
                        HStack{
                            Text(endDate.formatted(.dateTime.day().month().year()))
                                .font(.system(size: 13, weight: .semibold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 9, weight: .bold))
                            Spacer()
                        }
                        .frame(width: .infinity, height: 20)
                        .contentShape(Rectangle())
                        .padding(8)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        .overlay {
                            HStack {
                                ForEach(0..<2) { _ in
                                    DatePicker(selection: $endDate, displayedComponents: .date) {}
                                        .labelsHidden().opacity(0.011)
                                }
                            }
                        }
                        
                    }
                }.padding(.top).padding(.horizontal, 40)
                
                //Drop down menu
                HStack{
                    Text("Select Coming Session").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                    Spacer()
                }.padding(.leading, 45).padding(.top, 10)
                VStack(alignment: .listRowSeparatorLeading) {
                    
                    DropdownMenu(selectedOption: $selectedSession, options: ["tiffin", "lunch", "dinner"])
                        .padding(.top, 5)
                }.padding(.horizontal, 25)
                
                Button {
                    let modification = DNDModification(
                        expectedreturndate: endDate.formattedDate2(),
                        returningmeal: selectedSession)
                    print("modification: \(modification)")
                    AuthService.shared.modifyDND(id: DndID, modification: modification) { result in
                            switch result {
                            case .success(_):
                                print("DND modified successfully")
                            case .failure(let error):
                                print("Error modifying DND: \(error)")
                            }
                        }
                    print("DND Button Tapped")
                } label: {
                    Text("Edit  DND")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(.white)
                        .padding()
                        .background( Rectangle()
                            .fill(Color(UIColor(hex: "#7F32CD")))
                            .cornerRadius(10)
                        )
                }.padding(.horizontal, 40).padding(.top, 30)

            }
        }.navigationBarBackButtonHidden()
        
    }
}

struct ModifyDND_Previews: PreviewProvider {
    static var previews: some View {
        ModiftyDND(DndID: "yourDndID", DndStartingDate: "yourDndStartingDate")
    }
}

//
//  RentView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 19/03/24.
//

import SwiftUI

struct RentView: View {
    @ObservedObject var viewModel = AuthService.shared
    @Environment(\.dismiss) var dismiss
    @State private var Year: String = "2024"
    @State private var Month: String = "2"
    @State private var paid: String = "Unpaid"
    @State private var Paid_On: String = "9-4-2024"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.black)
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    }
                    
                    Text("Rent Table")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                        .padding(.leading, 30)
                    Spacer()
                }.padding(.leading)
                
                VStack {
                    HStack {
                        Text("Due Date:")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                            .font(.system(size: 14))
                        if let dueDate = viewModel.rentTableResponse?.rentduedate {
                            Text("\(dueDate) of Every Month")
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 14))
                        } else {
                            Text("N/A")
                                .foregroundColor(.red)
                                .font(.system(size: 11))
                        }
                        Spacer()
                    }
                    
                    VStack {
                        
                        HStack() {
                            
                            Text("Month")
                                .fontWeight(.medium)
                                .frame(width: 60)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                                .padding(.leading, 30)
                            Spacer()
                            Text("Year")
                                .fontWeight(.medium)
                                .frame(width: 60)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                            Spacer()
                            Text("status")
                                .fontWeight(.medium)
                                .frame(width: 60)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                            Spacer()
                            Text("Paid on")
                                .fontWeight(.medium)
                                .frame(width: 60)
                                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                                .font(.system(size: 12.5))
                                .padding(.trailing, 30)
                        }.padding(.top, 15)
                        
                        Rectangle()
                            .foregroundStyle(Color(uiColor: .systemGray3))
                            .frame(height: 1.5)
                        
                  
                       
                        ForEach(viewModel.rentTableResponse?.renttable ?? [], id: \.id) { rent in
                            RentViewRows(rent: rent)
                                Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [4])).frame(height: 1).foregroundColor(.gray)
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                    .padding(.top, 10)
                    
                }.padding(.horizontal).padding(.top, 30)
                
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.fetchRentTable()
        }
    }
}

struct RentViewRows: View {
    let rent: Renttable
    
    var body: some View {
        HStack() {
            
            
            Text("\(rent.month)")
                .fontWeight(.medium)
                .frame(width: 60)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 12.5))
                .padding(.leading, 30)
            Spacer()
            Text("\(rent.year)")
                .fontWeight(.medium)
                .frame(width: 60)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 12.5))
            Spacer()
            Text(rent.paid ? "Paid" : "Unpaid")
                .fontWeight(.medium)
                .frame(width: 60)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 12.5))
            Spacer()
            Text(rent.paidon ?? "")
                .fontWeight(.medium)
                .frame(width: 80)
                .foregroundColor(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 12.5))
                .padding(.trailing, 10)
        }.padding(.top, 5).padding(.bottom)
        
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create dummy Renttable instances
        let rent1 = Renttable(month: 1, year: 2023, paid: true, paidon: "2023-01-15", id: "1")
        let rent2 = Renttable(month: 2, year: 2023, paid: false, paidon: nil, id: "2")
        let rent3 = Renttable(month: 3, year: 2023, paid: true, paidon: "2023-03-10", id: "3")
        
        // Create dummy RentTableResponse with the dummy Renttable instances
        let rentTableResponse = RentTableResponse(renttable: [rent1, rent2, rent3], rentduedate: 12)
        
        // Create a RentView with the dummy data
        return RentView()
            .environmentObject(AuthService())
            .environment(\.colorScheme, .light)
            .previewLayout(.sizeThatFits)
            .onAppear {
                AuthService.shared.rentTableResponse = rentTableResponse
            }
    }
}

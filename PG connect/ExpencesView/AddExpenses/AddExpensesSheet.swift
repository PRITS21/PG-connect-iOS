//
//  AddExpensesSheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 24/03/24.
//

import SwiftUI

struct AddExpensesSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var Name: String = ""
    @State private var Quantity: String = ""
    @State private var Amount: String = ""
    @State private var selectedCategory = "KG"
    var ExpenseGroupId: String? // Expense group ID

    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity,height: 300).cornerRadius(10)
                .foregroundStyle(Color.white).padding(.horizontal)
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .overlay(
                    VStack {
                        //1st part
                        HStack(spacing: 30){
                            
                            Text("Add Expenses")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.black)
                            Spacer()
                        }
                        
                        TextField("Enter Name", text: $Name)
                            .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                            .background(Color(uiColor: .systemGray6))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                            .cornerRadius(5).padding(.bottom, 5).padding(.top, 5)
                        
                        //2nd part
                        HStack(spacing: 15) {
                            
                            TextField("Quantity", text: $Quantity)
                                .keyboardType(.numberPad)
                                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                                .background(Color(uiColor: .systemGray6))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                                .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
                            TextField("Amount", text: $Amount)
                                .keyboardType(.numberPad)
                                .font(.system(size: 14)).frame(height: 30).padding(.leading, 10)
                                .background(Color(uiColor: .systemGray6))
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black))
                                .cornerRadius(5).padding(.bottom, 10).padding(.top, 5)
                            
                            
                        }.padding(.top, 7)
                        
                        //3rd Part
                        HStack {
                            Picker("Food Category",
                                   selection: $selectedCategory) {
                                Text("KG")
                                    .tag("KG")
                                Text("Litre")
                                    .tag("Litre")
                                Text("Count")
                                    .tag("Count")
                            }
                            .accentColor(.black).background(Color(uiColor: .systemGray6)).cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5).foregroundColor(.black)).padding(.top, 5)
                            Spacer()
                        }
                        
                        //4th part
                        HStack(spacing: 10) {
                            Spacer()
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Cancel")
                                    .font(.system(size: 14))
                                    .padding(10)
                                    .background(Color(.systemGray3))
                                    .foregroundColor(.black)
                                    .cornerRadius(5)
                            }.frame(height: 30)
                            Button(action: {
                                print("Schedule Button tapped!")
                                AuthService.shared.addExpense(name: Name, quantity: Quantity, amount: Amount, selectedCategory: selectedCategory, expenseGroupId: ExpenseGroupId!) { result in
                                    switch result {
                                    case .success(let message):
                                        print("Expenses data uploaded successfully: \(message)")
                                    case .failure(let error):
                                        print("Error uploading Expenses data: \(error.localizedDescription)")
                                    }
                                    dismiss()
                                }
                            }) {
                                Text("Add Group")
                                    .font(.system(size: 14))
                                    .padding(10)
                                    .background(Color(UIColor(hex: "#F25621")))
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                    .cornerRadius(5)
                            }.frame(height: 30)
                            
                        }.padding(.trailing).padding(.top, 10).padding(.bottom, 10)
                        
                        
                        
                    }
                    .padding(.horizontal, 30)
                )
        }
    }
}


//
//  ExpencesView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/03/24.
//

import SwiftUI

struct ExpencesView: View {
    @Environment(\.dismiss) var dismiss
    @State var activeSheet: ActiveSheet?
    @State private var selectedDate = Date()
    @State private var isAddGroupShoing = false
    @State private var searchText: String = ""
    @State private var isDatePickerPresented = false // State to control the date picker
    
    var body: some View {
        NavigationView {
            VStack {
                // 1st part - Header
                HStack{
                    Button { dismiss() } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black).imageScale(.large).bold().padding(.leading, 15)
                            Spacer()
                        }
                    }
                    Text("Expenses")
                        .multilineTextAlignment(.center).font(.system(size: 19)).bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                    Button { dismiss() } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black).imageScale(.large).bold().padding(.trailing, 15)
                        }
                    }
                }.padding(.top, 5).padding(.bottom, 10)
                
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 40)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            TextField("Search Expenses", text: $searchText)
                                .font(.system(size: 15))
                                .padding(.leading, 15)
                                .frame(height: 40)
                                .foregroundColor(.black)
                                .background(Color.clear)
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Image(uiImage: UIImage(named: "search_icon_orange")!)
                                .foregroundColor(.orange).padding(.trailing)
                        }
                    }
                    .padding(.trailing, 10)
                    Spacer()
                    Rectangle()
                        .frame(width: 40,height: 40).cornerRadius(10)
                        .foregroundStyle(Color.white)
                        .overlay(
                            Image(uiImage: UIImage(named: "Date_icon")!).resizable().frame(width: 18, height: 18)
                        ).padding(.trailing, 5)
                        .onTapGesture {
                            isDatePickerPresented.toggle()
                            
                        }
//                    Rectangle()
//                        .frame(width: 40,height: 40).cornerRadius(10)
//                        .foregroundStyle(Color.white)
//                        .overlay(
//                            Image(uiImage: UIImage(named: "filter_icon")!).resizable().frame(width: 18, height: 18)
//                        )
                    
                }
                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                .padding(.bottom, 5).padding(.horizontal).padding(.top, 10)
                
                
                
                HStack (spacing: 15) {
                    Button {
                        isAddGroupShoing.toggle()
                    } label: {
                        Circle()
                            .frame(width: 35, height: 35).foregroundColor(.gray.opacity(0.2))
                            .overlay {
                                Image(systemName: "plus").foregroundColor(.black).bold().imageScale(.small)
                            }
                        Text("Add Group").font(.system(size: 18)).fontWeight(.medium).foregroundColor(.black)
                    }
                    Spacer()
                    if isDatePickerPresented {
                        DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                            .labelsHidden()
                            .padding(.trailing)
                    }
                }.padding(.leading).padding(.top, 10)
                
                ExpensesBars()
                
                Spacer()
                
                
            }
            .sheet(isPresented: $isAddGroupShoing) {
                AddGroupSheet()
                    .presentationCornerRadius(21)
                    .presentationDetents([.height(200)])
            }
            .onAppear {
                getAllExpenses()
            }
            .onChange(of: selectedDate) { _ in
                getAllExpenses()
            }
        }.navigationBarBackButtonHidden()
    }
    func getAllExpenses() {
        AuthService.shared.getAllExpenses2() { result in
            switch result {
            case .success(let response):
                print("Response: \(response)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to format date as "yyyy-MM-dd"
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}


struct ExpensesBars: View {
    @State private var isAddExpenses = false
    @State private var Group_Name: String = "Biriyani"
    @State private var Price = "$2000"
    @StateObject private var authService = AuthService.shared
    @State private var selectedExpense: Expense? = nil
    @State private var selectedExpenseGroupId: String?
    
    var body: some View {
        
        
        VStack {
            ForEach(authService.expenses) { expense in
                
                let totalPaidAmount = expense.expenses.reduce(0) { $0 + $1.totalAmount }

                NavigationLink(destination: CardsView(expense: expense), tag: expense, selection: $selectedExpense) { // Pass the selected expense to CardsView
                    Rectangle()
                        .frame(width: .infinity, height: 80)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                        .overlay (
                            HStack {
                                Image(uiImage: UIImage(named: "Expenses_image")!)
                                    .resizable()
                                    .frame(width: 101, height: 75)
                                
                                VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                    
                                    Text(expense.title)
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 16))
                                    
                                    Text("Total: \(totalPaidAmount)")
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 12)).fontWeight(.medium)
                                    
                                    Spacer()
                                }.padding(.leading, 10).padding(.top, 22)
                                Spacer()
                                HStack {
                                    Button{
                                        isAddExpenses.toggle()
                                        selectedExpenseGroupId = expense._id
                                        var x = print("selected Expense id: \(selectedExpenseGroupId)")
                                    }label: {
                                        HStack{
                                            Image(uiImage: UIImage(named: "Add_icon")!)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                            Text("Add")
                                                .fontWeight(.medium)
                                                .foregroundStyle(Color.white)
                                                .font(.system(size: 16))
                                        }
                                    }
                                    .frame(width: 80, height: 35)
                                    .background(Color(UIColor(hex: "#F25621")))
                                    .cornerRadius(5)
                                    .padding(.trailing)
                                }
                            }
                        )
                        .onTapGesture {
                            selectedExpense = expense // Update the selectedExpense when tapped
                        }
                        .background(Color.white)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
            }
        }
        .padding(.top, 10)
        .sheet(isPresented: Binding<Bool>(
            get: { isAddExpenses && selectedExpenseGroupId != nil },
            set: { isAddExpenses = $0 }
        )) {
            AddExpensesSheet(ExpenseGroupId: selectedExpenseGroupId ?? "")
                .presentationCornerRadius(21)
                .presentationDetents([.medium, .large])
        }

        .onAppear {
            print("Selected Expense Group Id: \(selectedExpenseGroupId ?? "None")")
        }
    }
}

#Preview {
    ExpencesView()
}

//
//  CardsView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 24/03/24.
//

import SwiftUI

struct CardsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isAddGroupPresented = false
    @State private var searchText: String = ""
    var expense: Expense
    
    var totalPaidAmount: Int {
        expense.expenses.reduce(0) { $0 + $1.totalAmount }
    }
    var body: some View {
        NavigationView {
            VStack {
                
                //MARK: 1st part - Header
                HStack{
                    Button { dismiss() } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black).imageScale(.large).bold().padding(.leading, 15)
                            Spacer()
                        }
                    }
                    Text(expense.title)
                        .multilineTextAlignment(.center).font(.system(size: 19)).bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                    
                    
                    Button {
                        AuthService.shared.deleteExpenseGroup(expenseID: expense._id){ result in
                            switch result {
                            case .success:
                                print("Expense Group deleted successfully")
                            case .failure(let error):
                                print("Expense Group Id: \(expense._id)")
                                print("Error Group deleting expense: \(error.localizedDescription)")
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "trash.fill")
                                .foregroundStyle(Color(UIColor(hex: "#F25621")))
                                .imageScale(.medium).bold().padding(.trailing, 15)
                        }
                    }
                }.padding(.top, 5).padding(.bottom, 10)
                
                HStack {
                    VStack(alignment: .listRowSeparatorLeading) {
                        Text("Total Expenses :")
                            .multilineTextAlignment(.center).font(.system(size: 16)).fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        Text("\(totalPaidAmount)")
                            .multilineTextAlignment(.center).font(.system(size: 30)).fontWeight(.medium)
                            .foregroundStyle(Color.black).padding(.top, 7)
                    }
                    Spacer()
                }.padding(.top, 15).padding(.leading)
                
                Rectangle()
                    .foregroundStyle(Color(uiColor: .systemGray4))
                    .frame(height: 2)
                    .padding(.top, 20).padding(.horizontal)
                
                HStack {
                    Text("List Of This Group").multilineTextAlignment(.center).font(.system(size: 19)).fontWeight(.medium)
                    Spacer()
                }.padding(.leading).padding(.top, 10)
                
                ScrollView {
                    VStack (spacing: 3){
                        
                        ForEach(expense.expenses) { expenseDetail in
                            Rectangle()
                                .frame(width: .infinity, height: 75)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
                                .overlay (
                                    ZStack(alignment: .topTrailing) {
                                        HStack {
                                            //1st
                                            VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                                Text("\(monthAbbreviation(from: expenseDetail.date))")
                                                    .fontWeight(.medium).foregroundStyle(Color(UIColor(hex: "#F25621")))
                                                    .font(.system(size: 17))
                                                Text(expenseDetail.formattedDate).foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                                    .font(.system(size: 15)).fontWeight(.medium)
                                                Spacer()
                                            }.padding(.leading, 20).padding(.top, 12)
                                            
                                            //2nd
                                            VStack(alignment: .listRowSeparatorLeading, spacing: 5){
                                                
                                                Text(expenseDetail.description)
                                                    .fontWeight(.medium).foregroundStyle(Color.black).font(.system(size: 17))
                                                Text("Paid: \(expenseDetail.totalAmount)")
                                                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                                    .font(.system(size: 14))
                                                Spacer()
                                            }.padding(.leading, 30).padding(.top, 12)
                                            Spacer()
                                            
                                            //3rd
                                            VStack {
                                                Text("\(expenseDetail.unit): 25")
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(Color.black)
                                                    .font(.system(size: 16))
                                                Spacer()
                                            }.padding(.trailing, 25).padding(.top, 12)
                                        }
                                        
                                        //4th
                                        ZStack {
                                            Button(action: {
                                                AuthService.shared.deleteExpense(expenseID: expenseDetail._id){ result in
                                                    switch result {
                                                    case .success:
                                                        print("Expense deleted successfully")
                                                    case .failure(let error):
                                                        print("Expense Id: \(expenseDetail._id)")
                                                        print("Error deleting expense: \(error.localizedDescription)")
                                                    }
                                                }
                                            }) {
                                                Image(systemName: "x.circle.fill")
                                                    .resizable()
                                                    .foregroundStyle(Color.red)
                                                    .frame(width: 16, height: 16)
                                                    .imageScale(.medium).bold()
                                            }
                                        }
                                    }
                                )
                                .background(Color.white)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
    func monthAbbreviation(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        return monthFormatter.string(from: date)
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleExpense = Expense(_id: "1", title: "Sample Expense", image: nil, expenses: [
            ExpenseDetail(_id: "1", description: "Expense ", category: "Category 1", unitAmount: 10, totalAmount: 100, date: "2024-04-10T12:00:00.000Z", image: nil, quantity: 1, unit: "Kg 1"),
            ExpenseDetail(_id: "2", description: "Expense ", category: "Category 2", unitAmount: 20, totalAmount: 200, date: "2024-04-11T12:00:00.000Z", image: nil, quantity: 2, unit: "Unit 2"),
            ExpenseDetail(_id: "3", description: "Expense", category: "Category 3", unitAmount: 30, totalAmount: 300, date: "2024-04-12T12:00:00.000Z", image: nil, quantity: 3, unit: "Unit 3")
        ])
        
        return CardsView(expense: sampleExpense)
    }
}

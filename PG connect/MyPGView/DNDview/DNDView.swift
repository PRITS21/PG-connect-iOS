//
//  DNDView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 23/03/24.
//

import SwiftUI

struct DNDView: View {
    @Environment(\.dismiss) var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedSession = "tiffin"
    
    
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
                    Text("Edit DND Mode")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 19))
                        .bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                    
                }.padding(.top, 5).padding(.bottom, 10)
                
                //Dates
                HStack(spacing: 10) {
                    
                    VStack {
                        HStack {
                            Text("Entry Date").bold().foregroundStyle(Color(UIColor(hex: "#5E6278"))).font(.system(size: 12))
                            Spacer()
                        }
                        HStack{
                            Text(startDate.formatted(.dateTime.day().month().year()))
                                .font(.system(size: 13, weight: .semibold))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 9, weight: .bold)).padding(.trailing)
                            Spacer()
                        }
                        .frame(width: .infinity, height: 20)
                        .contentShape(Rectangle())
                        .padding(8)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        .overlay {
                            HStack {
                                DatePicker(selection: $startDate, displayedComponents: .date) {}
                                    .labelsHidden().opacity(0.011)
                            }
                        }
                    }
                    
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
                            DatePicker(selection: $endDate, displayedComponents: .date) {}
                                .labelsHidden().opacity(0.011)
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
                    
                    Task {
                        do {
                            try await uploadDND2()
                            print("!!!!!!!!")
                        } catch {
                            print("Error from signup : \(error.localizedDescription)")
                        }
                    }
                    
                    print("DND Button Tapped")
                } label: {
                    Text("Start DND")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        .foregroundColor(.white)
                        .padding()
                        .background( Rectangle()
                            .fill(Color(UIColor(hex: "#7F32CD")))
                            .cornerRadius(10)
                        )
                }.padding(.horizontal, 40).padding(.top, 30)
                
                Rectangle()
                    .foregroundStyle(Color(uiColor: .systemGray4))
                    .frame(height: 2)
                    .padding(.top, 20)
                
                
                ScrollView {
                    DNDItemView()
                }
                
               // Spacer()
            }
        }.navigationBarBackButtonHidden()
        
    }
    func uploadDND2() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let startingDateStr = dateFormatter.string(from: startDate)
        print("start: \(startingDateStr)")
        let endDateStr = dateFormatter.string(from: endDate)
        do {
            try await AuthService.shared.uploadDND2(startingDate: startingDateStr, expectedReturnDate: endDateStr, returningMeal: selectedSession) { result in
                switch result {
                case .success(let message):
                    print("DND data uploaded successfully: \(message)")
                case .failure(let error):
                    print("Error uploading DND data: \(error.localizedDescription)")
                }
            }
        } catch {
            // Handle error
            print("****")
            
        }
    }
    
}


struct DNDItemView: View {
    @ObservedObject var viewModel = AuthService.shared
    
    var body: some View {
        VStack {
            ForEach(viewModel.dndData.keys.sorted(), id: \.self) { sectionKey in
                SectionView(header: sectionKey, dndItems: viewModel.dndData[sectionKey] ?? []) { dndItem in
                    deleteDNDItem(id: dndItem._id)
                }
            }
        }
        .onAppear {
            viewModel.getDND()
        }
    }
    
    func deleteDNDItem(id: String) {
        // Call your deleteDND method here
        AuthService.shared.deleteDND(id: id)
    }
}


struct SectionView: View {
    var header: String
    var dndItems: [DNDItem]
    var onDelete: ((DNDItem) -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Text(header)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                Spacer()
            }
            .padding(.leading, 40)
            .padding(.top,10)
            
            ForEach(dndItems) { dndItem in
                if header == "Pending DND" {
                    PendingDNDRowView(dndItem: dndItem, onDelete: {
                        onDelete?(dndItem)
                    })
                } else {
                    DNDRowView(dndItem: dndItem)
                }
            }
        }
    }
}

struct DNDRowView: View {
    @State private var sheetHeight: CGFloat = .zero
    @State private var isBottomSheetPresented = false
    var dndItem: DNDItem
    
    var body: some View {
        Rectangle()
            .frame(height: 80)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
            .overlay (
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 1) {
                            Text("Start Date: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text(dndItem.formattedStartDate)
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                        }
                        HStack(spacing: 1) {
                            Text("End Date: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text(dndItem.formattedReturnDate)
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                        }
                        HStack(spacing: 20) {
                            HStack(spacing: 5) {
                                Text("Session:")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12.5))
                                Text(dndItem.returningmeal)
                                    .foregroundStyle(Color.gray)
                                    .font(.system(size: 12.5))
                            }
                            HStack(spacing: 5) {
                                Text("Days: ")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12.5))
                                Text("\(dndItem.days)")
                                    .foregroundStyle(Color.gray)
                                    .font(.system(size: 12.5))
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        self.isBottomSheetPresented.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.black)
                            .padding(.trailing, 30)
                    }
                        
                }
                    .padding(.leading, 20)
            )
            .padding(.horizontal, 25)
            .padding(.top, 10)
            .sheet(isPresented: $isBottomSheetPresented) {
                ModiftyDND(DndID: dndItem._id, DndStartingDate: dndItem.formattedStartDate)
                    .presentationDetents([.height(320)])
                    .presentationCornerRadius(21)
            }
    }
    
}
//MARK: Pending DND
struct PendingDNDRowView: View {
    var dndItem: DNDItem
    var onDelete: (() -> Void)?

    var body: some View {
        Rectangle()
            .frame(height: 80)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 1)
            .overlay (
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 1) {
                            Text("Start Date: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text(dndItem.formattedStartDate)
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                        }
                        HStack(spacing: 1) {
                            Text("End Date: ")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 12.5))
                            Text(dndItem.formattedReturnDate)
                                .foregroundStyle(Color.gray)
                                .font(.system(size: 12.5))
                        }
                        HStack(spacing: 20) {
                            HStack(spacing: 5) {
                                Text("Session:")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12.5))
                                Text(dndItem.returningmeal)
                                    .foregroundStyle(Color.gray)
                                    .font(.system(size: 12.5))
                            }
                            HStack(spacing: 5) {
                                Text("Days: ")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.black)
                                    .font(.system(size: 12.5))
                                Text("\(dndItem.days)")
                                    .foregroundStyle(Color.gray)
                                    .font(.system(size: 12.5))
                            }
                        }
                    }
                    Spacer()
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(UIColor(hex: "#F25621")))
                        .padding(.trailing, 30)
                        .onTapGesture {
                            onDelete?()
                        }
                }
                .padding(.leading, 20)
            )
            .padding(.horizontal, 25)
            .padding(.top, 10)
    }
}

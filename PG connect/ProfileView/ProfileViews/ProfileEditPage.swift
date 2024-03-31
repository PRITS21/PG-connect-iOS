//
//  ProfileEditPage.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 15/03/24.
//

import SwiftUI

struct ProfileEditPage: View {
    @Environment(\.dismiss) var dismiss
    @State private var showPreferencesSheet = false
    @State private var showLanguagesSheet = false
    @State private var showWorkShiftSheet = false
    @State private var showFoodTypeSheet = false
    @State private var selectedPreferences1: [String] = []
    @State private var selectedPreferences2: [String] = []
    @State private var selectedPreferences3: [String] = []
    @State private var selectedPreferences4: [String] = []
    @State private var selectedEducationTags: Set<String> = []
    
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
                    
                    Text("Profile")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                        .padding(.leading, 30)
                    Spacer()
                }.padding(.leading)
                
                
                //1st part
                ScrollView {
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        NavigationLink(destination: ProfileChangeView()) {
                            Text("Edit Profile")
                                .font(.system(size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 70,height: 25)
                        .background(Color(UIColor(hex: "#EF7C1F")))
                        .cornerRadius(5)
                        .padding(.top, 7)
                        
                    }.padding(.top, 10)
                    
                    //2nd part
                    ProfileInfoView()
                    
                    //3rd part
                    VStack( spacing: 0) {
                        ProfileEditViewButtons(title: "Preferences", buttonNames: selectedPreferences1, isPresented: $showPreferencesSheet)
                        ProfileEditViewButtons(title: "Languages", buttonNames: selectedPreferences2, isPresented: $showLanguagesSheet)
                        ProfileEditViewButtons(title: "Work Shift / Days / Hours", buttonNames: selectedPreferences3, isPresented: $showWorkShiftSheet)
                        ProfileEditViewButtons(title: "Food Type", buttonNames: selectedPreferences4, isPresented: $showFoodTypeSheet)
                        
                    }
                    
                    //4th part
                    VStack( spacing: 7) {
                        ProfileEditDocuments(title: "Aadhar number")
                        ProfileEditDocuments(title: "Driving license")
                    }
                }
            }
            .background(Color(uiColor: .systemGray6))
            .sheet(isPresented: $showPreferencesSheet) {
                PreferenceSheet(selectedPreferences: $selectedPreferences1)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(21)
            }
            .sheet(isPresented: $showLanguagesSheet) {
                Languages_sheet(selectedPreferences2: $selectedPreferences2)
                    .presentationDetents([.height(280)])
                    .presentationCornerRadius(21)
            }
            .sheet(isPresented: $showWorkShiftSheet) {
                DayShiftSheet(selectedPreferences: $selectedPreferences3)
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(21)
            }
            .sheet(isPresented: $showFoodTypeSheet) {
                food_sheet(selectedPreferences4: $selectedPreferences4)
                    .presentationDetents([.height(160)])
                    .presentationCornerRadius(21)
            }
        }
        .navigationBarBackButtonHidden()
    }
}


struct ProfileEditViewButtons: View {
    
    let buttonsPerRow = 5
    let title: String
    let buttonNames: [String]
    @Binding var isPresented: Bool // Binding to determine if sheet is presented
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 14))
                
                Spacer()
                Button(action: { isPresented = true }) {
                    Image(uiImage: UIImage(named: "Pencil_icon")!)
                        .foregroundColor(Color.black)
                        .bold()
                        .padding(.trailing, 30)
                }
            }.padding(.top, 7)
            
            // Buttons
            if !buttonNames.isEmpty  {
                VStack {
                    ForEach(0..<buttonNames.count / buttonsPerRow + 1) { rowIndex in
                        HStack(spacing: 14) {
                            ForEach(0..<min(buttonsPerRow, buttonNames.count - rowIndex * buttonsPerRow)) { columnIndex in
                                let index = rowIndex * buttonsPerRow + columnIndex
                                
                                Text(buttonNames[index])
                                    .frame(width: .infinity, height: 8)
                                    .font(.system(size: 10))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 6)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                                
                            }
                            Spacer()
                        }
                    }
                }.padding(.top, 10).padding(.bottom, 20)
            }
        }
        .padding(.leading, 40)
        .frame(minHeight: 50, maxHeight: .infinity)
        .frame(width: .infinity)
        .background(Color.white)
        .padding(.top, 7)
    }
}

struct ProfileEditDocuments: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.medium)
                .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                .font(.system(size: 15))
                .padding(.leading, 40)
            Spacer()
            Button {
                
            } label: {
                Image(uiImage: UIImage(named: "photos_icon")!)
                    .foregroundStyle(Color.black)
                    .bold()
                    .padding(.trailing, 30)
            }
        }
        .frame(width: .infinity, height: 70)
        .background(.white)
        
    }
}


struct ProfileInfoView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 300)
                .foregroundStyle(Color.white)
                .padding(.top, 10)
            
            HStack {
                //1st column
                VStack(alignment: .listRowSeparatorLeading) {
                    Text("Full name")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                    Text("Pritam Sarkar")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .padding(.top, 1)
                    
                    Text("Email")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        .padding(.top, 10)
                    Text("saarkarpritam16@gmail.com")
                        .frame(width: 70)
                        .tint(.black)
                        .font(.system(size: 12))
                        .padding(.top, 1)
                    
                    Text("DOB")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        .padding(.top, 10)
                    Text("09/01/2003")
                        .tint(.black)
                        .font(.system(size: 12))
                        .padding(.top, 1)
                    
                    Text("Location")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        .padding(.top, 10)
                    Text("")
                        .tint(.black)
                        .font(.system(size: 12))
                        .padding(.top, 1)
                    
                }.padding(.leading, 40)
                //2nd column
                VStack(alignment: .listRowSeparatorLeading) {
                    Text("Gender")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                    Text("Male")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .padding(.top, 1)
                    
                    Text("Mobile")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        .padding(.top, 10)
                    Text("8900673232")
                        .tint(.black)
                        .font(.system(size: 12))
                        .padding(.top, 1)
                    
                    Text("Ocupation")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        .padding(.top, 45)
                    Text("")
                        .tint(.black)
                        .font(.system(size: 12))
                        .padding(.top, 1)
                    
                    Text("Office address")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        .padding(.top, 10)
                    Text("")
                        .tint(.black)
                        .font(.system(size: 12))
                        .padding(.top, 1)
                    
                }.padding(.leading, 40)
                Spacer()
            }
            
            
        }
    }
}



#Preview {
    ProfileEditPage()
}


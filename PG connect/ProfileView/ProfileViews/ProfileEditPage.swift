//
//  ProfileEditPage.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 15/03/24.
//

import SwiftUI

struct ProfileEditPage: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AuthService.shared
    @State private var userProfile: UserProfileResponse?
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
                        if let userProfile = viewModel.ProfileData {
                            if let imageUrl = URL(string: userProfile.profileimage) {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                            }
                        }
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
                        ProfileEditViewButtons(title: "Preferences", isPresented: $showPreferencesSheet)
                        ProfileEditViewButtons(title: "Languages", isPresented: $showLanguagesSheet)
                        ProfileEditViewButtons(title: "Work Shift / Days / Hours", isPresented: $showWorkShiftSheet)
                        ProfileEditViewButtons(title: "Food Type", isPresented: $showFoodTypeSheet)
                        
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
        .onAppear{
            viewModel.fetchUserData()
        }
    }
}


struct ProfileEditViewButtons: View {
    @ObservedObject var viewModel = AuthService.shared
    
    let buttonsPerRow = 5
    let title: String
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
            
            if let profileData = AuthService.shared.ProfileData {
                if title == "Preferences" {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 10) {
                        ForEach(profileData.prefrences, id: \.self) { preference in
                            Text(preference)
                                .font(.system(size: 10))
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                        }
                    }
                    .padding(.vertical, 10)
                }
                else if title == "Languages" {
                    let allLanguages = profileData.languages.mothertongue + profileData.languages.secondary
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 10) {
                        ForEach(allLanguages, id: \.self) { language in
                            Text(language)
                                .font(.system(size: 10))
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                        }
                    }
                    .padding(.vertical, 10)
                }
                else if title == "Work Shift / Days / Hours" {
                    // Combine shift, office hours, and working days into a single array
                    let combinedData = getCombinedData(profileData: profileData)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 5) {
                        ForEach(combinedData, id: \.self) { data in
                            Text(data)
                                .font(.system(size: 10))
                                .foregroundColor(.black)
                                .frame(width: fontSizeForText(data))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
                        }
                    }
                    .padding(.vertical, 10).padding(.trailing, 10)
                }
                
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
        }
        .padding(.leading, 40)
        .frame(minHeight: 50, maxHeight: .infinity)
        .frame(width: .infinity)
        .background(Color.white)
        .padding(.top, 7)
        .onAppear {
            viewModel.fetchUserData()
        }
    }
    private func getCombinedData(profileData: UserProfileResponse) -> [String] {
        var combinedData: [String] = []
        
        let shift = profileData.shift
        combinedData.append("\(shift)")
        
        
        let startTime = profileData.officehoursstart
        let endTime = profileData.officehoursend
        combinedData.append("\(startTime)")
        combinedData.append("\(endTime)")
        
        let workingDays = profileData.workingdays
        
        let daysOfWeek: [(String, Bool)] = [
            ("Mon", workingDays.monday),
            ("Tue", workingDays.tuesday),
            ("Wed", workingDays.wednesday),
            ("Thu", workingDays.thursday),
            ("Fri", workingDays.friday),
            ("Sat", workingDays.saturday),
            ("Sun", workingDays.sunday)
        ]
        
        for (day, isWorking) in daysOfWeek {
            if isWorking {
                combinedData.append("\(day)")
            }
        }
        return combinedData
    }
    private func fontSizeForText(_ text: String) -> CGFloat {
        let thresholdLength = 8 // Define a threshold length for longer text
        if text.count > thresholdLength {
            return 50 // Set a smaller font size for longer text
        } else {
            return 30 // Default font size for shorter text
        }
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
    @ObservedObject var viewModel = AuthService.shared
    @State private var userProfile: UserProfileResponse?
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 300)
                .foregroundStyle(Color.white)
                .padding(.top, 10)
            
            HStack {
                if let userProfile = viewModel.ProfileData {
                    //1st column
                    VStack(alignment: .listRowSeparatorLeading) {
                        Text("Full name")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        Text("\(userProfile.name)")
                        
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.top, 1)
                        
                        Text("Email")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                            .padding(.top, 10)
                        Text("\(userProfile.email)")
                            .frame(width: 95)
                            .tint(.black)
                            .font(.system(size: 12))
                            .padding(.top, 1)
                        
                        Text("DOB")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                            .padding(.top, 10)
                        
                        if let dobString = userProfile.dob {
                            if let dobDate = parseDate(from: dobString) {
                                let formattedDOB = formatDate(dobDate)
                                
                                Text(formattedDOB)
                                    .tint(.black)
                                    .font(.system(size: 12))
                                    .padding(.top, 1)
                            }
                        }
                        
                        Text("Location")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                            .padding(.top, 10)
                        Text("\(userProfile.location)")
                            .tint(.black)
                            .font(.system(size: 12))
                            .padding(.top, 1)
                            .padding(.bottom, 40)
                        
                    }.padding(.leading, 40)
                    Spacer()
                    
                    //2nd column
                    VStack(alignment: .listRowSeparatorLeading) {
                        Text("Gender")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                        Text("\(userProfile.gender)")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.top, 1)
                        
                        Text("Mobile")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                            .padding(.top, 10)
                        Text("\(userProfile.phone)")
                            .tint(.black)
                            .font(.system(size: 12))
                            .padding(.top, 1)
                        
                        Text("Ocupation")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                            .padding(.top, 45)
                        Text("\(userProfile.occupation)")
                            .tint(.black)
                            .font(.system(size: 12))
                            .padding(.top, 1)
                        
                        Text("Office address")
                            .font(.system(size: 12))
                            .foregroundColor(Color(UIColor(hex: "#5E6278")))
                            .padding(.top, 10)
                        Text("\(userProfile.officeaddress)")
                            .tint(.black)
                            .font(.system(size: 12))
                            .padding(.top, 1)
                        
                    }.padding(.leading, 40)
                    Spacer()
                }
            }
            
        }
        .onAppear{
            viewModel.fetchUserData()
        }
    }
    func parseDate(from dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: dateString)
    }
    
    // Function to format the date
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}




#Preview {
    ProfileEditPage()
}


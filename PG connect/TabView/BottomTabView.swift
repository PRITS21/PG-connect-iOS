//
//  TabView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/03/24.
//

import SwiftUI


struct BottomTabView: View {
    @State var selectedPage: SelectedPage = .first
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    switch selectedPage {
                    case .first:
                        HomeSearchView()
                    case .second:
                        myPGView()
                    case .third:
                        ExpencesView()
                    case .fourth:
                        ProfileView()
                        
                    }
                }
                
                Spacer()
                
                HStack {
                    
                    Button(action: { selectedPage = .first }) {
                        VStack(spacing: 0) {
                            Image(uiImage: UIImage(named: "search_icon")!)
                                .renderingMode(.template)
                                .foregroundColor(selectedPage == .first ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#727272")))
                            Rectangle()
                                .frame(width: 60)
                                .foregroundColor(.green)
                            if selectedPage == .first {
                                Text("Search")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                            }
                        }.padding(.top, 25).padding(.bottom, 15).frame(height: 30)
                        
                    }
                    Spacer()
                    Button(action: { selectedPage = .second }) {
                        VStack(spacing: 0){
                            Image(uiImage: UIImage(named: "Home_icon")!)
                                .renderingMode(.template)
                                .foregroundColor(selectedPage == .second ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#727272")))
                            Rectangle()
                                .frame(width: 60)
                                .foregroundColor(.green)
                            if selectedPage == .second {
                                Text("My PG")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                            }
                        }.padding(.top, 25).padding(.bottom, 15).frame(height: 30)
                    }
                    Spacer()
                    Button(action: { selectedPage = .third }) {
                        VStack(spacing: 0) {
                            Image(uiImage: UIImage(named: "expences_icon")!)
                                .renderingMode(.template)
                                .foregroundColor(selectedPage == .third ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#727272")))
                            Rectangle()
                                .frame(width: 60)
                                .foregroundColor(.green)
                            if selectedPage == .third {
                                Text("Expences")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                            }
                        }.padding(.top, 25).padding(.bottom, 15).frame(height: 30)
                    }
                    Spacer()
                    Button(action: { selectedPage = .fourth }) {
                        VStack(spacing: 0) {
                            Image(uiImage: UIImage(named: "profile_icon")!)
                                .renderingMode(.template)
                                .foregroundColor(selectedPage == .fourth ? Color(UIColor(hex: "#7F32CD")) : Color(UIColor(hex: "#727272")))
                            Rectangle()
                                .frame(width: 60)
                                .foregroundColor(.green)
                            
                            if selectedPage == .fourth {
                                Text("Profile")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                            }
                        }.padding(.top, 25).padding(.bottom, 5).frame(height: 30)
                    }
                    
                }
                .padding(.horizontal, 35)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) // Keep the tab bar above the safe area

            }
            .edgesIgnoringSafeArea(.bottom)
            .shadow(color: Color.gray.opacity(0.4), radius: 1, x: 0, y: 1)
             
            
        }.navigationBarBackButtonHidden()
    }
}

enum SelectedPage {
    case first, second, third, fourth
}

#Preview {
    BottomTabView()
}

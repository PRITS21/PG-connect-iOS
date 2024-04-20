//
//  HomeSearchView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 04/03/24.
//


import SwiftUI

struct HomeSearchView: View {
    @StateObject var viewModel = AuthService()
    @State var offsetY: CGFloat = 0
    @State var showSearchBar: Bool = false
    @Environment(\.isDragging) var isDragging
    @State var reset: Bool = false
    @State private var sheetHeight: CGFloat = .zero
    @State var isFilterSheetPresented = false
    @State private var searchText: String = ""
    @State var activeSheet: ActiveSheet?
    @State var selectedCity: String? = nil
    @State private var selectedFilters: Int?
    @State private var selectedFilters2: Int?
    @State private var selectedFilters3: Int?
    @State private var minValue: Int = 10
    @State private var maxValue: Int = 510
    @State private var RangeFilter: Bool = true
    @State private var RangeApply: Bool = true
    
    
    var body: some View {
        GeometryReader{ geometry in
            let safeAreaTop = geometry.safeAreaInsets.top
            NavigationView {
                ScrollViewReader(content: { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            
                            HeaderView(safeAreaTop)
                                .offset(y: -offsetY)
                                .zIndex(1)
                            
                            /// Scroll Content Goes Here
                            VStack{
                                Horizontal_ButtonView()
                                HStack {
                                    Text("Near By")
                                        .foregroundStyle(Color.black)
                                        .fontWeight(.semibold)
                                        .font(.system(size: 20))
                                    Spacer()
                                }.padding(.leading, 10).padding(.top, 10).background(Color(.systemGray6))
                                
                                PG_GridView2(useAllPGIDs: $RangeFilter,RefreshBTN: $RangeApply, selectedCity: $selectedCity, selectedFilter: $selectedFilters,
                                             selectedPGTypeIndex: $selectedFilters2, searchText: $searchText, selectedIndex2: $selectedFilters3, minValue: $minValue, maxValue: $maxValue)
                                
                                
                            }
                            .zIndex(0)
                        }.background(Color(.systemGray6))
                            .id("SCROLLVIEW")
                            .offset(coordinateSpace: .named("SCROLL")) { offset in
                                offsetY = offset
                                withAnimation(.none){
                                    showSearchBar = (-offset > 80) && showSearchBar
                                }
                                
                                if !isDragging && -offsetY < 80{
                                    if !reset{
                                        reset = true
                                        withAnimation(.easeInOut(duration: 0.25)){
                                            proxy.scrollTo("SCROLLVIEW", anchor: .top)
                                        }
                                    }
                                }else{
                                    reset = false
                                }
                            }
                    }
                    .background(Color(.systemGray6))
                    .onChange(of: isDragging) { newValue in
                        if !newValue && -offsetY < 80{
                            reset = true
                            withAnimation(.easeInOut(duration: 0.25)){
                                proxy.scrollTo("SCROLLVIEW", anchor: .top)
                            }
                        }
                    }
                    
                })
                .coordinateSpace(name: "SCROLL")
                .edgesIgnoringSafeArea(.top)
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .first:
                    FilterView(selectedIndex: $selectedFilters, selectedIndices_PG: $selectedFilters2, selectedIndex2: $selectedFilters3, selectedMinValue: $minValue, selectedMaxValue: $maxValue, RangeFilter: $RangeFilter, RangeApply: $RangeApply)
                        .presentationCornerRadius(21)
                        .presentationDetents([.large, .large])
                case .second:
                    CitySheet(selectedCity: $selectedCity)
                        .padding(.vertical)
                        .overlay {
                            GeometryReader { geometry in
                                Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                            }
                        }
                        .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                            sheetHeight = newHeight
                        }
                        .presentationDetents([.height(sheetHeight)]).presentationCornerRadius(21)
                }
            }
        }
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView(_ safeAreaTop: CGFloat)->some View{
        // Reduced Header Height will be 80
        let progress = -(offsetY / 80) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 80))
        VStack(spacing: 15){
            HStack(spacing: 15){
                
                Button {
                    activeSheet = .second
                } label: {
                    Rectangle()
                        .frame(width: 140,height: 30)
                        .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.white))
                        .overlay(
                            HStack {
                                Image(uiImage: UIImage(named: "location_icon")!) //Location icon
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(selectedCity ?? "Select City")   //Location Name
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 16))
                                Image(systemName: "chevron.down") //down icon
                                    .resizable()
                                    .foregroundStyle(Color.white)
                                    .imageScale(.small)
                                    .frame(width: 14, height: 9)
                            }
                        )
                }
                
                Spacer(minLength: 0)
                
                NavigationLink(destination: NotificationView()) {
                    Image(uiImage: UIImage(named: "bell_icon")!)
                        .resizable()
                        .frame(width: 30, height: 30)
                }.navigationBarBackButtonHidden()
                
                Button(action: {
                    print("** Selected Range: \(minValue) & \(maxValue)")
                    
                }) {
                    
                    Image(uiImage: UIImage(named: "message_icon")!)
                        .resizable()
                        .frame(width: 25, height: 22)
                    
                }.padding(.leading)
            }.opacity(showSearchBar ? 1 : 1 + progress)
            
            VStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 40)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            TextField("Search PGs", text: $searchText) // uncomment color Scheme
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
                    }.padding(.trailing, 10)
                    Spacer()
                    Rectangle()
                        .frame(width: 40,height: 40)
                        .cornerRadius(10)
                        .foregroundStyle(Color.white)
                        .overlay(
                            Image(uiImage: UIImage(named: "filter_icon")!)
                                .resizable()
                                .frame(width: 18, height: 18)
                        )
                        .onTapGesture {
                            activeSheet = .first
                        }
                    
                }.padding(.bottom, 5)
                HStack {
                    Text("Roommate Search")   //Location Name
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                    Image(systemName: "arrow.right") //down icon
                        .resizable()
                        .foregroundStyle(Color.white)
                        .imageScale(.large)
                        .frame(width: 14, height: 9)
                    Spacer()
                }
            }.padding(.bottom, 15)
                .padding(.top,10)
            // MARK: Moving Up When Scrolling Started
                .offset(y: progress * 65)
                .opacity(showSearchBar ? 0 : 1)
            
        }
        .animation(.easeInOut(duration: 0.2), value: showSearchBar)
        //.environment(\.colorScheme, .dark)
        .padding([.horizontal],15)
        .padding(.top,safeAreaTop + 10)
        .background {
            Rectangle()
                .fill(Color(UIColor(hex: "#7F32CD")))
                .cornerRadius(17)
            //.background(Color(UIColor(hex: "#7F32CD")))
                .padding(.bottom,-progress * 70)
        }
        
    }
}

struct CitySheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCity: String?
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 10) {
            
            HStack {
                Text("Select City").foregroundStyle(Color.black).fontWeight(.bold)
                    .font(.system(size: 18))
                Spacer()
                Image(systemName: "x.circle.fill")
                    .resizable().frame(width: 20, height: 20)
                    .foregroundColor(Color(UIColor(hex: "#7F32CD"))).bold()
                    .onTapGesture { dismiss() }
            }.padding(.bottom, 20)
            //1st
            VStack(alignment: .listRowSeparatorLeading, spacing: 20) {
                Text("All States").foregroundColor(Color(UIColor(hex: "#7F32CD"))).fontWeight(.bold)
                    .font(.system(size: 15))
                Button("All Cities") {
                    selectedCity = nil
                    dismiss()
                }.foregroundColor(.black).fontWeight(.medium).font(.system(size: 18))
            }
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray4))
                .frame(height: 2).padding(.vertical, 5).padding(.horizontal, 5)
            //2nd
            VStack(alignment: .listRowSeparatorLeading, spacing: 20) {
                Text("Telengana").foregroundColor(Color(UIColor(hex: "#7F32CD"))).fontWeight(.bold)
                    .font(.system(size: 15))
                Button("Hyderabad"){
                    selectedCity = "hyderabad"
                    dismiss()
                }.foregroundColor(.black).fontWeight(.medium).font(.system(size: 18))
            }
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray4))
                .frame(height: 2).padding(.vertical, 5).padding(.horizontal, 5)
            //3rd
            VStack(alignment: .listRowSeparatorLeading, spacing: 20) {
                Text("Tamil Nadu").foregroundColor(Color(UIColor(hex: "#7F32CD"))).fontWeight(.bold)
                    .font(.system(size: 15))
                Button("Chennai"){
                    selectedCity = "Chennai"
                    dismiss()
                }.foregroundColor(.black).fontWeight(.medium).font(.system(size: 18))
            }
            Rectangle()
                .foregroundStyle(Color(uiColor: .systemGray4))
                .frame(height: 2).padding(.vertical, 5).padding(.horizontal, 5)
            //4th
            VStack(alignment: .listRowSeparatorLeading, spacing: 20) {
                Text("Karnataka").foregroundColor(Color(UIColor(hex: "#7F32CD"))).fontWeight(.bold)
                    .font(.system(size: 15))
                Button("Banglore"){
                    selectedCity = "Banglore"
                    dismiss()
                }.foregroundColor(.black).fontWeight(.medium).font(.system(size: 18))
            }
        }.padding(.horizontal)
    }
}

// MARK: Offset Preference Key
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}



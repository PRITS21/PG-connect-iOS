//
//  garbage.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 06/03/24.
//

//
//import SwiftUI
//
//struct HomeSearchView : View {
//
//    @State var index = 0
//    @State var show = false
//
//    var body : some View{
//
//        VStack(spacing: 0){
//
//            appBar(index: self.$index,show: self.$show)
//
//            ZStack{
//
//                Chats(show: self.$show).opacity(self.index == 0 ? 1 : 0)
//
//            }
//
//
//        }.edgesIgnoringSafeArea(.top)
//    }
//}
//
//struct appBar : View {
//
//    @Binding var index : Int
//    @Binding var show : Bool
//
//    var body : some View{
//
//
//        VStack {
//
//            if self.show{
//
//                HStack{
//
//                    Rectangle()
//                        .frame(width: 140,height: 30)
//                        .foregroundColor(Color(UIColor(hex: "#7F32CD")))
//                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.white))
//                        .overlay(
//                            HStack {
//                                Image(uiImage: UIImage(named: "location_icon")!) //Location icon
//                                    .resizable()
//                                    .frame(width: 16, height: 16)
//                                Text("Hyderabad")   //Location Name
//                                    .foregroundStyle(Color.white)
//                                    .fontWeight(.semibold)
//                                    .font(.system(size: 16))
//                                Image(systemName: "chevron.down") //down icon
//                                    .resizable()
//                                    .foregroundStyle(Color.white)
//                                    .imageScale(.small)
//                                    .frame(width: 14, height: 9)
//                            }
//                        )
//
//                    Spacer(minLength: 0)
//
//                    Button(action: {
//
//                    }) {
//
//                        Image(uiImage: UIImage(named: "bell_icon")!)
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                    }
//
//                    Button(action: {
//
//                    }) {
//
//                        Image(uiImage: UIImage(named: "message_icon")!)
//                            .resizable()
//                            .frame(width: 25, height: 22)
//
//                    }.padding(.leading)
//                }.padding(.bottom, 10)
//            }
//
//            HStack {
//                ZStack {
//                    Rectangle()
//                        .frame(width: 300,height: 40)
//                        .cornerRadius(10)
//                        .foregroundStyle(Color.white)
//                    Image(uiImage: UIImage(named: "search_icon_orange")!)
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .offset(x: 120, y: 0) // Adjust the offset according to your requirement
//                }
//                Spacer()
//                Rectangle()
//                    .frame(width: 40,height: 40)
//                    .cornerRadius(10)
//                    .foregroundStyle(Color.white)
//                    .overlay(
//                        Image(uiImage: UIImage(named: "filter_icon")!)
//                            .resizable()
//                            .frame(width: 18, height: 18)
//                    )
//            }.padding(.bottom, 5)
//
//            HStack {
//                Text("Roommate Search")   //Location Name
//                    .foregroundStyle(Color.white)
//                    .fontWeight(.bold)
//                    .font(.system(size: 14))
//                Image(systemName: "arrow.right") //down icon
//                    .resizable()
//                    .foregroundStyle(Color.white)
//                    .imageScale(.large)
//                    .frame(width: 14, height: 9)
//                Spacer()
//            }.padding(.bottom, 20)
//
//
//        }.padding(.horizontal)
//            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
//            .background(Color(UIColor(hex: "#7F32CD")))
//            .cornerRadius(17)
//    }
//}
//
//struct Chats : View {
//
//    @Binding var show : Bool
//
//    var body : some View{
//
//        PGList()
//            .onAppear {
//
//                withAnimation {
//
//                    self.show = true
//                }
//
//            }
//            .onDisappear {
//
//                withAnimation {
//
//                    self.show = false
//                }
//            }
//    }
//}
//
//struct PGList: View {
//
//    var body: some View {
//        ScrollView {
//
//            Horizontal_ButtonView()
//            HStack {
//                Text("Near By")
//                    .foregroundStyle(Color.black)
//                    .fontWeight(.semibold)
//                    .font(.system(size: 20))
//                Spacer()
//            }.padding(.leading, 10).padding(.top, 15)
//            PG_GridView()
//        }
//    }
//}
//
//
//
//class Host : UIHostingController<ContentView>{
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
//}




//************************


////
////  HomeSearchView.swift
////  PG connect
////
////  Created by PRITAM SARKAR on 04/03/24.
////
//
//
//import SwiftUI
//
//struct HomeSearchView: View {
//    // MARK: Header Animation Properties
//    @State var offsetY: CGFloat = 0
//    @State var showSearchBar: Bool = false
//    // MARK: Universal Gesture State
//    @Environment(\.isDragging) var isDragging
//    @State var reset: Bool = false
//
//    @State var isHostelViewPresented = false
//    @State var selectedFitness: Fitness? // Track the selected fitness item
//
//    var body: some View {
//        GeometryReader{geometry in
//            let safeAreaTop = geometry.safeAreaInsets.top
//            ScrollViewReader(content: { proxy in
//                ScrollView(.vertical, showsIndicators: false) {
//                    VStack {
//                        if isHostelViewPresented {
//                            // Present Hostel View
//                            HostelView(fitness: selectedFitness!, isHostelViewPresented: $isHostelViewPresented)
//                                .edgesIgnoringSafeArea(.all)
//
//
//                        } else {
//                            // Show Header and Grid Views
//                            HeaderView(safeAreaTop)
//                                .offset(y: -offsetY)
//                                .zIndex(1)
//
//                            VStack {
//                                Horizontal_ButtonView()
//                                PG_GridView(selectedFitness: $selectedFitness, isHostelViewPresented: $isHostelViewPresented)
//                                    .frame(height: geometry.size.height)
//                                    .frame(height: geometry.size.height)
//                            }
//                            .zIndex(0)
//                        }
//                    }.background(Color(.systemGray6))
//                        .id("SCROLLVIEW")
//                        .offset(coordinateSpace: .named("SCROLL")) { offset in
//                            offsetY = offset
//                            withAnimation(.none){
//                                showSearchBar = (-offset > 80) && showSearchBar
//                            }
//
//                            if !isDragging && -offsetY < 80{
//                                if !reset{
//                                    reset = true
//                                    withAnimation(.easeInOut(duration: 0.25)){
//                                        proxy.scrollTo("SCROLLVIEW", anchor: .top)
//                                    }
//                                }
//                            }else{
//                                reset = false
//                            }
//                        }
//                }.background(Color(.systemGray6))
//                    .onChange(of: isDragging) { newValue in
//                        if !newValue && -offsetY < 80{
//                            reset = true
//                            withAnimation(.easeInOut(duration: 0.25)){
//                                proxy.scrollTo("SCROLLVIEW", anchor: .top)
//                            }
//                        }
//                    }
//            })
//            .coordinateSpace(name: "SCROLL")
//            .edgesIgnoringSafeArea(.top)
//        }
//    }
//
//    // MARK: Header View
//    @ViewBuilder
//    func HeaderView(_ safeAreaTop: CGFloat)->some View{
//        // Reduced Header Height will be 80
//        let progress = -(offsetY / 80) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 80))
//        VStack(spacing: 15){
//            HStack(spacing: 15){
//
//                Rectangle()
//                    .frame(width: 140,height: 30)
//                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
//                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.white))
//                    .overlay(
//                        HStack {
//                            Image(uiImage: UIImage(named: "location_icon")!) //Location icon
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                            Text("Hyderabad")   //Location Name
//                                .foregroundStyle(Color.white)
//                                .fontWeight(.semibold)
//                                .font(.system(size: 16))
//                            Image(systemName: "chevron.down") //down icon
//                                .resizable()
//                                .foregroundStyle(Color.white)
//                                .imageScale(.small)
//                                .frame(width: 14, height: 9)
//                        }
//                    )
//
//                Spacer(minLength: 0)
//
//                Button(action: {
//
//                }) {
//
//                    Image(uiImage: UIImage(named: "bell_icon")!)
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                }
//
//                Button(action: {
//
//                }) {
//
//                    Image(uiImage: UIImage(named: "message_icon")!)
//                        .resizable()
//                        .frame(width: 25, height: 22)
//
//                }.padding(.leading)
//            }.opacity(showSearchBar ? 1 : 1 + progress)
//
//            VStack {
//                HStack {
//                    ZStack {
//                        Rectangle()
//                            .frame(width: 300,height: 40)
//                            .cornerRadius(10)
//                            .foregroundStyle(Color.white)
//                        Image(uiImage: UIImage(named: "search_icon_orange")!)
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .offset(x: 120, y: 0) // Adjust the offset according to your requirement
//                    }
//                    Spacer()
//                    Rectangle()
//                        .frame(width: 40,height: 40)
//                        .cornerRadius(10)
//                        .foregroundStyle(Color.white)
//                        .overlay(
//                            Image(uiImage: UIImage(named: "filter_icon")!)
//                                .resizable()
//                                .frame(width: 18, height: 18)
//                        )
//                }.padding(.bottom, 5)
//                HStack {
//                    Text("Roommate Search")   //Location Name
//                        .foregroundStyle(Color.white)
//                        .fontWeight(.bold)
//                        .font(.system(size: 14))
//                    Image(systemName: "arrow.right") //down icon
//                        .resizable()
//                        .foregroundStyle(Color.white)
//                        .imageScale(.large)
//                        .frame(width: 14, height: 9)
//                    Spacer()
//                }
//            }.padding(.bottom, 15)
//                .padding(.top,10)
//            // MARK: Moving Up When Scrolling Started
//                .offset(y: progress * 65)
//                .opacity(showSearchBar ? 0 : 1)
//
//        }
//        .animation(.easeInOut(duration: 0.2), value: showSearchBar)
//        .environment(\.colorScheme, .dark)
//        .padding([.horizontal],15)
//        .padding(.top,safeAreaTop + 10)
//        .background {
//            Rectangle()
//                .fill(Color(UIColor(hex: "#7F32CD")))
//                .cornerRadius(17)
//            //.background(Color(UIColor(hex: "#7F32CD")))
//                .padding(.bottom,-progress * 70)
//        }
//    }
//}
//
//
//
//struct HeaderView: View {
//    var body : some View{
//
//        VStack {
//
//
//            HStack{
//
//                Rectangle()
//                    .frame(width: 140,height: 30)
//                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
//                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.white))
//                    .overlay(
//                        HStack {
//                            Image(uiImage: UIImage(named: "location_icon")!) //Location icon
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                            Text("Hyderabad")   //Location Name
//                                .foregroundStyle(Color.white)
//                                .fontWeight(.semibold)
//                                .font(.system(size: 16))
//                            Image(systemName: "chevron.down") //down icon
//                                .resizable()
//                                .foregroundStyle(Color.white)
//                                .imageScale(.small)
//                                .frame(width: 14, height: 9)
//                        }
//                    )
//
//                Spacer(minLength: 0)
//
//                Button(action: {
//
//                }) {
//
//                    Image(uiImage: UIImage(named: "bell_icon")!)
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                }
//
//                Button(action: {
//
//                }) {
//
//                    Image(uiImage: UIImage(named: "message_icon")!)
//                        .resizable()
//                        .frame(width: 25, height: 22)
//
//                }.padding(.leading)
//            }.padding(.bottom, 10)
//
//
//            HStack {
//                ZStack {
//                    Rectangle()
//                        .frame(width: 300,height: 40)
//                        .cornerRadius(10)
//                        .foregroundStyle(Color.white)
//                    Image(uiImage: UIImage(named: "search_icon_orange")!)
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .offset(x: 120, y: 0) // Adjust the offset according to your requirement
//                }
//                Spacer()
//                Rectangle()
//                    .frame(width: 40,height: 40)
//                    .cornerRadius(10)
//                    .foregroundStyle(Color.white)
//                    .overlay(
//                        Image(uiImage: UIImage(named: "filter_icon")!)
//                            .resizable()
//                            .frame(width: 18, height: 18)
//                    )
//            }.padding(.bottom, 5)
//
//            HStack {
//                Text("Roommate Search")   //Location Name
//                    .foregroundStyle(Color.white)
//                    .fontWeight(.bold)
//                    .font(.system(size: 14))
//                Image(systemName: "arrow.right") //down icon
//                    .resizable()
//                    .foregroundStyle(Color.white)
//                    .imageScale(.large)
//                    .frame(width: 14, height: 9)
//                Spacer()
//            }.padding(.bottom, 20)
//
//
//        }.padding(.horizontal)
//            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
//            .background(Color(UIColor(hex: "#7F32CD")))
//            .cornerRadius(17)
//    }
//
//}
//
//
//struct Horizontal_ButtonView: View {
//    @State private var selectedIndex: Int? = 0
//    let buttonNames = ["Near By", "Trending", "Corporate", "Value for Money"]
//    var body : some View{
//
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 15) {
//                ForEach(0..<buttonNames.count) { index in
//
//                    if index == 0 {
//                        HStack(spacing: 1){
//                            Image(uiImage: UIImage(named: "target_icon")!)
//                                .renderingMode(.template)
//                                .resizable()
//                                .imageScale(.large)
//                                .frame(width: 20, height: 20)
//                                .foregroundColor(self.selectedIndex == 0 ? .white : Color(UIColor(hex: "#F25621")))
//
//                            Button(action: {
//                                self.selectedIndex = 0
//                            }) {
//                                Text(buttonNames[index])
//                                    .foregroundColor(self.selectedIndex == 0 ? .white : Color(UIColor(hex: "#F25621")))
//
//                            }
//                        }
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 8)
//                        .background(self.selectedIndex == 0 ? Color(UIColor(hex: "#F25621")) : Color.white)
//                        .cornerRadius(10)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(UIColor(hex: "#F25621"))))
//                    } else {
//
//                        Button(action: {
//                            self.selectedIndex = index
//                        }) {
//                            Text(buttonNames[index])
//                                .foregroundColor(self.selectedIndex == index ? .white : Color(UIColor(hex: "#F25621")))
//                                .padding(.horizontal, 12)
//                                .padding(.vertical, 8)
//                                .background(self.selectedIndex == index ? Color(UIColor(hex: "#F25621")) : Color.white)
//                                .cornerRadius(10)
//                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(UIColor(hex: "#F25621"))))
//
//                        }
//                    }
//
//                }
//            }.padding(.leading, 10)
//        }
//        .padding(.top, 10)
//        .background(Color(.systemGray6))
//    }
//
//}
//
//
//struct PG_GridView : View {
//    @Binding var selectedFitness: Fitness?
//    @Binding var isHostelViewPresented: Bool
//    @State var index = 0
//
//    var body: some View{
//
//        GeometryReader { geometry in
//            GridView(fitness_Data: fit_Data, availableHeight: geometry.size.height, selectedFitness: $selectedFitness, isHostelViewPresented: $isHostelViewPresented) // Pass the binding
//        }
//    }
//}
//
//// Grid View....
//
//struct GridView : View {
//
//    var fitness_Data : [Fitness]
//    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
//    var availableHeight: CGFloat
//    @State private var isShowingHostelView = false
//    @Binding var selectedFitness: Fitness?
//    @Binding var isHostelViewPresented: Bool
//
//    var body: some View{
//
//        NavigationView {
//            ScrollView {
//                LazyVGrid(columns: columns,spacing: 10){
//
//                    ForEach(fitness_Data){ fitness in
//                        NavigationLink(destination: EmptyView()) {
//                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
//
//                                VStack {
//
//                                    Image(fitness.image)
//                                        .resizable()
//                                        .frame(width: .infinity, height: 150)
//
//
//                                    VStack(spacing: 0) {
//                                        // 1st row
//                                        HStack {
//                                            Text(fitness.title)
//                                                .fontWeight(.medium)
//                                                .font(.system(size: 14))
//                                            Spacer()
//                                            HStack(spacing: 15){
//                                                Image(uiImage: UIImage(named: "boys_logo")!)
//                                                    .imageScale(.large)
//                                                    .frame(width: 11, height: 22)
//                                                Image(uiImage: UIImage(named: "girls_logo")!)
//                                                    .frame(width: 11, height: 22)
//                                            }
//                                        }
//                                        // 2nd row
//                                        HStack {
//                                            HStack(spacing: 2) {
//                                                Image(uiImage: UIImage(named: "location_icon_gray")!)
//                                                    .frame(width: 10, height: 10)
//                                                Text(fitness.location)
//                                                    .font(.system(size: 10))
//                                            }
//                                            Spacer()
//                                        }.padding(.bottom, 10)
//
//                                        HStack {
//                                            HStack(spacing: 2) {
//                                                Text("Avialable: ")
//                                                    .fontWeight(.semibold)
//                                                    .font(.system(size: 10))
//                                                Text(fitness.avilable_for)
//                                                    .font(.system(size: 10))
//                                            }
//                                            Spacer()
//                                        }.padding(.bottom, 7)
//
//                                        HStack {
//                                            HStack(spacing: 2) {
//                                                Text("Starts from: ")
//                                                    .fontWeight(.semibold)
//                                                    .font(.system(size: 10))
//                                                Text(fitness.price)
//                                                    .font(.system(size: 10))
//                                            }
//                                            Spacer()
//                                        }.padding(.bottom, 10)
//                                    }.padding(.horizontal)
//                                }
//                                .background(Color.white)
//                                .cornerRadius(10)
//                                .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 4)
//                                .onTapGesture {
//                                    selectedFitness = fitness
//                                    isHostelViewPresented = true
//
//                                }
//                            }
//                        }
//                        .buttonStyle(PlainButtonStyle())
//
//
//                    }
//                }
//                .frame(minHeight: availableHeight)
//                .padding(.horizontal, 10)
//                .padding(.top,5)
//            }.navigationBarHidden(true)
//        }.navigationBarHidden(true)
//    }
//}
//
//// DashBoard Grid Model Data...
//
//struct Fitness : Identifiable {
//
//    var id : Int
//    var title : String
//    var location : String
//    var image : String
//    var price: String
//    var avilable_for : String
//}
//
//// Daily Data...
//
//var fit_Data = [
//
//    Fitness(id: 0, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 1, title: "two hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 2, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 3, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 4, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 5, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 6, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//    Fitness(id: 7, title: "One hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily"),
//
//]
//
//
//struct HostelView: View {
//    var fitness: Fitness
//    @Binding var isHostelViewPresented: Bool // Binding to control presentation
//
//    var body: some View {
//
//        VStack {
//
//            ZStack(alignment: .center) {
//                Button {
//                    isHostelViewPresented = false
//                } label: {
//                    HStack {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.black)
//                            .imageScale(.large)
//                            .bold()
//                            .padding(.leading, 15)
//                        Spacer()
//                    }
//                }
//                Text("Sign Up")
//                    .multilineTextAlignment(.center)
//                    .font(.system(size: 20))
//                    .fontWeight(.medium)
//                    .foregroundStyle(Color.black)
//
//            }
//
//
//
//            Text(fitness.title)
//                .font(.system(size: 14))
//        }
//        .padding(.top, 100)
//        .frame(height: 500)
//    }
//}
//
//
//let sampleFitness = Fitness(id: 0, title: "One Hostel", location: "Hyderabad", image: "room_image", price: "₹2500", avilable_for: "Daily")
//
//
//// MARK: Offset Preference Key
//struct OffsetKey: PreferenceKey{
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//struct HomeSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeSearchView()
//    }
//}
//
//
//

//struct ScheduleView: View {
//
//    @Binding var isShowing: Bool
//    @State private var curHeight: CGFloat = 400
//
//    let minHeight: CGFloat = 400
//    let maxHeight: CGFloat = 700
//
//    var body: some View {
//
//        if isShowing{
//            ZStack(alignment: .bottom){
//                Color.black
//                    .opacity (0.3)
//                    .ignoresSafeArea ()
//                    .onTapGesture {
//                        isShowing = false
//                    }
//                mainView
//                    .transition(.move(edge: .bottom))
//                    .gesture(
//                                            DragGesture()
//                                                .onChanged { value in
//                                                    if value.translation.height > 0 {
//                                                        curHeight = max(minHeight, curHeight - value.translation.height)
//                                                    }
//                                                }
//                                                .onEnded { value in
//                                                    if value.translation.height > 100 {
//                                                        isShowing = false
//                                                    } else {
//                                                        withAnimation {
//                                                            curHeight = maxHeight
//                                                        }
//                                                    }
//                                                }
//                                        )
//
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//            .ignoresSafeArea()
//            .animation(.easeInOut)
//        }
//    }
//
//    var mainView: some View{
//        VStack{
//            ZStack{
//                Capsule ()
//                    .frame(width: 40,
//                           height: 6)
//            }
//            .frame (height: 40)
//            .frame (maxWidth: .infinity)
//            .background (Color.white.opacity (0.0001))
//            //.gesture(dragGesture)
//
//            ZStack{
//                VStack{
//                    Text("is the most precious time.")
//                        .font(.system(size: 20, weight: .regular))
//                        .multilineTextAlignment(.center)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding (.bottom, 10)
//                    Text ("AYHAN" )
//                        .font(.system(size: 20, weight: .bold) )
//                }
//                .padding (.horizontal, 30)
//            }
//            .frame (maxHeight: .infinity)
//            .padding(.bottom, 35)
//        }
//        .frame (height: curHeight)
//        .frame (maxWidth: .infinity)
//        .background (
//            ZStack{
//                RoundedRectangle (cornerRadius: 30)
//                Rectangle()
//                    .frame (height: curHeight / 2)
//            }.foregroundColor(.white))
//
//    }
//
//}

//import SwiftUI
//
//struct DropdownOption: Hashable {
//    let key: String
//    let value: String
//
//    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
//        return lhs.key == rhs.key
//    }
//}
//
//struct DropdownRow: View {
//    var option: DropdownOption
//    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
//
//    var body: some View {
//        Button(action: {
//            if let onOptionSelected = self.onOptionSelected {
//                onOptionSelected(self.option)
//            }
//        }) {
//            HStack {
//                Text(self.option.value)
//                    .font(.system(size: 14))
//                    .foregroundColor(Color.black)
//                Spacer()
//            }
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 5)
//    }
//}
//
//struct Dropdown: View {
//    var options: [DropdownOption]
//    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 0) {
//                ForEach(self.options, id: \.self) { option in
//                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
//                }
//            }
//        }
//        .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
//        .padding(.vertical, 5)
//        .background(Color.white)
//        .cornerRadius(5)
//        .overlay(
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(Color.gray, lineWidth: 1)
//        )
//    }
//}
//
//struct DropdownSelector: View {
//    @State private var shouldShowDropdown = false
//    @State private var selectedOption: DropdownOption? = nil
//    var placeholder: String
//    var options: [DropdownOption]
//    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
//    private let buttonHeight: CGFloat = 45
//
//    var body: some View {
//        Button(action: {
//            self.shouldShowDropdown.toggle()
//        }) {
//            HStack {
//                Text(selectedOption == nil ? placeholder : selectedOption!.value)
//                    .font(.system(size: 14))
//                    .foregroundColor(selectedOption == nil ? Color.gray: Color.black)
//
//                Spacer()
//
//                Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
//                    .resizable()
//                    .frame(width: 9, height: 5)
//                    .font(Font.system(size: 9, weight: .medium))
//                    .foregroundColor(Color.black)
//            }
//        }
//        .padding(.horizontal)
//        .cornerRadius(5)
//        .frame(width: .infinity, height: self.buttonHeight)
//        .overlay(
//            RoundedRectangle(cornerRadius: 5)
//                .stroke(Color.gray, lineWidth: 1)
//        )
//        .overlay(
//            VStack {
//                if self.shouldShowDropdown {
//                    Spacer(minLength: buttonHeight + 10)
//                    Dropdown(options: self.options, onOptionSelected: { option in
//                        shouldShowDropdown = false
//                        selectedOption = option
//                        self.onOptionSelected?(option)
//                    })
//                }
//            }, alignment: .topLeading
//        )
//        .background(
//            RoundedRectangle(cornerRadius: 5).fill(Color.white)
//        )
//    }
//}
//
//struct DropdownSelector_Previews: PreviewProvider {
//    static var uniqueKey: String {
//        UUID().uuidString
//    }
//
//    static let options: [DropdownOption] = [
//        DropdownOption(key: uniqueKey, value: "Sunday"),
//        DropdownOption(key: uniqueKey, value: "Monday"),
//        DropdownOption(key: uniqueKey, value: "Tuesday"),
//        DropdownOption(key: uniqueKey, value: "Wednesday"),
//        DropdownOption(key: uniqueKey, value: "Thursday"),
//        DropdownOption(key: uniqueKey, value: "Friday"),
//        DropdownOption(key: uniqueKey, value: "Saturday")
//    ]
//
//
//    static var previews: some View {
//        Group {
//            DropdownSelector(
//                placeholder: "Day of the week",
//                options: options,
//                onOptionSelected: { option in
//                    print(option)
//            })
//            .padding(.horizontal)
//        }
//    }
//}
//

//import SwiftUI
//
//struct ContentView: View {
//
//    @State var selection1: String? = nil
//
//    var body: some View {
//        VStack {
//                    Text("Some content here")
//                    // Use dropDownPicker modifier here
//                    Text("More content here")
//                }
//                .dropDownPicker(selection: $selection1, options: ["Option 1", "Option 2", "Option 3"])
//    }
//}
//
//struct AnotherView: View {
//    @State var selection2: String? = nil
//
//    var body: some View {
//        // Use dropDownPicker modifier here
//        Text("Some other content")
//            .dropDownPicker(selection: $selection2, options: ["Option A", "Option B", "Option C"])
//    }
//}
//enum DropDownPickerState {
//    case top
//    case bottom
//}
//
//struct DropDownPicker: View {
//
//    @Binding var selection: String?
//    var state: DropDownPickerState = .bottom
//    var options: [String]
//    var maxWidth: CGFloat = 180
//
//    @State var showDropdown = false
//
//    @SceneStorage("drop_down_zindex") private var index = 1000.0
//    @State var zindex = 1000.0
//
//    var body: some View {
//        GeometryReader {
//            let size = $0.size
//
//            VStack(spacing: 0) {
//
//
//                if state == .top && showDropdown {
//                    OptionsView()
//                }
//
//                HStack {
//                    Text(selection == nil ? "Select" : selection!)
//                        .foregroundColor(selection != nil ? .black : .gray)
//
//
//                    Spacer(minLength: 0)
//
//                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
//                        .font(.title3)
//                        .foregroundColor(.gray)
//                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
//                }
//                .padding(.horizontal, 15)
//                .frame(width: 180, height: 50)
//                .background(.white)
//                .contentShape(.rect)
//                .onTapGesture {
//                    index += 1
//                    zindex = index
//                    withAnimation(.snappy) {
//                        showDropdown.toggle()
//                    }
//                }
//                .zIndex(10)
//
//                if state == .bottom && showDropdown {
//                    OptionsView()
//                }
//            }
//            .clipped()
//            .background(.white)
//            .cornerRadius(10)
//            .overlay {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(.gray)
//            }
//            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
//
//        }
//        .frame(width: maxWidth, height: 50)
//        .zIndex(zindex)
//    }
//
//
//    func OptionsView() -> some View {
//        VStack(spacing: 0) {
//            ForEach(options, id: \.self) { option in
//                HStack {
//                    Text(option)
//                    Spacer()
//                    Image(systemName: "checkmark")
//                        .opacity(selection == option ? 1 : 0)
//                }
//                .foregroundStyle(selection == option ? Color.primary : Color.gray)
//                .animation(.none, value: selection)
//                .frame(height: 40)
//                .contentShape(.rect)
//                .padding(.horizontal, 15)
//                .onTapGesture {
//                    withAnimation(.snappy) {
//                        selection = option
//                        showDropdown.toggle()
//                    }
//                }
//            }
//        }
//        .transition(.move(edge: state == .top ? .bottom : .top))
//        .zIndex(1)
//    }
//}
//
//struct DropDownPickerModifier: ViewModifier {
//    @Binding var selection: String?
//    var options: [String]
//    var state: DropDownPickerState = .bottom
//    var maxWidth: CGFloat = 180
//
//    func body(content: Content) -> some View {
//        content.overlay(
//            DropDownPicker(selection: $selection, state: state, options: options, maxWidth: maxWidth)
//        )
//    }
//}
//
//extension View {
//    func dropDownPicker(selection: Binding<String?>, options: [String], state: DropDownPickerState = .bottom, maxWidth: CGFloat = 180) -> some View {
//        self.modifier(DropDownPickerModifier(selection: selection, options: options, state: state, maxWidth: maxWidth))
//    }
//}
//
//struct ContentView2_Previews: PreviewProvider {
//    static var previews: some View {
//        AnotherView()
//    }
//}

//ZStack {
//    Rectangle()
//        .frame(width: .infinity, height: 50)
//        .foregroundColor(.white)
//        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
//
//
//        .onTapGesture {
//            self.isFirstRectangleVisible = false
//            self.isFirstRectangleVisible2 = true
//        }
//


//}

//
//import SwiftUI
//
//struct TimePickerView: View {
//    @State private var selectedTime = Date()
//    @State private var isTimePickerPresented = false
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                isTimePickerPresented.toggle()
//            }) {
//                Text("Select Time")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//
//            if isTimePickerPresented {
//                VStack {
//                    Spacer()
//                    DatePicker("Select a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
//                        .datePickerStyle(WheelDatePickerStyle())
//                        .labelsHidden()
//                        .padding()
//
//                    Button(action: {
//                        isTimePickerPresented.toggle()
//                    }) {
//                        Text("Done")
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//                }
//                .background(Color.white)
//                .cornerRadius(20)
//                .shadow(radius: 5)
//                .padding()
//            }
//        }
//    }
//}
//
//struct TimePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimePickerView()
//    }
//}
//

//func signIn() {
//        // Check if email and password are not empty
//        guard !email.isEmpty && !password.isEmpty else {
//            // Display error message to user indicating missing fields
//            errorMessage = "Please enter both email and password"
//            return
//        }
//
//        // Prepare your API request
//        let url = URL(string: "https://production.pgplanner.in/api/login/user")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Prepare request body
//        let requestBody: [String: Any] = ["email": email, "password": password]
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
//            errorMessage = "Failed to serialize request body"
//            return
//        }
//        request.httpBody = jsonData
//
//        // Make the request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // Handle response
//            if let data = data {
//                // Parse response data
//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                    // Authentication successful
//                    if let token = parseBearerToken(from: data) {
//                        // Save the token for later use
//                        UserDefaults.standard.set(token, forKey: "bearerToken")
//
//                        // Proceed with uploading device token
//                        uploadDeviceToken(token: token)
//
//                        // Proceed with further actions or navigation
//                        DispatchQueue.main.async {
//                            // Navigate to the next screen or update UI
//                        }
//                    } else {
//                        errorMessage = "Unable to parse Bearer Token"
//                    }
//                } else {
//                    // Authentication failed
//                    // Display error message to user
//                    if let errorMessage = String(data: data, encoding: .utf8) {
//                        self.errorMessage = errorMessage
//                    } else {
//                        self.errorMessage = "Unable to parse error message"
//                    }
//                }
//            } else if let error = error {
//                // Handle error
//                self.errorMessage = error.localizedDescription
//            }
//        }.resume()
//    }
//
//private func parseBearerToken(from data: Data) -> String? {
//    do {
//        // Try to parse JSON response
//        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//           let token = json["token"] as? String {
//            return token
//        }
//
//        // Try to parse plain text response
//        if let token = String(data: data, encoding: .utf8) {
//            return token
//        }
//
//        print("Error: Unable to parse Bearer Token from response")
//        return nil
//    } catch {
//        print("Error: Unable to parse Bearer Token data - \(error)")
//        return nil
//    }
//}
//
//
//    func uploadDeviceToken(token: String) {
//        // Prepare your API request to upload device token
//        let url = URL(string: "https://production.pgplanner.in/api/login/userdevicetoken")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        // Add Bearer Token to request headers
//        let bearerToken = token
//        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
//
//        // Prepare request body
//        let requestBody = "devicetoken=\(token)"
//        request.httpBody = requestBody.data(using: .utf8)
//
//        // Make the request to upload device token
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // Handle response
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode == 200 {
//                    print("Device token uploaded successfully")
//                } else {
//                    print("Failed to upload device token. Status code: \(httpResponse.statusCode)")
//                }
//            } else if let error = error {
//                print("Error uploading device token: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//
//// Function to retrieve device token
//func getDeviceToken() -> String? {
//    guard let deviceToken = UIDevice.current.identifierForVendor?.uuidString else {
//        return nil
//    }
//    return deviceToken
//}
//
//


//func signIn() {
//        // Check if email and password are not empty
//        guard !email.isEmpty && !password.isEmpty else {
//            // Display error message to user indicating missing fields
//            print("Error: Please enter both email and password")
//            errorMessage = "Please fill in all fields correctly"
//            return
//        }
//
//        // Prepare your API request
//        let url = URL(string: "https://production.pgplanner.in/api/login/user")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Prepare request body
//        let requestBody: [String: Any] = ["email": email, "password": password]
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
//            print("Error: Failed to serialize request body")
//            return
//        }
//        request.httpBody = jsonData
//
//        // Make the request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // Handle response
//            if let data = data {
//                // Parse response data
//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                    // Authentication successful
//                    DispatchQueue.main.async {
//                        // Retrieve device token
//                        guard let deviceToken = getDeviceToken() else {
//                            print("Error: Unable to retrieve device token")
//                            return
//                        }
//
//                        // Upload device token
//                        uploadDeviceToken(token: deviceToken)
//
//                        // Update UI or navigate to the next screen
//                        if let window = UIApplication.shared.windows.first {
//                            window.rootViewController = UIHostingController(rootView: BottomTabView())
//                            window.makeKeyAndVisible()
//                        }
//                    }
//                } else {
//                    // Authentication failed
//                    // Display error message to user
//                    if let errorMessage = String(data: data, encoding: .utf8) {
//                        DispatchQueue.main.async {
//                            self.errorMessage = errorMessage
//                            print("Error: \(errorMessage)")
//                        }
//                    } else {
//                        DispatchQueue.main.async {
//                            self.errorMessage = "Unable to parse error message"
//                            print("Error: Unable to parse error message")
//                        }
//                    }
//                }
//            } else if let error = error {
//                // Handle error
//                DispatchQueue.main.async {
//                    self.errorMessage = error.localizedDescription
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
//        }.resume()
//    }
//
//    // Function to retrieve device token
//    func getDeviceToken() -> String? {
//        guard let deviceToken = UIDevice.current.identifierForVendor?.uuidString else {
//            return nil
//        }
//        return deviceToken
//    }
//
//    // Function to upload device token
//    func uploadDeviceToken(token: String) {
//        // Prepare your API request
//        let url = URL(string: "https://production.pgplanner.in/api/login/userdevicetoken")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        // Prepare request body
//        let requestBody = "devicetoken=\(token)"
//        print("******\(requestBody)")
//        request.httpBody = requestBody.data(using: .utf8)
//
//        // Make the request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // Handle response
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode == 200 {
//                    print("Device token uploaded successfully")
//                } else {
//                    print("Failed to upload device token. Status code: \(httpResponse.statusCode)")
//                }
//            } else if let error = error {
//                print("Error uploading device token: \(error.localizedDescription)")
//            }
//        }.resume()
//    }

//import SwiftUI
//class PgViewModel: ObservableObject {
//    @Published var pgData: [PgData] = []
//
//    func fetchData() {
//        guard let url = URL(string: "https://production.pgplanner.in/api/user/getpgsforuser") else {
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        // Fetch bearer token from AuthService
//        if let bearerToken = AuthService.shared.getToken() {
//            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
//        } else {
//            print("Bearer token not available")
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            // Convert data to string for printing
//            if let dataString = String(data: data, encoding: .utf8) {
//                // Print the response data
//                print("Response Data:")
//                print(dataString)
//            }
//
//            do {
//                let decodedData = try JSONDecoder().decode([PgData].self, from: data)
//                DispatchQueue.main.async {
//                    self.pgData = decodedData
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//}
//
//struct PgData: Decodable {
//    let City: String
//    let type: String
//    // Define other properties according to your API response
//}
//
//struct ContentView5: View {
//    @StateObject var viewModel = PgViewModel()
//
//    var body: some View {
//        VStack {
//            Button("Fetch PG Data") {
//                viewModel.fetchData()
//            }
//        }
//        .onReceive(viewModel.$pgData) { data in
//            if !data.isEmpty {
//                printPgData(data)
//            }
//        }
//    }
//
//    private func printPgData(_ pgData: [PgData]) {
//        for pg in pgData {
//            print("PG city: \(pg.City)")
//            print("PG type: \(pg.type)")
//            // Print other properties as needed
//        }
//    }
//}

import SwiftUI

//import SwiftUI
//
//struct ContentView: View {
//    @State private var userProfile: UserProfileResponse?
//    
//    var body: some View {
//        VStack {
//            if let userProfile = userProfile {
//                Text("Profile ID: \(userProfile.profileid)")
//                Text("Name: \(userProfile.name)")
//                Text("Email: \(userProfile.email)")
//                Text("Phone: \(userProfile.phone)")
//                // Add more properties as needed
//            } else {
//                Text("No user profile data available")
//            }
//            
//            Button("Fetch Data") {
//                
//            }
//            .padding()
//        }
//    }
//    
//    
//}

// Buttons
//if !buttonNames.isEmpty  {
//    VStack {
//        ForEach(0..<buttonNames.count / buttonsPerRow + 1) { rowIndex in
//            HStack(spacing: 14) {
//                ForEach(0..<min(buttonsPerRow, buttonNames.count - rowIndex * buttonsPerRow)) { columnIndex in
//                    let index = rowIndex * buttonsPerRow + columnIndex
//                    
//                    Text(buttonNames[index])
//                        .frame(width: .infinity, height: 8)
//                        .font(.system(size: 10))
//                        .foregroundColor(.black)
//                        .padding(.horizontal, 6)
//                        .padding(.vertical, 6)
//                        .background(Color.white)
//                        .cornerRadius(15)
//                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).foregroundColor(.gray))
//                    
//                }
//                Spacer()
//            }
//        }
//    }.padding(.top, 10).padding(.bottom, 20)
//}
//

//let userProfile = UserProfile2(
//    
//    officehoursstart: dateFormatter.string(from: startTime),
//    officehoursend: dateFormatter.string(from: endTime),
//    
//    shift: selectedPreferences.joined(separator: ", "),
//    
//    workingdays: WorkingDays_user(
//        monday: selectedIndices_days.contains(0),
//        tuesday: selectedIndices_days.contains(1),
//        wednesday: selectedIndices_days.contains(2),
//        thursday: selectedIndices_days.contains(3),
//        friday: selectedIndices_days.contains(4),
//        saturday: selectedIndices_days.contains(5),
//        sunday: selectedIndices_days.contains(6)
//    )
//)
//AuthService.UploadUserData(userProfile: userProfile) { result in
//    switch result {
//    case .success(let data):
//        if let responseData = data {
//            // Upload successful, handle response data if needed
//            print("Upload Days successful")
//        } else {
//            // Upload successful, but no response data
//            print("Upload Days successful, but no response data")
//        }
//    case .failure(let error):
//        // Upload failed, handle the error
//        print("Upload failed with error: \(error.localizedDescription)")
//    }
//}

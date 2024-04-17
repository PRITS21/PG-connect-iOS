//
//  PG_GridView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 05/03/24.
//
import SwiftUI
import URLImage

var imageCache = NSCache<NSString, UIImage>()

struct PG_GridView: View {
    @ObservedObject var viewModel = AuthService.shared
    @Binding var selectedCity: String?
    @Binding var selectedFilter: Int?
    @Binding var selectedPGTypeIndex: Int?
    @Binding var searchText: String
    @Binding var selectedIndex2: Int?
    
    var filteredPGDataCombined: [PGData] {
        // Start with all PG data
        var filteredData = viewModel.pgData
        
        // Filter based on selected city
        if let selectedCity = selectedCity {
            filteredData = filteredData.filter { $0.city == selectedCity }
        }
        
        // Filter based on selected availability (Monthly, Daily, Hourly)
        if let selectedFilter = selectedFilter {
            switch selectedFilter {
            case 0: // Monthly
                filteredData = filteredData.filter { $0.roomavailability.monthly }
            case 1: // Daily
                filteredData = filteredData.filter { $0.roomavailability.daily }
            case 2: // Hourly
                filteredData = filteredData.filter { $0.roomavailability.hourly }
            default:
                break
            }
        }
        
        // Define the PG types array
        let pgTypes = ["male", "female", "coliving"]
        
        // Filter based on selected PG type (male, female, coliving)
        if let selectedPGTypeIndex = selectedPGTypeIndex {
            let selectedPGType = pgTypes[selectedPGTypeIndex]
            filteredData = filteredData.filter { $0.pgtype == selectedPGType }
        }
        
        // Filter based on search text
            if !searchText.isEmpty {
                filteredData = filteredData.filter { $0.pgname.lowercased().contains(searchText.lowercased()) }
            }
        
        // Define the PG Sharing Options
        let SharingType = ["1 Share", "2 Share", "3 Share", "4 Share", "5+ Share"]

        // Filter based on selected sharing type index
        if let selectedIndex2 = selectedIndex2 {
            let sharingType = SharingType[selectedIndex2]
            // Filter the data based on the selected sharing type
            filteredData = filteredData.filter { pgData in
                // Assuming pgData.roomsharingoptions is an array of Bool values indicating the availability of sharing options
                switch sharingType {
                case "1 Share":
                    return pgData.roomsharingoptions.one
                case "2 Share":
                    return pgData.roomsharingoptions.two
                case "3 Share":
                    return pgData.roomsharingoptions.three
                case "4 Share":
                    return pgData.roomsharingoptions.four
                case "5+ Share":
                    return pgData.roomsharingoptions.five || pgData.roomsharingoptions.six || pgData.roomsharingoptions.seven || pgData.roomsharingoptions.eight || pgData.roomsharingoptions.nine || pgData.roomsharingoptions.ten
                default:
                    return false
                }
            }
        }

        
        return filteredData
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(filteredPGDataCombined) { pgData in
                    NavigationLink(destination: HostelView(selectedPGData: pgData)){
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            VStack {
                                
                                // Display the RemoteImage if available
                                if let cachedImage = imageCache.object(forKey: pgData.images.first?.img as! NSString) {
                                    Image(uiImage: cachedImage)
                                        .resizable()
                                        .frame(width: .infinity, height: 150)
                                } else {
                                    AsyncImageWithCache(urlString: pgData.images.first?.img ?? "")
                                        .frame(height: 150)
                                }
                                /* Display the RemoteImage if available
                                if let firstImage = pgData.images.first, let url = URL(string: firstImage.img) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: .infinity, height: 150)
                                        case .failure:
                                            // Placeholder if image loading fails
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                        case .empty:
                                            // Placeholder while loading
                                            ProgressView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(height: 150)
                                }*/
                                VStack(spacing: 0) {
                                    HStack {
                                        
                                        Text(pgData.pgname)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 14))
                                        Spacer()
                                    }
                                    HStack {
                                        HStack(spacing: 2) {
                                            Image(uiImage: UIImage(named: "location_icon_gray")!)
                                                .frame(width: 14, height: 14)
                                            Text(pgData.area)
                                                .font(.system(size: 10))
                                        }
                                        Spacer()
                                    }.padding(.bottom, 10)
                                    HStack {
                                        HStack(spacing: 2) {
                                            Text("Avialable: ")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 10))
                                            Text(pgData.roomavailability.availableOptions.joined(separator: " / "))
                                                .font(.system(size: 10))
                                        }
                                        Spacer()
                                    }.padding(.bottom, 7)
                                    HStack {
                                        HStack(spacing: 2) {
                                            Text("Starts from: ")
                                                .fontWeight(.semibold)
                                                .font(.system(size: 10))
                                            Text("₹\(pgData.startingfrom)")
                                                .font(.system(size: 10))
                                        }
                                        Spacer()
                                    }.padding(.bottom, 10)
                                }.padding(.horizontal)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 4)
                           
                        }
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 5)
        }
        .onAppear {
            viewModel.fetchPGData()
        }
        
    }
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
}

//MARK: AsyncImageWithCache to download and cache images asynchronously
struct AsyncImageWithCache: View {
    let urlString: String
    @State private var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .frame(width: .infinity, height: 150)
        } else {
            ProgressView()
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let loadedImage = UIImage(data: data) else { return }
            imageCache.setObject(loadedImage, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }.resume()
    }
}

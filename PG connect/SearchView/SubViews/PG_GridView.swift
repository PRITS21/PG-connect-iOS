//
//  PG_GridView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 05/03/24.
//
import SwiftUI
import URLImage

var imageCache = NSCache<NSString, UIImage>()

struct PG_GridView2: View {
    @State private var rentRangeChanged = false
    @Binding var useAllPGIDs: Bool
    @Binding var RefreshBTN: Bool
    @State private var pgIDsInRentRange: [String] = []
    @State private var pgDetails: PGDetailsResponse?
    @ObservedObject var viewModel = AuthService.shared
    @Binding var selectedCity: String?
    @Binding var selectedFilter: Int?
    @Binding var selectedPGTypeIndex: Int?
    @Binding var searchText: String
    @Binding var selectedIndex2: Int?
    @Binding var minValue: Int
    @Binding var maxValue: Int
    @State private var minValueText = ""
    @State private var maxValueText = ""
    
    private func hasSharingRentInRange(rentDetails: RentDetails, range: ClosedRange<Int>) -> Bool {
        let allSharingRentValues = [rentDetails.onesharing, rentDetails.twosharing, rentDetails.threesharing, rentDetails.foursharing, rentDetails.fivesharing, rentDetails.sixsharing, rentDetails.sevensharing, rentDetails.eightsharing, rentDetails.ninesharing, rentDetails.tensharing]
        
        for sharingRentValue in allSharingRentValues {
            if let rent = sharingRentValue, range.contains(rent) {
                return true
            }
        }
        return false
    }
    
    private func checkSharingRentInRange(rentDetails: RentType, pgData: PGDetailsData){
        
        let acSharingRentInRange = hasSharingRentInRange(rentDetails: rentDetails.ac, range: minValue...maxValue)
        let nonACSharingRentInRange = hasSharingRentInRange(rentDetails: rentDetails.nonac, range: minValue...maxValue)
        
        if acSharingRentInRange || nonACSharingRentInRange {
            
            print("At least one sharing rent value falls within the range. \(pgData.pgname)")
            pgIDsInRentRange.append(pgData._id)
        } else {
            print("No Range")
        }
    }
    
    var filteredPGDataCombined: [PGData] {
        // Start with all PG data
        var filteredData = viewModel.pgData
        
        // Print all PG IDs
        let allPGIDs = filteredData.map { $0._id }
        
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
        
        
        let selectedPGIDs = useAllPGIDs ? allPGIDs : pgIDsInRentRange
        
        // Filter PG data based on selected PG IDs
        let filteredByIDs = filteredData.filter { selectedPGIDs.contains($0._id) }
        
        return filteredByIDs
        //return filteredData
    }
    
    var body: some View {
        ScrollView {
            if filteredPGDataCombined.isEmpty {
                Text("No PGs available")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding()
            } else {
                
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
        }
        .onAppear {
            viewModel.fetchPGData()
        }
        .onChange(of: RefreshBTN) { _ in
            
            updatePGIDsInRentRange()
        }
        
    }
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    func updatePGIDsInRentRange() {
        self.pgIDsInRentRange.removeAll()
        for pgData in viewModel.pgData {
            let apiService = AuthService.shared
            apiService.getPGDetailsForUser(pgData._id) { result in
                switch result {
                case .success(let pgDetails):
                    self.pgDetails = pgDetails
                    let details = pgDetails
                    checkSharingRentInRange(rentDetails: details.pgdata.rent.monthly, pgData: details.pgdata)
                    checkSharingRentInRange(rentDetails: details.pgdata.rent.daily, pgData: details.pgdata)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
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

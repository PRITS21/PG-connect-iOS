//
//  ImageSlideView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 08/03/24.
//

import SwiftUI

struct ImageSliderView: View {
    let imageUrls: [String]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        if !imageUrls.isEmpty {
            TabView(selection: $currentIndex) {
                ForEach(0..<imageUrls.count, id: \.self) { index in
                    AsyncImage(url: URL(string: imageUrls[index])) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 165)
            .cornerRadius(10)
            .padding(.horizontal)
            .onReceive(timer) { _ in
                withAnimation {
                    let nextIndex = (currentIndex + 1) % imageUrls.count
                    currentIndex = nextIndex
                }
            }
        } else {
            Text("No images available")
        }
    }
}

//
//struct ImageSliderView: View {
//    let imageUrls: [String]
//
//    var body: some View {
//        if !imageUrls.isEmpty {
//            TabView {
//                ForEach(imageUrls, id: \.self) { imageUrl in
//                    AsyncImage(url: URL(string: imageUrl)) { phase in
//                        switch phase {
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .scaledToFill()
//                        case .failure:
//                            Image(systemName: "photo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                        case .empty:
//                            ProgressView()
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
//                    .tag(imageUrl)
//                }
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .frame(height: 165)
//            .cornerRadius(10)
//            .padding(.horizontal)
//        } else {
//            Text("No images available")
//        }
//    }
//    
//}

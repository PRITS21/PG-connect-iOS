//
//  DLCardSheet.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 14/04/24.
//

import SwiftUI

struct DLCardSheet: View {
    @State private var image: UIImage?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300,height: 500)
                    
            } else {
                VStack {
                    Text("Document Not Avialable")
                        .font(.system(size: 15)).fontWeight(.semibold).foregroundColor(.black)
                    Image(uiImage: UIImage(named: "2nd_Login")!)
                        .resizable().scaledToFit().imageScale(.large).frame(width: 312, height: 312).padding()
                }
            }
            
            Button {
                dismiss()
            } label: {
                Text("Close")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(width: 200,height: 35)
            .background(Color(UIColor(hex: "#7F32CD")))
            .cornerRadius(5)
            .padding(.top, 7)
            
        }
        .onAppear {
            AuthService.shared.GetDLImage() { result in
                switch result {
                case .success:
                    loadImage()
                case .failure(let error):
                    print("Failed to fetch Aadhar card image: \(error)")
                }
            }
        }
    }
    func loadImage() {
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.jpg") else {
            print("Error: File URL not found")
            return
        }
        do {
            let imageData = try Data(contentsOf: fileURL)
            self.image = UIImage(data: imageData)
        } catch {
            print("Error loading image data: \(error)")
        }
    }
}

#Preview {
    DLCardSheet()
}

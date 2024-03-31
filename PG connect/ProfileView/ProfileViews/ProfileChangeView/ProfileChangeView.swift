//
//  ProfileChangeView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 18/03/24.
//

import SwiftUI
import MobileCoreServices

struct ProfileChangeView: View {
    
    @State private var Ocupation: String = ""
    @State private var Location: String = ""
    @State private var Office: String = ""
    @State private var Aadhar: String = ""
    @State private var License: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var licenseNumber = ""
    @State private var selectedFileURL_DL: URL?
    @State private var selectedFileURL_Adhr: URL?
    
    @State private var selectedImage: Image?
    @State private var isImagePickerPresented = false
    @State private var isDocumentPickerPresented = false
    
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
                    
                    Text("Edit Profile")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(.system(size: 18))
                        .padding(.leading, 30)
                    Spacer()
                }.padding(.leading)
                
                
                //1st part
                ScrollView {
                    VStack {
                        
                        if let image = selectedImage {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 110, height: 110)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 110, height: 110)
                        }
                        
                        
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Text("Change Image")
                                .font(.system(size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 100,height: 30)
                        .background(Color(UIColor(hex: "#EF7C1F")))
                        .cornerRadius(5)
                        .padding(.top, 7)
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImage: $selectedImage)
                        }
                        
                        ProfileDetailsButtons(title1: "Full Name", title2: "Pritam Sarkar")
                            .padding(.top, 20)
                        ProfileDetailsButtons(title1: "Gender", title2: "Male")
                        ProfileDetailsButtons(title1: "DOB", title2: " 2003-01-09")
                        ProfileDetailsButtons(title1: "Email", title2: "saarkarpritam16@gmail.com")
                        ProfileDetailsButtons(title1: "Mobile", title2: "9123456789")
                        
                        
                        //TextFields
                        
                        //Occupation
                        VStack {
                            HStack {
                                Text("Occupation")
                                    .bold()
                                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            TextField("", text: $Ocupation)
                                .frame(height: 25)
                                .font(.subheadline)
                                .padding(.vertical, 4)
                                .padding(.leading)
                                .cornerRadius (10)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        }
                        .padding(.top, 10)
                        .padding (.horizontal)
                        
                        //Location
                        VStack {
                            HStack {
                                Text("Location")
                                    .bold()
                                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            TextField("", text: $Location)
                                .frame(height: 25)
                                .font(.subheadline)
                                .padding(.vertical, 4)
                                .padding(.leading)
                                .cornerRadius (10)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        }
                        .padding(.top, 7)
                        .padding (.horizontal)
                        
                        //Office address
                        VStack {
                            HStack {
                                Text("Office address")
                                    .bold()
                                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            TextField("", text: $Office)
                                .frame(height: 80)
                                .font(.subheadline)
                                .padding(.vertical, 4)
                                .padding(.leading)
                                .cornerRadius (10)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                        }
                        .padding(.top, 7)
                        .padding (.horizontal)
                        
                        //Aadhar card
                        VStack {
                            HStack {
                                Text("Aadhar card")
                                    .bold()
                                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            HStack {
                                TextField("Aadhar number", text: $Aadhar)
                                    .frame(width: 120,height: 25)
                                    .font(.system(size: 12))
                                    .padding(.vertical, 2)
                                    .padding(.leading, 5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                                Button(action: {
                                    isDocumentPickerPresented = true
                                }) {
                                    Image(uiImage: selectedFileURL_Adhr != nil ? UIImage(systemName: "doc")! : UIImage(named: "FileUpload_button")!)
                                        .resizable()
                                        
                                }
                                .frame(width: 120,height: 30)
                                .background(Color(UIColor(hex: "#EF7C1F")))
                                .cornerRadius(5)
                                Spacer()
                            }
                        }
                        .padding(.top, 7)
                        .padding (.horizontal)
                        
                        //Driving license
                        VStack {
                            HStack {
                                Text("Driving license")
                                    .bold()
                                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            HStack {
                                TextField("License no.", text: $License)
                                    .frame(width: 120,height: 25)
                                    .font(.system(size: 12))
                                    .padding(.vertical, 2)
                                    .padding(.leading, 5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                                Button(action: {
                                    isDocumentPickerPresented = true
                                    
                                }) {
                                    Image(uiImage: selectedFileURL_DL != nil ? UIImage(systemName: "doc")! : UIImage(named: "FileUpload_button")!)
                                        .resizable()
                                        
                                }
                                .frame(width: 120,height: 30)
                                .background(Color(UIColor(hex: "#EF7C1F")))
                                .cornerRadius(5)
                                .sheet(isPresented: $isDocumentPickerPresented) {
                                    DocumentPicker(url: $selectedFileURL_DL)
                                }
                                Spacer()
                            }
                        }
                        .padding(.top, 7)
                        .padding (.horizontal)
                        
                        //save button
                        HStack {
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Text("save")
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 100,height: 30)
                            .background(Color(UIColor(hex: "#EF7C1F")))
                            .cornerRadius(5)
                            .padding(.top, 20)
                            .padding(.bottom, 15)
                            .padding(.trailing, 20)
                            .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 4)
                        }
                        
                    }.padding(.top, 10)
                    
                }
            }
        }.navigationBarBackButtonHidden()
    }
    
}

struct ProfileDetailsButtons: View {
    let title1: String
    let title2: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title1)
                    .bold()
                    .foregroundStyle(Color(UIColor(hex: "#5E6278")))
                    .font(.system(size: 12))
                Spacer()
            }
            Rectangle()
                .frame(width: .infinity, height: 25)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 7)
                .overlay (
                    HStack {
                        Text(title2)
                            .bold()
                            .foregroundStyle(Color(uiColor: .systemGray2))
                            .font(.system(size: 14))
                        Spacer()
                        
                    }.padding(.horizontal, 10)
                )
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
        }.padding(.horizontal).padding(.top, 7)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


// DocumentPicker view
struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var url: URL?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePlainText), String(kUTTypePDF)], in: .open)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        
        init(parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.url = url
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.url = nil
        }
    }
}


#Preview {
    ProfileChangeView()
}

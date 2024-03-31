//
//  HelpCenterView.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 19/03/24.
//

import SwiftUI
import MessageUI

struct HelpCenterView: View {
    @Environment(\.dismiss) var dismiss
    
   
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .center) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.black)
                                .imageScale(.large)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                    }.padding(.leading)
                    
                    Text("Help Center")
                        .bold()
                        .foregroundStyle(Color(UIColor(hex: "#7F32CD")))
                        .font(.system(size: 18))
                    
                    
                }
                
                ScrollView {
                    VStack {
                        
                        //whatsapp button
                        Button(action: {
                            openWhatsApp()

                        })  {
                            Rectangle()
                                .frame(width: .infinity, height: 40)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 7)
                                .overlay (
                                    HStack {
                                        Image(uiImage: UIImage(named: "whatsapp_icon")!)
                                            .resizable()
                                            .frame(width: 18, height: 19)
                                        Text(" WhatsApp")
                                            .bold()
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 14))
                                        Spacer()
                                        
                                    }.padding(.leading, 20)
                                )
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                            .background(Color.white)
                        }
                        
                        //Email button
                        Button(action: {
                            print("knnoeidu bf")
                            
                            composeEmail()

                        })  {
                            Rectangle()
                                .frame(width: .infinity, height: 40)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 7)
                                .overlay (
                                    HStack {
                                        Image(systemName: "envelope")
                                            .resizable()
                                            .tint(.black)
                                            .frame(width: 17, height: 14)
                                        Text(" Email")
                                            .bold()
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 14))
                                        Spacer()
                                        
                                    }.padding(.leading, 20)
                                )
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                            .background(Color.white)
                        }
                        
                        //website button
                        Button(action: {
                            if let url = URL(string: "https://pgplanner.com/") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Rectangle()
                                .frame(width: .infinity, height: 40)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 7)
                                .overlay (
                                    HStack {
                                        Image(systemName: "globe")
                                            .resizable()
                                            .tint(.black)
                                            .frame(width: 17, height: 17)
                                        Text(" Website")
                                            .bold()
                                            .foregroundStyle(Color.black)
                                            .font(.system(size: 14))
                                        Spacer()
                                    }.padding(.leading, 20)
                                )
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(.gray))
                                .background(Color.white)
                        }

                        
                        
                    }.padding(.horizontal, 20).padding(.top)
                }
            }.background(Color(.systemGray6))
        }.navigationBarBackButtonHidden()
    }
    
    func composeEmail() {
            if MFMailComposeViewController.canSendMail() {
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = Coordinator(parent: self)
                mailComposer.setToRecipients(["contact@pgplanner.com"])
                UIApplication.shared.windows.first?.rootViewController?.present(mailComposer, animated: true, completion: nil)
            } else {
                // Show error or alert if the device cannot send emails
                print("Device cannot send emails")
            }
        }
        
        // Coordinator to handle MFMailComposeViewControllerDelegate
        class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
            var parent: HelpCenterView
            
            init(parent: HelpCenterView) {
                self.parent = parent
            }
            
            func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
                parent.dismiss()
            }
        }

}


import UIKit

func openWhatsApp() {
    let phoneNumber = "9030397453" // Replace with the dedicated WhatsApp number
    let message = "Hello, this is a pre-filled message!" // Your pre-filled message

    // Check if WhatsApp is installed
    if let whatsappURL = URL(string: "https://wa.me/\(phoneNumber)?text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
        if UIApplication.shared.canOpenURL(whatsappURL) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            // WhatsApp is not installed
            print("WhatsApp is not installed on the device.")
        }
    }
}


#Preview {
    HelpCenterView()
}

import SwiftUI

struct StartView2: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Spacer()
                        Image(uiImage: UIImage(named: "2nd_Login")!)
                            .resizable()
                            .scaledToFit()
                            .imageScale(.large)
                            .frame(width: 312, height: 312)
                            .padding()
                        Spacer()
                        
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .frame(maxHeight: geometry.size.height / 2)
                                .foregroundColor(Color(UIColor(hex: "#F25621")))
                                .cornerRadius(25)
                                .offset(y: geometry.size.height / 12)
                            
                            OrangeBox()
                            
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct StartView2_Previews: PreviewProvider {
    static var previews: some View {
        StartView2()
    }
}

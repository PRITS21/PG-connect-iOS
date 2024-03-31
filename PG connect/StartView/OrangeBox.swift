import SwiftUI

struct OrangeBox: View {
    var body: some View {
            VStack {
                
                Text("Find the best ostels and PGs based on your preferences")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white)
                    .padding()
                
                Text("See the property pics, beds availability in real time, GPS location before booking.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundStyle(Color.white)
                    .padding()
                
                // Buttons
                HStack( alignment: .bottom){
                    NavigationLink(destination: SignUp_1()) {
                        Text("Sing Up")
                            .frame(maxWidth: 100, minHeight: 30)
                            .foregroundStyle(Color.white)
                            .padding()
                        
                    }
                    .padding(.leading, 10)
                    .navigationBarBackButtonHidden()
                    
                    Spacer()
                    
                    NavigationLink(destination: SignIn_1()) {
                        Text("Sing In")
                            .frame(maxWidth: 100, minHeight: 30)
                            .foregroundStyle(Color.white)
                            .padding()
                        
                    }
                    .padding(.trailing, 10)
                    .navigationBarBackButtonHidden()
        
                }
                .padding(.top, 20)
            }
        
    }
}

struct OrangeBox_Previews: PreviewProvider {
    static var previews: some View {
        OrangeBox()
    }
}

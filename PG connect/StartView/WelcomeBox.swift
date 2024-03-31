import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        VStack {
            Text("Welcome to PG Planner")
                .font(.system(size: 25))
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
            
            Text("See the property pics, beds availability in real time, GPS location before booking.")
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundStyle(Color.white)
                .padding()
            
            //start Button
            NavigationLink(destination: StartView2()) {
                Text("Get Started")
                    .frame(maxWidth: 300, minHeight: 30)
                    .foregroundColor(Color(UIColor(hex: "#7F32CD")))
                    .padding()
                    .background( Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                    )
            }
            .padding(.top, 50)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

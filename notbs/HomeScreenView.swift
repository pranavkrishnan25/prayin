import SwiftUI

struct HomeScreenView: View {
    var body: some View {
//        Text("Home Screen: Check")
        Image("thelyx")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)

    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}


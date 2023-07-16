import SwiftUI

struct HomeScreenView: View {
    let screens: [String] = ["Screen 1", "Screen 2", "Screen 3"] // Add your screen names here
        
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            //        Text("Home Screen: Check")
//            Image("thelyx")
//                .resizable()
//                .scaledToFit()
//                .aspectRatio(contentMode: .fit)
            TabView(selection: $currentIndex) {
                            ForEach(0..<screens.count, id: \.self) { index in
                                Text(screens[index])
                                    .font(.title)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    @ViewBuilder
        func createScreenView(for screenName: String) -> some View {
            switch screenName {
            case "Screen 1":
                Screen1View()
            case "Screen 2":
                Screen2View()
            case "Screen 3":
                Screen3View()
            default:
                EmptyView()
            }
        }
}


struct Screen1View: View {
    var body: some View {
        Text("Screen 1")
            .font(.title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Screen2View: View {
    var body: some View {
        Text("Screen 2")
            .font(.title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Screen3View: View {
    var body: some View {
        Text("Screen 3")
            .font(.title)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}


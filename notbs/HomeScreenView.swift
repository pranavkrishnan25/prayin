//import SwiftUI
//
//struct HomeScreenView: View {
//    let screens: [String] = ["Me", "Family", "Friends"]
//    @ObservedObject var homeVM: HomeScreenViewModel
//    @State private var currentIndex: Int = 0
//
//    var body: some View {
//        VStack {
//
//
//            HStack(spacing: 20) {
//                            ForEach(screens.indices, id: \.self) { index in
//                                Button(action: {
//                                    currentIndex = index
//                                }) {
//                                    Text(screens[index])
//                                        .font(.title)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(currentIndex == index ? .blue : .gray)
//                                }
//                            }
//                        }
//                        .padding(.top, 20)
//
//            TabView(selection: $currentIndex) {
//                            ForEach(screens.indices, id: \.self) { index in
//                                createScreenView(for: screens[index])
//                                    .tag(index)
//                            }
//                        }
//                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//        }
//    }
//    @ViewBuilder
//        func createScreenView(for screenName: String) -> some View {
//            switch screenName {
//            case "Me":
//                Screen1View(homeVM: homeVM)
//            case "Family":
//                Screen2View()
//            case "Friends":
//                Screen3View()
//            default:
//                EmptyView()
//            }
//        }
//}
//
//struct Screen1View: View {
//    @ObservedObject var homeVM: HomeScreenViewModel
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.flexible())]) {
//                ForEach(homeVM.events, id: \.date) { event in
//                    TileView(title: event.group, color: Color.blue)
//                        .frame(maxWidth: .infinity)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//
//struct Screen2View: View {
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
//                ForEach(0..<15) { index in
//                    TileView(title: "Tile \(index + 1)", color: Color.green)
//                        .frame(maxWidth: .infinity)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct Screen3View: View {
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
//                ForEach(0..<20) { index in
//                    TileView(title: "Tile \(index + 1)", color: Color.orange)
//                        .frame(maxWidth: .infinity)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct TileView: View {
//    let title: String
//    let color: Color
//
//    var body: some View {
//        HStack {
//            Text(title)
//                .font(.title)
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity) // Occupy the entire horizontal space
//        }
//        .background(color)
//        .cornerRadius(10)
//    }
//}
//
//struct HomeScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreenView(homeVM: HomeScreenViewModel(userId: "xDZPaThouLM9Qavo9GYSeNQIEDc2"))
//
//    }
//}


import SwiftUI

struct HomeScreenView: View {
    let screens: [String] = ["Me", "Family", "Friends"]
    @ObservedObject var homeVM: HomeScreenViewModel
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(screens.indices, id: \.self) { index in
                    Button(action: {
                        currentIndex = index
                    }) {
                        Text(screens[index])
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(currentIndex == index ? .blue : .gray)
                    }
                }
            }
            .padding(.top, 20)
            
            TabView(selection: $currentIndex) {
                ForEach(screens.indices, id: \.self) { index in
                    createScreenView(for: screens[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Refresh Button
            HStack {
                Spacer()
                Button(action: {
                    homeVM.fetchData()
                }) {
                    Image(systemName: "arrow.clockwise") // SF Symbols icon for refresh
                        .font(.largeTitle)
                        .padding()
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                .padding(.trailing)
            }
            .padding(.bottom)
        }
    }
    
    @ViewBuilder
    func createScreenView(for screenName: String) -> some View {
        switch screenName {
        case "Me":
            Screen1View(homeVM: homeVM)
        case "Family":
            Screen2View()
        case "Friends":
            Screen3View()
        default:
            EmptyView()
        }
    }
}

struct Screen1View: View {
    @ObservedObject var homeVM: HomeScreenViewModel

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())]) {
                ForEach(homeVM.events, id: \.date) { event in
                    TileView(title: event.group, color: Color.blue)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

struct Screen2View: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                ForEach(0..<15) { index in
                    TileView(title: "Tile \(index + 1)", color: Color.green)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

struct Screen3View: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                ForEach(0..<20) { index in
                    TileView(title: "Tile \(index + 1)", color: Color.orange)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

struct TileView: View {
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity) // Occupy the entire horizontal space
        }
        .background(color)
        .cornerRadius(10)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(homeVM: HomeScreenViewModel(userId: "xDZPaThouLM9Qavo9GYSeNQIEDc2"))
    }
}

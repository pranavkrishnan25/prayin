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
                    homeVM.fetchFeedInData()
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
            Screen2View(homeVM: homeVM)
        case "Friends":
            Screen3View(events: homeVM.feedOutEvents)
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
                ForEach(homeVM.feedInEvents, id: \.date) { event in
                    TileView(title: event.type, color: Color.blue, imageURL: event.imageURL)

                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

struct Screen2View: View {
    @ObservedObject var homeVM: HomeScreenViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                ForEach(homeVM.feedOutEvents, id: \.date) { event in
                    TileView(title: event.type, color: Color.green, imageURL: event.imageURL)

                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}

struct Screen3View: View {
    var events: [Event]  // <--- Add this property

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                ForEach(events, id: \.date) { event in  // <--- Use this array in the loop
                    TileView(title: event.type, color: Color.orange, imageURL: event.imageURL)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
    }
}


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
import SwiftUI
import FirebaseStorage

struct TileView: View {
    let title: String
    let color: Color
    let imageURL: String?
    
    @State private var uiImage: UIImage? = nil

    var body: some View {
        HStack {
            if let img = uiImage {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .background(color)
        .cornerRadius(10)
        .onAppear(perform: loadImageFromFirebase)
    }

    func loadImageFromFirebase() {
        guard let imageURL = imageURL else { return }

        let storageRef = Storage.storage().reference(forURL: imageURL)
        storageRef.getData(maxSize: Int64(1 * 1024 * 1024)) { data, error in  // max size is 1 MB
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
            } else if let data = data {
                uiImage = UIImage(data: data)
            }
        }
    }
}


struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(homeVM: HomeScreenViewModel(userId: "mockUserIdForPreview"))
    }
}

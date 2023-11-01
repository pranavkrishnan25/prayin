import SwiftUI
import Kingfisher
import Firebase
import FirebaseStorage

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
            
//            TabView(selection: $currentIndex) {
//                ForEach(screens.indices, id: \.self) { index in
//                    createScreenView(for: screens[index])
//                        .tag(index)
//                }
//            }
            //.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Inside HomeScreenView
            TabView(selection: $currentIndex) {
                ForEach(screens.indices, id: \.self) { index in
                    createScreenView(for: screens[index])
                        .refreshable {
                            await homeVM.fetchFeedInData()
                        }
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            // Refresh Button
//            HStack {
//                Spacer()
//                Button(action: {
//                    homeVM.fetchFeedInData()
//                }) {
//                    Image(systemName: "arrow.clockwise") // SF Symbols icon for refresh
//                        .font(.largeTitle)
//                        .padding()
//                }
//                .background(Color.white)
//                .cornerRadius(10)
//                .shadow(color: .gray, radius: 2, x: 1, y: 1)
//                .padding(.trailing)
//            }
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
                    TileView(title: event.type, color: Color.white, imageURL: event.imageURL, notes: event.notes,eventDate: event.date)

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
                    TileView(title: event.type, color: Color.green, imageURL: event.imageURL, notes: event.notes, eventDate: event.date)

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
                    TileView(title: event.type, color: Color.orange, imageURL: event.imageURL, notes: event.notes,eventDate: event.date)
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
    let imageURL: String?
    let notes: String?
    let eventDate: Date  // Assuming eventDate is of type Date

    @State private var isShowingNotes = false

    var elapsedTime: String {
            let components = Calendar.current.dateComponents([.day, .hour, .minute], from: eventDate, to: Date())

            if let days = components.day, days > 0 {
                return "\(days) day\(days > 1 ? "s" : "") ago"
            } else if let hours = components.hour, hours > 0 {
                if let minutes = components.minute, minutes > 0 {
                    return "\(hours) hour\(hours > 1 ? "s" : "") \(minutes) minute\(minutes > 1 ? "s" : "") ago"
                }
                return "\(hours) hour\(hours > 1 ? "s" : "") ago"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
            } else {
                return "Just now"
            }
        }
    var body: some View {
        ZStack(alignment: .top) {
            // Background color
            color
                .cornerRadius(10)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            
            VStack(spacing: 10) { // Adjust the spacing value as per your design
                // Top section with Title, elapsedTime, and three dots button
                HStack {
                    Spacer() // Push the content to the center
                    VStack(alignment: .center, spacing: 5) { // Adjust the spacing value as per your design
                        Text("\(title) Update")
                            .font(.custom("Cochin", size: 20))
                        Text(elapsedTime)
                            .font(.custom("Cochin", size: 15))
                            .foregroundColor(.black)
                    }
                    Spacer() // Push the content to the center
                    Button(action: {
                        isShowingNotes = true
                    }) {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal) // Add horizontal padding
                
                // Image
                if let imageURL = URL(string: self.imageURL ?? "") {
                    KFImage(imageURL)
                        .resizable()
                        .placeholder {
                            Image(systemName: "photo")
                                .resizable()
                                .foregroundColor(.gray)
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300) // You can adjust this frame
                        .clipped()
                }
            }
            .padding([.top, .bottom]) // Add top and bottom padding around the VStack
            .sheet(isPresented: $isShowingNotes) {
                VStack {
                    Text("\(title) Update")
                        .font(.custom("Cochin", size: 30))
                    Text(elapsedTime)
                        .font(.custom("Cochin", size: 20))
                        .foregroundColor(.black)
                    Text(notes ?? "No notes available.")
                        .font(.custom("Cochin", size: 20))
                        .padding()
                }
            }
        }

//        ZStack {
//            // Background color
//            color
//                .cornerRadius(10)
//                .shadow(color: .gray, radius: 2, x: 0, y: 2)
//
//            VStack {
//                // Top section with Title, elapsedTime, and three dots button
//                HStack {
//                    VStack(alignment: .center) {
//                        Text("\(title) Update")
//                            .font(.headline)
//                        Text(elapsedTime)
//                            .font(.subheadline)
//                            .foregroundColor(.black)
//                    }
//                    Spacer() // Push the content to the left
//                    Button(action: {
//                        isShowingNotes = true
//                    }) {
//                        Image(systemName: "ellipsis.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.black)
//                    }
//                }
//                .padding()
//
//                // Image
//                if let imageURL = URL(string: self.imageURL ?? "") {
//                    KFImage(imageURL)
//                        .resizable()
//                        .placeholder {
//                            Image(systemName: "photo")
//                                .resizable()
//                                .foregroundColor(.gray)
//                        }
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 300, height: 300)
//                }
//            }
//            .padding() // Add padding around the VStack
//            .sheet(isPresented: $isShowingNotes) {
//                VStack {
//                    Text("\(title) Update")
//                        .font(.headline)
//                    Text(elapsedTime)
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                    Text(notes ?? "No notes available.")
//                        .padding()
//                }
//            }
//        }

    }
        
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            VStack {
//                VStack {
//                    Text("\(title) Update")
//                        .font(.headline)
//                    Text(elapsedTime)
//                        .font(.subheadline)
//                        .foregroundColor(.black)
//                }
//                // Image
//                if let imageURL = URL(string: self.imageURL ?? "") {
//                    KFImage(imageURL)
//                        .resizable()
//                        .placeholder {
//                            Image(systemName: "photo")
//                                .resizable()
//                                .frame(width: 290, height: 290)
//                                .foregroundColor(.gray)
//                        }
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 300, height: 300)
//                }
//
//                // Title with Update and Time
////                VStack {
////                    Text("\(title) Update")
////                        .font(.headline)
////                    Text(elapsedTime)
////                        .font(.subheadline)
////                        .foregroundColor(.black)
////                }
////                .padding()
////                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(color)
//            .cornerRadius(10)
//            .shadow(color: .gray, radius: 2, x: 0, y: 2)
//            .padding()
//
//            // Three dots button
//            Button(action: {
//                isShowingNotes = true
//            }) {
//                Image(systemName: "ellipsis.circle.fill")
//                    .font(.title)
//                    .foregroundColor(.black)
//            }
//            .padding()
//            .sheet(isPresented: $isShowingNotes) {
//                Text("\(title) Update")
//                    .font(.headline)
//                Text(elapsedTime)
//                    .font(.subheadline)
//                    .foregroundColor(.black)
//                Text(notes ?? "No notes available.")
//                    .padding()
//            }
//        }
//    }
}
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(homeVM: HomeScreenViewModel(userId: "mockUserIdForPreview"))
    }
}

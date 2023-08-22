//
//
//import SwiftUI
//
//struct ContentView: View {
//    @State private var selectedTab: Tab = .home
//
//    var body: some View {
//        VStack {
//            Text("")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//
//            Group {
//                if selectedTab == .home {
//                    HomeScreenView()
//                } else if selectedTab == .plus {
//                    PlusScreenView()
//                } else if selectedTab == .human {
//                    HumanScreenView()
//                }
//            }
//
//            Spacer(minLength: 0)
//
//            HStack(spacing: 60) {
//                Button(action: {
//                    selectedTab = .home
//                }) {
//                    Image(systemName: selectedTab == .home ? "house.fill" : "house")
//                        .font(.system(size: 30))
//                }
//
//                Button(action: {
//                    selectedTab = .plus
//                }) {
//                    Image(systemName: selectedTab == .plus ? "plus.circle.fill" : "plus.circle")
//                        .font(.system(size: 30))
//                }
//
//                Button(action: {
//                    selectedTab = .human
//                }) {
//                    Image(systemName: selectedTab == .human ? "person.fill" : "person")
//                        .font(.system(size: 30))
//                }
//            }
//            .padding(.horizontal, 40)
//            .padding(.bottom, 20)
//        }
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarHidden(true)
//        .edgesIgnoringSafeArea([.top, .bottom])
//    }
//
//    enum Tab {
//        case home
//        case plus
//        case human
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//


//import SwiftUI
//import Firebase
//
//struct ContentView: View {
//    @EnvironmentObject var eventVM: EventViewModel
//    @State private var selectedTab: Tab = .home
//
//    var body: some View {
//        VStack {
//            Text("")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding()
//
//            Group {
//                switch selectedTab {
//                case .home:
//                    HomeScreenView(homeVM: HomeScreenViewModel(userId: "xDZPaThouLM9Qavo9GYSeNQIEDc2"))
//
//                case .plus:
//                    PlusScreenView()
//                case .events:
//                    EventsListView(eventVM: eventVM)
//                case .human:
//                    HumanScreenView()
//                }
//            }
//
//            Spacer(minLength: 0)
//
//            HStack(spacing: 60) {
//                TabButton(
//                    icon: "house",
//                    activeIcon: "house.fill",
//                    selectedTab: $selectedTab,
//                    forTab: .home
//                )
//
//                TabButton(
//                    icon: "plus.circle",
//                    activeIcon: "plus.circle.fill",
//                    selectedTab: $selectedTab,
//                    forTab: .plus
//                )
//
//                TabButton(
//                    icon: "list.bullet.rectangle",
//                    activeIcon: "list.bullet.below.rectangle",
//                    selectedTab: $selectedTab,
//                    forTab: .events
//                )
//
//                TabButton(
//                    icon: "person",
//                    activeIcon: "person.fill",
//                    selectedTab: $selectedTab,
//                    forTab: .human
//                )
//            }
//            .padding(.horizontal, 40)
//            .padding(.bottom, 20)
//        }
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarHidden(true)
//        .edgesIgnoringSafeArea([.top, .bottom])
//    }
//
//    enum Tab {
//        case home
//        case plus
//        case events
//        case human
//    }
//
//    struct TabButton: View {
//        let icon: String
//        let activeIcon: String
//        @Binding var selectedTab: Tab
//        let forTab: Tab
//
//        var body: some View {
//            Button(action: {
//                selectedTab = forTab
//            }) {
//                Image(systemName: selectedTab == forTab ? activeIcon : icon)
//                    .font(.system(size: 30))
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(EventViewModel(userId: "xDZPaThouLM9Qavo9GYSeNQIEDc2"))
//    }
//}

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var eventVM: EventViewModel
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack {
            Text("")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Group {
                switch selectedTab {
                case .home:
                    HomeScreenView(homeVM: HomeScreenViewModel(userId: "xDZPaThouLM9Qavo9GYSeNQIEDc2"))
                case .plus:
                    PlusScreenView()
                case .events:
                    EventsListView(eventVM: eventVM)
                case .human:
                    HumanScreenView()
                case .contacts:  // This is the new ContactsView case.
                    ContactsView()
                }
            }

            Spacer(minLength: 0)

            HStack {
                TabButton(
                    icon: "house",
                    activeIcon: "house.fill",
                    selectedTab: $selectedTab,
                    forTab: .home
                )
                Spacer(minLength: 15)
                
                TabButton(
                    icon: "plus.circle",
                    activeIcon: "plus.circle.fill",
                    selectedTab: $selectedTab,
                    forTab: .plus
                )
                Spacer(minLength: 15)

                TabButton(
                    icon: "list.bullet.rectangle",
                    activeIcon: "list.bullet.below.rectangle",
                    selectedTab: $selectedTab,
                    forTab: .events
                )
                Spacer(minLength: 15)
                
                TabButton(
                    icon: "person",
                    activeIcon: "person.fill",
                    selectedTab: $selectedTab,
                    forTab: .human
                )
                Spacer(minLength: 15)

                TabButton(
                    icon: "person.3",
                    activeIcon: "person.3.fill",
                    selectedTab: $selectedTab,
                    forTab: .contacts
                )
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)

        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    enum Tab {
        case home
        case plus
        case events
        case human
        case contacts  // Add this for the ContactsView
    }

    struct TabButton: View {
        let icon: String
        let activeIcon: String
        @Binding var selectedTab: Tab
        let forTab: Tab

        var body: some View {
            Button(action: {
                selectedTab = forTab
            }) {
                Image(systemName: selectedTab == forTab ? activeIcon : icon)
                    .font(.system(size: 30))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventViewModel(userId: "xDZPaThouLM9Qavo9GYSeNQIEDc2"))
    }
}

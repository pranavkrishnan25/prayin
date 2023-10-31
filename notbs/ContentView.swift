
import SwiftUI
import Firebase
import FirebaseAuth

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
                if let currentUserId = Auth.auth().currentUser?.uid {
                    switch selectedTab {
                    case .home:
                        HomeScreenView(homeVM: HomeScreenViewModel(userId: currentUserId))
                    case .plus:
                        PlusScreenView()
//                    case .events:
//                        EventsListView(eventVM: eventVM)
                    case .human:
                        HumanScreenView()
//                    case .contacts:  // This is the new ContactsView case.
//                        ContactsView()
                    }
                } else {
                    // Handle the case where no user is logged in, perhaps show a login screen or an error message
                    Text("Please log in to continue.")
                }
            }


            Spacer(minLength: 0)

            HStack {
                Spacer(minLength: 1)
                TabButton(
                    icon: "house",
                    activeIcon: "house.fill",
                    selectedTab: $selectedTab,
                    forTab: .home
                )
                Spacer(minLength: 30)
                
                TabButton(
                    icon: "plus.circle",
                    activeIcon: "plus.circle.fill",
                    selectedTab: $selectedTab,
                    forTab: .plus
                )
                Spacer(minLength: 30)

//                TabButton(
//                    icon: "list.bullet.rectangle",
//                    activeIcon: "list.bullet.below.rectangle",
//                    selectedTab: $selectedTab,
//                    forTab: .events
//                )
//                Spacer(minLength: 15)
                
                TabButton(
                    icon: "person",
                    activeIcon: "person.fill",
                    selectedTab: $selectedTab,
                    forTab: .human
                )
                Spacer(minLength: 1)

//                TabButton(
//                    icon: "person.3",
//                    activeIcon: "person.3.fill",
//                    selectedTab: $selectedTab,
//                    forTab: .contacts
//                )
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
//        case events
        case human
//        case contacts  // Add this for the ContactsView
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
            .environmentObject(EventViewModel(userId: "mockUserIdForPreview"))
    }
}

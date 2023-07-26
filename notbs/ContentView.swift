

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack {
            Text("")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            Group {
                if selectedTab == .home {
                    HomeScreenView()
                } else if selectedTab == .plus {
                    PlusScreenView()
                } else if selectedTab == .human {
                    HumanScreenView()
                }
            }
            
            Spacer(minLength: 0)

            HStack(spacing: 60) {
                Button(action: {
                    selectedTab = .home
                }) {
                    Image(systemName: selectedTab == .home ? "house.fill" : "house")
                        .font(.system(size: 30))
                }

                Button(action: {
                    selectedTab = .plus
                }) {
                    Image(systemName: selectedTab == .plus ? "plus.circle.fill" : "plus.circle")
                        .font(.system(size: 30))
                }

                Button(action: {
                    selectedTab = .human
                }) {
                    Image(systemName: selectedTab == .human ? "person.fill" : "person")
                        .font(.system(size: 30))
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    enum Tab {
        case home
        case plus
        case human
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



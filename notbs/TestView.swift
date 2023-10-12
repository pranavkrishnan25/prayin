////
////  TestView.swift
////  notbs
////
////  Created by Pranav Krishnan on 9/21/23.
////
//
//
import SwiftUI
import FirebaseAuth
//
//struct TestView: View {
//    @ObservedObject var viewModel: ContactsViewModel
//
//    init() {
//        if let currentUserId = Auth.auth().currentUser?.uid {
//            viewModel = ContactsViewModel(userId: currentUserId)
//        } else {
//            viewModel = ContactsViewModel(userId: "mockUserId")
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.events, id: \.first) { person in
//                VStack(alignment: .leading) {
//                    Text(person.first)
//                    Text(person.last)
//                }
//            }
//            .navigationTitle("Contacts")
//        }
//    }
//}
//
//struct TestView_Previews: PreviewProvider {  // Corrected the name here
//    static var previews: some View {
//        TestView()  // Changed to TestView
//    }
//}
//

//import SwiftUI
//import FirebaseAuth
//
//struct TestView: View {
//    @ObservedObject var viewModel: ContactsViewModel
//
//    init() {
//        if let currentUserId = Auth.auth().currentUser?.uid {
//            viewModel = ContactsViewModel(userId: currentUserId)
//        } else {
//            viewModel = ContactsViewModel(userId: "mockUserId")
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack {
//                    ForEach(viewModel.events, id: \.first) { person in
//                        VStack(alignment: .leading) {
//                            Text(person.first.isEmpty ? "No First Name" : person.first)
//                            Text(person.last.isEmpty ? "No Last Name" : person.last)
//                        }
//                        .padding()
//                    }
//                }
//            }
//            .navigationTitle("Contacts")
//        }
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

struct TestView: View {
    @ObservedObject var viewModel: ContactsViewModel
    @State private var selectedTab: String = "Friends"

    init() {
        if let currentUserId = Auth.auth().currentUser?.uid {
            viewModel = ContactsViewModel(userId: currentUserId)
        } else {
            viewModel = ContactsViewModel(userId: "mockUserId")
        }
    }

//    var body: some View {
//        NavigationView {
//            TabView {
//                contactList(for: viewModel.friends).tabItem {
//                    Text("Friends")
//                }
//
//                contactList(for: viewModel.family).tabItem {
//                    Text("Family")
//                }
//            }
//            .navigationTitle("Contacts")
//        }
//    }
    var body: some View {
        NavigationView {
            VStack {
                Picker("Group", selection: $selectedTab) {
                    Text("Friends").tag("Friends")
                    Text("Family").tag("Family")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                if selectedTab == "Friends" {
                    contactList(for: viewModel.friends)
                } else {
                    contactList(for: viewModel.family)
                }
            }
            .navigationTitle("Contacts")
        }
    }
    
    func contactList(for persons: [Person]) -> some View {
        ScrollView {
            VStack {
                ForEach(persons, id: \.first) { person in
                    VStack(alignment: .leading) {
                        Text(person.first.isEmpty ? "No First Name" : person.first)
                        Text(person.last.isEmpty ? "No Last Name" : person.last)
                    }
                    .padding()
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

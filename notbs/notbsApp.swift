////
////  notbsApp.swift
////  notbs
////
////  Created by Pranav Krishnan on 6/28/23.
////
//
//import SwiftUI
//import FirebaseCore
//
//
//@main
//struct notbsApp: App {
//    init(){
//        FirebaseApp.configure()
//    }
//    var body: some Scene {
//        WindowGroup {
//            LaunchScreenView()
//        }
//    }
//}


import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct notbsApp: App {
    init() {
        FirebaseApp.configure()
    }

    @StateObject private var eventVM: EventViewModel = {
        let userId = Auth.auth().currentUser?.uid ?? ""
        return EventViewModel(userId: userId)
    }()

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environmentObject(eventVM)
        }
    }
}

////

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct notbsApp: App {
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.debug)

        FirebaseApp.configure()
    }

    @StateObject private var eventVM: EventViewModel = {
//        let userId = Auth.auth().currentUser?.uid ?? ""
        let userId = "OV1ba1EFWdelyNeOCymMGECpjS12"
        return EventViewModel(userId: userId)
    }()

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environmentObject(eventVM)
        }
    }
}



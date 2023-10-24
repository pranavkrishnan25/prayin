////
////  HomeScreenViewModel.swift
////  notbs
////
////  Created by Pranav Krishnan on 8/20/23.
////
import FirebaseFirestore


class HomeScreenViewModel: ObservableObject {
    @Published var feedInEvents: [Event] = []
    @Published var feedOutEvents: [Event] = []
    private var db = Firestore.firestore()
    var userId: String

    init(userId: String) {
        self.userId = userId
        fetchFeedInData()
        fetchFeedOutData()
    }

    func fetchFeedInData() {
        let userRef = db.collection("users").document(userId)
        userRef.collection("feed_in").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting feed_in events: \(error)")
                return
            }
            
            self.feedInEvents = querySnapshot?.documents.compactMap({ document in
                let data = document.data()
                let group = data["group"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let timestamp = data["date"] as? Timestamp
                let date = timestamp?.dateValue() ?? Date()
//                return Event(group: group, type: type, date: date)
                let imageURL = data["imageURL"] as? String
                return Event(group: group, type: type, date: date, imageURL: imageURL)
            }) ?? []
        }
    }

    func fetchFeedOutData() {
        let userRef = db.collection("users").document(userId)
        userRef.collection("feed_out").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting feed_out events: \(error)")
                return
            }
            
            self.feedOutEvents = querySnapshot?.documents.compactMap({ document in
                let data = document.data()
                let group = data["group"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let timestamp = data["date"] as? Timestamp
                let date = timestamp?.dateValue() ?? Date()
//                return Event(group: group, type: type, date: date)
                let imageURL = data["imageURL"] as? String
                return Event(group: group, type: type, date: date, imageURL: imageURL)
            }) ?? []
        }
    }
}

import Foundation
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    @Published var friends: [Person] = []
    @Published var family: [Person] = []
    @Published var selectedPersons: [Person] = []

    private var db = Firestore.firestore()
    var userId: String

    init(userId: String) {
        self.userId = userId
        fetchData()
    }

    func fetchData(completion: ((Result<Void, Error>) -> Void)? = nil) {
        fetchGroup("Friends") { result in
            switch result {
            case .success(let friends):
                self.friends = friends
            case .failure(let error):
                print("Error fetching friends: \(error)")
            }
            
            self.fetchGroup("Family") { result in
                switch result {
                case .success(let family):
                    self.family = family
                case .failure(let error):
                    print("Error fetching family: \(error)")
                }
                
                completion?(.success(()))
            }
        }
    }
    
//    private func fetchGroup(_ group: String, completion: @escaping (Result<[Person], Error>) -> Void) {
//        let groupRef = db.collection("users").document(userId).collection("contacts").document(group).collection(group)
//        groupRef.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            let persons: [Person] = querySnapshot?.documents.compactMap({ document in
//                let data = document.data()
//                guard let firstName = data["firstName"] as? String,
//                      let lastName = data["lastName"] as? String else {
//                    return nil
//                }
//                return Person(first: firstName, last: lastName)
//            }) ?? []
//
//            completion(.success(persons))
//        }
//    }
//    private func fetchGroup(_ group: String, completion: @escaping (Result<[Person], Error>) -> Void) {
//        let groupRef = db.collection("users").document(userId).collection("contacts").document(group).collection(group)
//        groupRef.getDocuments { (querySnapshot, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            let persons: [Person] = querySnapshot?.documents.compactMap({ document in
//                let data = document.data()
//                guard let firstName = data["firstName"] as? String,
//                      let lastName = data["lastName"] as? String,
//                      let phoneNumber = data["phoneNumber"] as? String else {
//                    return nil
//                }
//                return Person(first: firstName, last: lastName, phoneNumber: phoneNumber)
//            }) ?? []
//
//            completion(.success(persons))
//        }
//    }
    private func fetchGroup(_ group: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        let groupRef = db.collection("users").document(userId).collection("contacts").document(group).collection(group)
        groupRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let persons: [Person] = querySnapshot?.documents.compactMap({ document in
                let data = document.data()
                guard let firstName = data["firstName"] as? String,
                      let lastName = data["lastName"] as? String,
                      let phoneNumber = data["phoneNumber"] as? String,
                      let userID = data["userID"] as? String else {
                    return nil
                }
                return Person(first: firstName, last: lastName, phoneNumber: phoneNumber, userID: userID)
            }) ?? []
            
            completion(.success(persons))
        }
    }


    
    func fetchAndBundleGroup(_ group: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        fetchGroup(group) { result in
            switch result {
            case .success(let fetchedPersons):
                // Bundle the fetched data with the selected data
                let bundledData = self.selectedPersons + fetchedPersons
                completion(.success(bundledData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}

struct Person {
    var first: String
    var last: String
    var phoneNumber: String
    var userID: String
}

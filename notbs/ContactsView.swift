////import SwiftUI
////import Contacts
////
////struct ContactsView: View {
////    @State private var selectedGroup: GroupType?
////    @State private var contacts: [CNContact] = []
////
////    var body: some View {
////        VStack {
////            HStack {
////                GroupButton(group: .friends, selectedGroup: $selectedGroup, action: {
////                    self.fetchContacts(for: .friends)
////                })
////                GroupButton(group: .family, selectedGroup: $selectedGroup, action: {
////                    self.fetchContacts(for: .family)
////                })
////                GroupButton(group: .personal, selectedGroup: $selectedGroup, action: {
////                    self.fetchContacts(for: .personal)
////                })
////            }
////
////            List(contacts, id: \.identifier) { contact in
////                VStack(alignment: .leading) {
////                    Text(contact.givenName + " " + contact.familyName)
////                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
////                        Text(phoneNumber)
////                    }
////                }
////            }
////        }
////        .padding()
////    }
////
////    func fetchContacts(for group: GroupType) {
////        contacts = [] // Clear out the old contacts
////        let store = CNContactStore()
////
////        switch CNContactStore.authorizationStatus(for: .contacts) {
////        case .authorized:
////            retrieveContacts(from: store)
////        case .notDetermined:
////            store.requestAccess(for: .contacts) { success, error in
////                if success {
////                    retrieveContacts(from: store)
////                }
////            }
////        default:
////            print("Contacts access denied.")
////        }
////    }
////
////    func retrieveContacts(from store: CNContactStore) {
////        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
////        let request = CNContactFetchRequest(keysToFetch: keys)
////
////        do {
////            try store.enumerateContacts(with: request) { (contact, stop) in
////                self.contacts.append(contact)
////            }
////        } catch {
////            print("Failed to fetch contacts:", error)
////        }
////    }
////
////    enum GroupType {
////        case friends, family, personal
////    }
////
////    struct GroupButton: View {
////        let group: GroupType
////        @Binding var selectedGroup: GroupType?
////        let action: () -> Void
////
////        var body: some View {
////            Button(action: {
////                selectedGroup = group
////                action()
////            }) {
////                Text(group.title)
////                    .padding()
////                    .background(Color.blue)
////                    .foregroundColor(.white)
////                    .cornerRadius(10)
////            }
////        }
////    }
////}
////
////extension ContactsView.GroupType {
////    var title: String {
////        switch self {
////        case .friends:
////            return "Friends"
////        case .family:
////            return "Family"
////        case .personal:
////            return "Personal"
////        }
////    }
////}
//
//
//
//
//
//
//
//import SwiftUI
//import Contacts
//import Firebase
//
//struct ContactsView: View {
//    @State private var selectedGroup: GroupType?
//    @State private var contacts: [CNContact] = []
//    @State private var selectedContacts: [CNContact] = []
//
//    var body: some View {
//        VStack {
//            HStack {
//                GroupButton(group: .friends, selectedGroup: $selectedGroup, action: {
//                    self.fetchContacts(for: .friends)
//                })
//                GroupButton(group: .family, selectedGroup: $selectedGroup, action: {
//                    self.fetchContacts(for: .family)
//                })
//                GroupButton(group: .personal, selectedGroup: $selectedGroup, action: {
//                    self.fetchContacts(for: .personal)
//                })
//            }
//
//            List(contacts, id: \.identifier) { contact in
//                Button(action: {
//                    if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
//                        selectedContacts.removeAll(where: { $0.identifier == contact.identifier })
//                    } else {
//                        selectedContacts.append(contact)
//                    }
//                }) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(contact.givenName + " " + contact.familyName)
//                            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
//                                Text(phoneNumber)
//                            }
//                        }
//                        Spacer()
//                        if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
//                            Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
//                        }
//                    }
//                }
//            }
//
//            Button("Add") {
//                for contact in selectedContacts {
//                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
//                        print("\(contact.givenName) \(contact.familyName): \(phoneNumber)")
//                    }
//                }
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//        .padding()
//    }
//
//    // ... [The rest of your methods and enums remain unchanged]
//
//    func fetchContacts(for group: GroupType) {
//        contacts = [] // Clear out the old contacts
//        let store = CNContactStore()
//
//        switch CNContactStore.authorizationStatus(for: .contacts) {
//        case .authorized:
//            retrieveContacts(from: store)
//        case .notDetermined:
//            store.requestAccess(for: .contacts) { success, error in
//                if success {
//                    retrieveContacts(from: store)
//                }
//            }
//        default:
//            print("Contacts access denied.")
//        }
//    }
//
//    func retrieveContacts(from store: CNContactStore) {
//        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
//        let request = CNContactFetchRequest(keysToFetch: keys)
//
//        do {
//            try store.enumerateContacts(with: request) { (contact, stop) in
//                self.contacts.append(contact)
//            }
//        } catch {
//            print("Failed to fetch contacts:", error)
//        }
//    }
//
//    enum GroupType {
//        case friends, family, personal
//    }
//
//    struct GroupButton: View {
//        let group: GroupType
//        @Binding var selectedGroup: GroupType?
//        let action: () -> Void
//
//        var body: some View {
//            Button(action: {
//                selectedGroup = group
//                action()
//            }) {
//                Text(group.title)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}
//
//extension ContactsView.GroupType {
//    var title: String {
//        switch self {
//        case .friends:
//            return "Friends"
//        case .family:
//            return "Family"
//        case .personal:
//            return "Personal"
//        }
//    }
//}


import SwiftUI
import Contacts
import Firebase

struct ContactsView: View {
    @State private var selectedGroup: GroupType?
    @State private var contacts: [CNContact] = []
    @State private var selectedContacts: [CNContact] = []

    var body: some View {
        VStack {
            HStack {
                GroupButton(group: .friends, selectedGroup: $selectedGroup, action: {
                    self.fetchContacts(for: .friends)
                })
                GroupButton(group: .family, selectedGroup: $selectedGroup, action: {
                    self.fetchContacts(for: .family)
                })
                GroupButton(group: .personal, selectedGroup: $selectedGroup, action: {
                    self.fetchContacts(for: .personal)
                })
            }

            List(contacts, id: \.identifier) { contact in
                Button(action: {
                    if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
                        selectedContacts.removeAll(where: { $0.identifier == contact.identifier })
                    } else {
                        selectedContacts.append(contact)
                    }
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(contact.givenName + " " + contact.familyName)
                            if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                                Text(phoneNumber)
                            }
                        }
                        Spacer()
                        if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
                        }
                    }
                }
            }

            Button("Add") {
                let db = Firestore.firestore()
                guard let userId = Auth.auth().currentUser?.uid else {
                    print("User not logged in!")
                    return
                }

                for contact in selectedContacts {
                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                        let contactData: [String: Any] = [
                            "firstName": contact.givenName,
                            "lastName": contact.familyName,
                            "phoneNumber": phoneNumber
                        ]

                        db.collection("users").document(userId).collection("contacts").addDocument(data: contactData) { error in
                            if let error = error {
                                print("Error adding document: \(error)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }

    func fetchContacts(for group: GroupType) {
        contacts = [] // Clear out the old contacts
        let store = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            retrieveContacts(from: store)
        case .notDetermined:
            store.requestAccess(for: .contacts) { success, error in
                if success {
                    retrieveContacts(from: store)
                }
            }
        default:
            print("Contacts access denied.")
        }
    }

    func retrieveContacts(from store: CNContactStore) {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)

        do {
            try store.enumerateContacts(with: request) { (contact, stop) in
                self.contacts.append(contact)
            }
        } catch {
            print("Failed to fetch contacts:", error)
        }
    }

    enum GroupType {
        case friends, family, personal
    }

    struct GroupButton: View {
        let group: GroupType
        @Binding var selectedGroup: GroupType?
        let action: () -> Void

        var body: some View {
            Button(action: {
                selectedGroup = group
                action()
            }) {
                Text(group.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

extension ContactsView.GroupType {
    var title: String {
        switch self {
        case .friends:
            return "Friends"
        case .family:
            return "Family"
        case .personal:
            return "Personal"
        }
    }
}

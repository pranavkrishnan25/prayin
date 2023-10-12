
import SwiftUI
import FirebaseFirestore
import Contacts
import FirebaseAuth

struct ContactsView: View {
    @State private var contacts: [CNContact] = []
    @State private var selectedContacts: [CNContact] = []
    @State private var selectedGroup: String = "Friends"
    @State private var groupOptions = ["Friends", "Family"]
    
    var body: some View {
        VStack {
            // Group Picker
            Picker("Group", selection: $selectedGroup) {
                ForEach(groupOptions, id: \.self) { group in
                    Text(group)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Contacts List
            //            List(contacts, id: \.identifier) { contact in
            //                HStack {
            //                    Text("\(contact.givenName) \(contact.familyName)")
            //                    Spacer()
            //                    if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
            //                        Image(systemName: "checkmark")
            //                    }
            //                }
            //                .contentShape(Rectangle())
            //                .onTapGesture {
            //                    if let index = selectedContacts.firstIndex(where: { $0.identifier == contact.identifier }) {
            //                        selectedContacts.remove(at: index)
            //                    } else {
            //                        selectedContacts.append(contact)
            //                    }
            //                }
            //            }
            List(contacts, id: \.identifier) { contact in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(contact.givenName) \(contact.familyName)")
                        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                            Text(phoneNumber)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if let index = selectedContacts.firstIndex(where: { $0.identifier == contact.identifier }) {
                        selectedContacts.remove(at: index)
                    } else {
                        selectedContacts.append(contact)
                    }
                }
            }
            
            
            // Send to Firebase Button
            Button("Send to Firebase") {
                sendToFirebase()
            }
            .padding()
        }
        .onAppear {
            fetchContacts()
        }
    }
    
    // Fetch Contacts
    func fetchContacts() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactIdentifierKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stopPointer) in
                self.contacts.append(contact)
            })
        } catch let error {
            print("Failed to fetch contacts:", error)
        }
    }

//    func sendToFirebase() {
//        let db = Firestore.firestore()
//
//        if let user = Auth.auth().currentUser {
//            let userId = user.uid
//
//            for contact in selectedContacts {
//                let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
//
//                // Check if this phoneNumber exists in the users collection
//                db.collection("users").whereField("Phone Number", isEqualTo: phoneNumber).getDocuments { (querySnapshot, error) in
//                    if let error = error {
//                        print("Error getting documents: \(error)")
//                    } else {
//                        if let firstDocument = querySnapshot?.documents.first {
//                            // This means a user with this phone number exists
//                            let userPhoneNumber = firstDocument.data()["Phone Number"] as? String ?? "Not a user"
//                            let contactData: [String: Any] = [
//                                "firstName": contact.givenName,
//                                "lastName": contact.familyName,
//                                "phoneNumber": userPhoneNumber
//                            ]
//
//                            // Create a unique ID based on the contact's first name, last name, and group
//                            let uniqueID = "\(contact.givenName)-\(contact.familyName)-\(selectedGroup)"
//
//                            db.collection("users").document(userId).collection("contacts").document(selectedGroup).collection(selectedGroup).document(uniqueID).setData(contactData)
//                        } else {
//                            // No user with this phone number exists
//                            let contactData: [String: Any] = [
//                                "firstName": contact.givenName,
//                                "lastName": contact.familyName,
//                                "phoneNumber": "Not a user"
//                            ]
//
//                            // Create a unique ID based on the contact's first name, last name, and group
//                            let uniqueID = "\(contact.givenName)-\(contact.familyName)-\(selectedGroup)"
//
//                            db.collection("users").document(userId).collection("contacts").document(selectedGroup).collection(selectedGroup).document(uniqueID).setData(contactData)
//                        }
//                    }
//                }
//            }
//        }
//    }
    func sendToFirebase() {
        let db = Firestore.firestore()

        if let user = Auth.auth().currentUser {
            let userId = user.uid

            for contact in selectedContacts {
                let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""

                // Check if this phoneNumber exists in the users collection
                db.collection("users").whereField("Phone Number", isEqualTo: phoneNumber).getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        if let firstDocument = querySnapshot?.documents.first {
                            // This means a user with this phone number exists
                            let userPhoneNumber = firstDocument.data()["Phone Number"] as? String ?? "Not a user"
                            let matchedUserId = firstDocument.documentID // This is the userID of the matched user

                            let contactData: [String: Any] = [
                                "firstName": contact.givenName,
                                "lastName": contact.familyName,
                                "phoneNumber": userPhoneNumber,
                                "userID": matchedUserId // Add the userID of the matched user
                            ]

                            // Create a unique ID based on the contact's first name, last name, and group
                            let uniqueID = "\(contact.givenName)-\(contact.familyName)-\(selectedGroup)"

                            db.collection("users").document(userId).collection("contacts").document(selectedGroup).collection(selectedGroup).document(uniqueID).setData(contactData)
                        } else {
                            // No user with this phone number exists
                            let contactData: [String: Any] = [
                                "firstName": contact.givenName,
                                "lastName": contact.familyName,
                                "phoneNumber": "Not a user",
                                "userID": "N/A"
                            ]

                            // Create a unique ID based on the contact's first name, last name, and group
                            let uniqueID = "\(contact.givenName)-\(contact.familyName)-\(selectedGroup)"

                            db.collection("users").document(userId).collection("contacts").document(selectedGroup).collection(selectedGroup).document(uniqueID).setData(contactData)
                        }
                    }
                }
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}

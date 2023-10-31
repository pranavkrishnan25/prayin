
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
//        VStack {
//            // Group Picker
//            Picker("Group", selection: $selectedGroup) {
//                ForEach(groupOptions, id: \.self) { group in
//                    Text(group)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
//
//            List(contacts, id: \.identifier) { contact in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("\(contact.givenName) \(contact.familyName)")
//                        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
//                            Text(phoneNumber)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
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
//
//
//            // Send to Firebase Button
//            Button("Send to Firebase") {
//                sendToFirebase()
//            }
//            .padding()
//        }
        VStack {
            // Group Picker
//            Picker("Group", selection: $selectedGroup) {
//                ForEach(groupOptions, id: \.self) { group in
//                    Text(group)
//                }
//            }
            HStack {
                ForEach(groupOptions, id: \.self) { group in
                    Button(action: {
                        self.selectedGroup = group
                    }) {
                        Text(group)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(self.selectedGroup == group ? Color.blue : Color.clear)
                            .foregroundColor(self.selectedGroup == group ? Color.white : Color.blue)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.horizontal)
            .pickerStyle(SegmentedPickerStyle())
            .padding(.top, 10)
            .accentColor(.blue)

            Spacer(minLength: 10)

            // Contacts List
            List(contacts, id: \.identifier) { contact in
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading) {
                        Text("\(contact.givenName) \(contact.familyName)")
                            .font(.headline)
                        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                            Text(phoneNumber)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    if selectedContacts.contains(where: { $0.identifier == contact.identifier }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 5)
                .onTapGesture {
                    if let index = selectedContacts.firstIndex(where: { $0.identifier == contact.identifier }) {
                        selectedContacts.remove(at: index)
                    } else {
                        selectedContacts.append(contact)
                    }
                }
            }

            Spacer(minLength: 10)

            // Send to Firebase Button
            Button("Send to Firebase") {
                sendToFirebase()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, 10)
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

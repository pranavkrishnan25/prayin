

import SwiftUI
import Firebase
import FirebaseAuth

struct PlusScreenView: View {
    private let cosmosDBService = CosmosDBService()
    @State private var showGroupMenu = false
    let groupOptions = ["Friends", "Family", "Personal", "Private", "Custom Group"]
    @State private var selectedGroup = ""

    @State private var showTypeMenu = false
    let typeOptions = ["Injury", "Doctor Visit", "Medicine", "Fitness"]
    @State private var selectedType = ""

    @State private var sendNotification = false

    @State private var selectedDate = Date()

    @State private var selectedImage: UIImage?
    @State private var isCameraPresented = false
    
    @State private var selectedPersons: [Person] = []

    @ObservedObject var viewModel = ContactsViewModel(userId: Auth.auth().currentUser?.uid ?? "mockUserId")

    @State private var eventName = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("New Event")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 30)
//                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            
            TextField("Enter event name", text: $eventName)  // TextField for event name input
                .font(Font.custom("Inter", size: 21).weight(.black))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.43))
                .padding(.leading)  // Padding to align to the left
                .textFieldStyle(PlainTextFieldStyle())  // This style removes any platform default styling

            OptionButtonView(viewModel: viewModel, selectedPersons: $selectedPersons, showMenu: $showGroupMenu, selectedOption: $selectedGroup, options: groupOptions, label: "Group")
                .padding(.top, 0)

                .padding(.top, 20)
                .padding(.top, 20)

                .padding(.top, 20)

            HStack {
                Text("Send Push Notification")
                    .font(.title3)
                    .foregroundColor(.black)

                Spacer()

                Toggle("", isOn: $sendNotification)
                    .labelsHidden()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            OptionButtonView(viewModel: viewModel, selectedPersons: $selectedPersons, showMenu: $showTypeMenu, selectedOption: $selectedType, options: typeOptions, label: "Type")
                .padding(.top, 20)

                .padding(.top, 20)

            ScrollView(.vertical, showsIndicators: false) {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(height: 300)
                    .padding()
            }

            HStack {
                Text("Picture")
                    .font(.title2)
                    .padding(.leading, 20)

                Button(action: {
                    isCameraPresented = true
                }) {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.blue.opacity(0.4)))
                }
                .sheet(isPresented: $isCameraPresented) {
                    ImagePickerView(selectedImage: $selectedImage, sourceType: .camera)
                }
                .padding(.leading)
            }
            .padding(.bottom, 20)

            Button(action: sendButtonTapped) {
                HStack {
                    Text("Share")
                        .font(.title2)
                    Image(systemName: "paperplane")
                        .font(.title2)
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 30)
                .background(RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue))
            }
            .padding(.bottom, 20)

        }
    }



    func sendButtonTapped() {
        // Cosmos DB
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }

        let cosmosEventData: [String: Any] = [
            "id": UUID().uuidString,
            "group": selectedGroup,
            "type": selectedType,
            "date": selectedDate,  // You may need to convert this to a string or another type that Cosmos DB can accept
            "userId": currentUserId
        ]

        cosmosDBService.createDocument(in: "Container1", databaseId: "thelyx", document: cosmosEventData) { result in
            switch result {
            case .success(let data):
                print("Cosmos Document created!")
            case .failure(let error):
                print("Cosmos Error: \(error)")
            }
        }

        // Firebase Firestore
        let db = Firestore.firestore()

        // Data to save:
        var firebaseEventData: [String: Any] = [
            "group": selectedGroup,
            "type": selectedType,
            "date": Timestamp(date: selectedDate),
            "userId": currentUserId
        ]

        var contactsArray: [[String: Any]] = []

        for person in selectedPersons {
            let contactData: [String: Any] = [
                "firstName": person.first,
                "lastName": person.last,
                "phoneNumber": person.phoneNumber,
                "userID": person.userID
            ]
            contactsArray.append(contactData)
        }

        firebaseEventData["contacts"] = contactsArray

        // Save event to the user's specific events sub-collection
        let userRef = db.collection("users").document(currentUserId)
        userRef.collection("events").addDocument(data: firebaseEventData) { error in
            if let error = error {
                print("Firebase Error adding document: \(error)")
            } else {
                print("Firebase Document successfully added!")
            }
        }


        userRef.collection("feed_in").addDocument(data: firebaseEventData) { error in
                if let error = error {
                    print("Firebase Error adding document to feed_in: \(error)")
                } else {
                    print("Firebase Document successfully added to feed_in!")

                    for contact in contactsArray {
                        if let contactUserID = contact["userID"] as? String, !contactUserID.isEmpty, contactUserID != "N/A" {
                            let contactRef = db.collection("users").document(contactUserID)
                            contactRef.collection("feed_out").addDocument(data: firebaseEventData) { error in
                                if let error = error {
                                    print("Firebase Error adding document to feed_out of user \(contactUserID): \(error)")
                                } else {
                                    print("Firebase Document successfully added to feed_out of user \(contactUserID)!")
                                }
                            }
                        }
                    }

                }
            }
    }

}

struct OptionButtonView: View {

    @ObservedObject var viewModel: ContactsViewModel
    @Binding var selectedPersons: [Person]
    @Binding var showMenu: Bool
    @Binding var selectedOption: String
    let options: [String]
    let label: String

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Text(self.selectedOption.isEmpty ? label : self.selectedOption)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.blue.opacity(0.4)))
            }
            .padding(.leading, 20)

            if showMenu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                        withAnimation {
                            self.showMenu = false
                        }
                        if option == "Friends" || option == "Family" {
                            viewModel.fetchAndBundleGroup(option) { result in
                                switch result {
                                case .success(let bundledData):
                                    self.selectedPersons = bundledData
                                case .failure(let error):
                                    print("Error fetching and bundling \(option): \(error)")
                                }
                            }
                        }
                    }) {
                        Text(option)
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }


                    .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.7)))
                    .padding(.leading, 20)
                }
                .transition(.move(edge: .top))
            }
        }
    }
}

struct PlusScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PlusScreenView()
    }
}




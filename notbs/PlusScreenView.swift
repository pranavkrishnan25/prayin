

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage


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
    
    @State private var showImagePickerActionSheet = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @ObservedObject var viewModel = ContactsViewModel(userId: Auth.auth().currentUser?.uid ?? "mockUserId")

    @State private var eventName = ""


    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("New Event")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Event Name Field
                    TextField("Enter event name", text: $eventName)
                        .font(.title2)
                        .padding(.all, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    // Group Button
                    OptionButtonView(viewModel: viewModel, selectedPersons: $selectedPersons, showMenu: $showGroupMenu, selectedOption: $selectedGroup, options: groupOptions, label: "Group")
                    
                    // Notification Toggle
                    HStack {
                        Text("Send Push Notification")
                            .font(.title2)
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("", isOn: $sendNotification)
                            .labelsHidden()
                    }
                    
                    // Type Button
                    OptionButtonView(viewModel: viewModel, selectedPersons: $selectedPersons, showMenu: $showTypeMenu, selectedOption: $selectedType, options: typeOptions, label: "Type")
                    
                    // Date Picker
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.all, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    // Picture Capture
                    HStack {
//                        Text("Picture")
//                            .font(.title2)
////                        Spacer()
//                        Button(action: {
//                            isCameraPresented = true
//                        }) {
//                            Image(systemName: "camera")
//                                .font(.title)
//                                .padding(.all, 10)
//                                .background(Color.blue.opacity(0.6))
//                                .cornerRadius(10)
//                        }
//                        .sheet(isPresented: $isCameraPresented) {
//                            ImagePickerView(selectedImage: $selectedImage, sourceType: .camera)
//                        }
                        Text("Picture")
                            .font(.title2)
                        Button(action: {
                            showImagePickerActionSheet = true
                        }) {
                            Image(systemName: "camera")
                                .font(.title)
                                .padding(.all, 10)
                                .background(Color.blue.opacity(0.6))
                                .cornerRadius(10)
                        }
                        .actionSheet(isPresented: $showImagePickerActionSheet) {
                            ActionSheet(title: Text("Select Image Source"), buttons: [
                                .default(Text("Camera")) {
                                    isCameraPresented = true
                                    sourceType = .camera
                                },
                                .default(Text("Photo Library")) {
                                    isCameraPresented = true
                                    sourceType = .photoLibrary
                                },
                                .cancel()
                            ])
                        }
                        .sheet(isPresented: $isCameraPresented) {
                            ImagePickerView(selectedImage: $selectedImage, sourceType: sourceType)
                        }
                        
                        Button(action: sendButtonTapped) {
                                Spacer()
    //                            Text("Share")
    //                                .font(.title2)
    //                                .foregroundColor(.white)
                                Image(systemName: "paperplane.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.all, 10)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    
                }
                .padding(.all, 20)
            }
        }
    
    func uploadImageToFirebase(_ image: UIImage, completion: @escaping (String?) -> Void) {
        // Example Firebase Storage logic for uploading an image

        let storageRef = Storage.storage().reference().child("Thelyx_Data/\(UUID().uuidString).jpg")
        if let uploadData = image.jpegData(compressionQuality: 0.8) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("Error uploading image:", error!)
                    completion(nil)
                    return
                }

                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Error getting the download URL:", error!)
                        completion(nil)
                        return
                    }
                    completion(downloadURL.absoluteString)
                }
            }
        }
    }



//    func sendButtonTapped() {
//        // Cosmos DB
//        guard let currentUserId = Auth.auth().currentUser?.uid else {
//            print("No user is logged in")
//            return
//        }
//        // Firebase Firestore
//        let db = Firestore.firestore()
//
//        // Data to save:
//        var firebaseEventData: [String: Any] = [
//            "group": selectedGroup,
//            "type": selectedType,
//            "date": Timestamp(date: selectedDate),
//            "userId": currentUserId
//        ]
//
//        var contactsArray: [[String: Any]] = []
//
//        for person in selectedPersons {
//            let contactData: [String: Any] = [
//                "firstName": person.first,
//                "lastName": person.last,
//                "phoneNumber": person.phoneNumber,
//                "userID": person.userID
//            ]
//            contactsArray.append(contactData)
//        }
//
//        firebaseEventData["contacts"] = contactsArray
//
//        // Save event to the user's specific events sub-collection
//        let userRef = db.collection("users").document(currentUserId)
//        userRef.collection("events").addDocument(data: firebaseEventData) { error in
//            if let error = error {
//                print("Firebase Error adding document: \(error)")
//            } else {
//                print("Firebase Document successfully added!")
//            }
//        }
//
//
//        userRef.collection("feed_in").addDocument(data: firebaseEventData) { error in
//                if let error = error {
//                    print("Firebase Error adding document to feed_in: \(error)")
//                } else {
//                    print("Firebase Document successfully added to feed_in!")
//
//                    for contact in contactsArray {
//                        if let contactUserID = contact["userID"] as? String, !contactUserID.isEmpty, contactUserID != "N/A" {
//                            let contactRef = db.collection("users").document(contactUserID)
//                            contactRef.collection("feed_out").addDocument(data: firebaseEventData) { error in
//                                if let error = error {
//                                    print("Firebase Error adding document to feed_out of user \(contactUserID): \(error)")
//                                } else {
//                                    print("Firebase Document successfully added to feed_out of user \(contactUserID)!")
//                                }
//                            }
//                        }
//                    }
//
//                }
//            }
//    }
    func sendButtonTapped() {
        // Check for a logged-in user
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }

        if let selectedImage = selectedImage {
            uploadImageToFirebase(selectedImage) { imageUrl in
                guard let imageUrl = imageUrl else {
                    print("Error uploading image to Firebase")
                    return
                }

                // Data to save:
                var firebaseEventData: [String: Any] = [
                    "group": selectedGroup,
                    "type": selectedType,
                    "date": Timestamp(date: selectedDate),
                    "userId": currentUserId,
                    "imageUrl": imageUrl
                ]

                self.saveEventToFirestore(firebaseEventData)
            }
        } else {
            // If there is no image selected:
            var firebaseEventData: [String: Any] = [
                "group": selectedGroup,
                "type": selectedType,
                "date": Timestamp(date: selectedDate),
                "userId": currentUserId
            ]
            
            self.saveEventToFirestore(firebaseEventData)
        }
    }

    func saveEventToFirestore(_ eventData: [String: Any]) {
        var firebaseEventData = eventData

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
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(firebaseEventData["userId"] as! String)

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






import SwiftUI
import Firebase
import FirebaseAuth

struct PlusScreenView: View {
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

    var body: some View {
        VStack(alignment: .leading) {
            Text("New Event")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 30)
                .padding(.leading, 20)

            OptionButtonView(showMenu: $showGroupMenu, selectedOption: $selectedGroup, options: groupOptions, label: "Group")
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

            OptionButtonView(showMenu: $showTypeMenu, selectedOption: $selectedType, options: typeOptions, label: "Type")
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
                Text("Send")
                    .font(.title2)
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
        let db = Firestore.firestore()

        // Ensure user is logged in
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user is logged in")
            return
        }

        // Data to save:
        let eventData: [String: Any] = [
            "group": selectedGroup,
            "type": selectedType,
            "date": Timestamp(date: selectedDate),
            "userId": userId  // Associate with the current user
        ]

        // Save event to the user's specific events sub-collection
        let userRef = db.collection("users").document(userId)
        userRef.collection("events").addDocument(data: eventData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document successfully added!")
            }
        }
    }
}

struct OptionButtonView: View {
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


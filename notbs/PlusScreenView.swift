
import SwiftUI

struct PlusScreenView: View {
    @State private var showGroupMenu = false
    let groupOptions = ["Friends", "Family", "Personal", "Private", "Custom Group"]
    @State private var selectedGroup = ""

    @State private var showTypeMenu = false
    let typeOptions = ["Injury", "Doctor Visit", "Medicine", "Fitness"]
    @State private var selectedType = ""

    @State private var sendNotification = false

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
                    .labelsHidden() // This hides the default (empty) label of the Toggle
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            OptionButtonView(showMenu: $showTypeMenu, selectedOption: $selectedType, options: typeOptions, label: "Type")
                .padding(.top, 20)

            Spacer()

            HStack {
                Text("Picture")
                    .font(.title2)
                    .padding(.leading, 20)

                Button(action: {
                    // Access the camera
                }) {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                        .padding(20)
                        .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.blue.opacity(0.4)))
                }
                .padding(.leading)
            }
            .padding(.bottom, 20)
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


import SwiftUI
import FirebaseAuth




struct QRCodeView: View {
    
    // Fetch the saved data from UserDefaults
    var name: String = UserDefaults.standard.string(forKey: "userName") ?? "Unknown Name"
    var birthdate: Date = UserDefaults.standard.object(forKey: "userBirthdate") as? Date ?? Date()

    // Date formatter for formatting the birthdate and appointment date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        VStack {
            Text(name)
                .font(.custom("Cochin", size: 30))
                .fontWeight(.bold)

            Text("Date of Birth: \(dateFormatter.string(from: birthdate))")
                .font(.custom("Cochin", size: 20))
                .padding(.top, 10)

            // You can adjust this to fetch from UserDefaults as well if you save appointment data
            Text("Birthdate, \(dateFormatter.string(from: Date()))")
                .font(.custom("Cochin", size: 20))
                .padding(.top, 10)

            Image("QRCode")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.top, 20)
        }
        .padding()
    }
}


struct HumanScreenView: View {
    @State private var showingQRCode = false
    @State private var userName: String = "Unknown Name" // Default value

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.blue)
                            .font(.custom("Cochin", size: 30))
                            .padding(.leading)
                    }

                    Spacer()

                    Text("Dash Board").font(.custom("Cochin", size: 30))
                    
                    Spacer()
                    
                    // Placeholder to ensure Dashboard remains centered
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.clear)
                        .font(.custom("Cochin", size: 30))
                        .padding(.trailing)
                }
                .padding(.top)
                
                Button(action: {
                    self.showingQRCode = true
                }) {
                    VStack {
                        Text(userName) // Use the @State property here
                            .font(.custom("Cochin", size: 30))
                            .foregroundColor(.black)
                        Text("Click to view health card")
                            .font(.custom("Cochin", size: 15))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.7)))
                }
                .sheet(isPresented: $showingQRCode) {
                    QRCodeView()
                }
                .padding()

                VStack {
                    NavigationCard(systemImageName: "pills", title: "Medicine Cabinet", destination: MedicineCabinetView())
                    NavigationCard(systemImageName: "book.fill", title: "Manage Contacts", destination: ContactsView())
                    // Uncomment the line below if you want to include Medical Visits
                    // NavigationCard(systemImageName: "heart.text.square", title: "Medical Visits", destination: MedicalVisitsView())
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear(perform: loadUserName) // Call the loadUserName function when the view appears
        }
    }

    func loadUserName() {
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? "Unknown Name"
    }
}


struct NavigationCard<Destination: View>: View {
    let systemImageName: String
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: systemImageName)
                    .font(.custom("Cochin", size: 30))
                    .foregroundColor(.blue)
                    .padding()
                Text(title)
                    .font(.custom("Cochin", size: 30))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        }
        .padding(.bottom)
    }
}

struct HumanScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HumanScreenView()
    }
}

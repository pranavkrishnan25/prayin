
import SwiftUI
import FirebaseAuth


struct QRCodeView: View {
    var body: some View {
        VStack {
            Text("Pranav Krishnan")
                .font(.title)
                .fontWeight(.bold)

            Text("Date of Birth: 01-01-1990")
                .font(.body)
                .padding(.top, 10)

            Text("Appointment: 3:30 PM, 7/11/23")
                .font(.body)
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

    var body: some View {
        NavigationView {
            VStack {
//                Text("Dash Board")
//                    .font(.title)
//                    .padding(.top)
//
//                Spacer()
//
//                NavigationLink(destination: SettingsView()) {
//                                     Image(systemName: "gearshape.fill")
//                                         .foregroundColor(.blue)
//                                         .font(.title)
//                                         .padding(.trailing)
//                }
//
                HStack {
                        NavigationLink(destination: SettingsView()) {
                                        Image(systemName: "gearshape.fill")
                                            .foregroundColor(.blue)
                                            .font(.title)
                                            .padding(.leading)
                        }

                    Spacer()

                    Text("Dash Board").font(.title)
                    
                    Spacer()
                    
                    // Placeholder to ensure Dashboard remains centered
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.clear)
                        .font(.title)
                        .padding(.trailing)
                }
                    
                    .padding(.top)
                Button(action: {
                    self.showingQRCode = true
                }) {
                    VStack {
                        Text("Maanav Karamchandani")
                            .font(.title)
                            .foregroundColor(.black)
                        Text("Click to view health card")
                            .font(.subheadline)
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
//                    NavigationCard(systemImageName: "heart.text.square", title: "Medical Visits", destination: MedicalVisitsView())

                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
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
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .padding()
                Text(title)
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

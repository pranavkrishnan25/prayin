//
//
//
//import SwiftUI
//
//struct HumanScreenView: View {
//    @EnvironmentObject var eventViewModel: EventViewModel
//
//    @State private var selectedGraph = 0
//    @State private var showingQRCode = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    Image(systemName: "person.circle")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .padding()
//
//                    Button(action: {
//                        self.showingQRCode = true
//                    }) {
//                        VStack(alignment: .leading) {
//                            Text("Pranav Krishnan")
//                                .font(.title)
//                                .foregroundColor(.black)
//                        }
//                    }
//                    .sheet(isPresented: $showingQRCode) {
//                        QRCodeView()
//                    }
//
//                    Spacer()
//
//                    NavigationLink(destination: SettingsView()) {
//                        Image(systemName: "gearshape.fill")
//                            .foregroundColor(.blue)
//                            .font(.title)
//                            .padding()
//                    }
//                }
//                .background(RoundedRectangle(cornerRadius: 20)
//                                .fill(Color.white.opacity(0.7)))
//                .padding()
//
//                HStack {
//                    NavigationLink(destination: PersonalLedgerView()) {
//                        VStack {
//                            Image(systemName: "book.fill")
//                                .font(.largeTitle)
//                                .foregroundColor(.blue)
//                            Text("Personal Ledger")
//                                .foregroundColor(.black)
//                        }
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
//                    }
//
//                    NavigationLink(destination: MedicalVisitsView()) {
//                        VStack {
//                            Image(systemName: "heart.text.square")
//                                .font(.largeTitle)
//                                .foregroundColor(.blue)
//                            Text("Medical Visits")
//                                .foregroundColor(.black)
//                        }
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
//                    }
//
//                    NavigationLink(destination: MedicineCabinetView()) {
//                        VStack {
//                            Image(systemName: "pills")
//                                .font(.largeTitle)
//                                .foregroundColor(.blue)
//                            Text("Medicine Cabinet")
//                                .foregroundColor(.black)
//                        }
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
//                    }
//                }
//                .padding()
//
//                Text("Activity")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .padding(.top, 10)
//
//                Picker("", selection: $selectedGraph) {
//                    Text("Glucose Level").tag(0)
//                    Text("Blood Oxygen").tag(1)
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//
//                if selectedGraph == 0 {
//                    GraphView(color: .blue)
//                } else {
//                    GraphView(color: .red)
//                }
//
//                Spacer()
//            }
//            .navigationBarTitle("")
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//
//
//struct QRCodeView: View {
//    var body: some View {
//        VStack {
//            Text("Pranav Krishnan")
//                .font(.title)
//                .fontWeight(.bold)
//
//            Text("Date of Birth: 01-01-1990")
//                .font(.body)
//                .padding(.top, 10)
//
//            Text("Appointment: 3:30 PM, 7/11/23")
//                .font(.body)
//                .padding(.top, 10)
//
//            Image("QRCode")
//                .resizable()
//                .scaledToFit()
//                .frame(height: 200)
//                .padding(.top, 20)
//        }
//        .padding()
//    }
//}
//
//struct HumanScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        HumanScreenView()
//    }
//}


import SwiftUI
import FirebaseAuth


struct HumanScreenView: View {
    @State private var selectedGraph = 0
    @State private var showingQRCode = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()

                    Button(action: {
                        self.showingQRCode = true
                    }) {
                        VStack(alignment: .leading) {
                            Text("Pranav Krishnan")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                    .sheet(isPresented: $showingQRCode) {
                        QRCodeView()
                    }

                    Spacer()

                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                            .padding()
                    }
                }
                .background(RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.7)))
                .padding()

                if let userId = Auth.auth().currentUser?.uid {
                    let viewModel = EventViewModel(userId: userId)
                    NavigationLink(destination: PersonalLedgerView().environmentObject(viewModel)) {
                        VStack {
                            Image(systemName: "book.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Personal Ledger")
                                .foregroundColor(.black)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
                    }
                }

                NavigationLink(destination: MedicalVisitsView()) {
                    VStack {
                        Image(systemName: "heart.text.square")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text("Medical Visits")
                            .foregroundColor(.black)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
                }

                NavigationLink(destination: MedicineCabinetView()) {
                    VStack {
                        Image(systemName: "pills")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text("Medicine Cabinet")
                            .foregroundColor(.black)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
                }
                .padding()

                Text("Activity")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                Picker("", selection: $selectedGraph) {
                    Text("Glucose Level").tag(0)
                    Text("Blood Oxygen").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                if selectedGraph == 0 {
                    GraphView(color: .blue)
                } else {
                    GraphView(color: .red)
                }

                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

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

struct HumanScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HumanScreenView()
    }
}

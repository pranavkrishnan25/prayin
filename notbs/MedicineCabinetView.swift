//
//  MedicineCabinetView.swift
//  notbs
//
//  Created by Pranav Krishnan on 7/16/23.
//

//import SwiftUI
//import MapKit
//
//struct MedicineCabinetView: View {
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//    let medicines = ["Synthroid", "Lipitor", "Glucophage", "Zocor", "Prilosec", "Norvasc", "Lopressor", "Acetaminophen", "Ventolin"]
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 35.9132, longitude: -79.0558),
//        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//    )
//
//    var body: some View {
//        VStack {
//            Text("Medicine Cabinet")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                ForEach(0..<medicines.count, id: \.self) { index in
//                    VStack {
//                        Image(systemName: "pills")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(colors[index % colors.count])
//                        Text(medicines[index])
//                            .font(.caption)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                }
//            }
//            .padding()
//
//            Text("Closest Pharmacies")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.top, 15)
//
//            // Map view
//            Map(coordinateRegion: $region)
//                .cornerRadius(10)
//                .padding()
//                .frame(height: 200)
//
//            Spacer()
//        }
//    }
//}

struct MedicineCabinetView_Previews: PreviewProvider {

    static var previews: some View {
        MedicineCabinetView()
    }
}

import SwiftUI
import MapKit

struct MedicineCabinetView: View {
//    @State private var newMedicine = ""
//    @State private var medicines = UserDefaults.standard.arrayValue(forKey: "medicines")
    @State private var newMedicine = ""
    @State private var isAddingMedicine = false
//    var medicines: [String] {
//        get {
//            UserDefaults.standard.arrayValue(forKey: "medicines")
//        }
//        set {
//            UserDefaults.standard.setArray(newValue, forKey: "medicines")
//        }
//    }
    @State private var medicines: [String] = UserDefaults.standard.arrayValue(forKey: "medicines")

    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
    
//    @State private var medicines: [Medicine] = Medicine.loadFromUserDefaults()

//    @State private var newMedicineName = ""
//    @State private var newMedicineDose = ""
//
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.9132, longitude: -79.0558),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        VStack {
            Text("Medicine Cabinet")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 15)
            
            Button(action: {
                self.isAddingMedicine.toggle()
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 10)
            
            if isAddingMedicine {
                VStack {
                    TextField("Medicine Name", text: $newMedicine)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                    
//                    TextField("Medicine Dose", text: $newMedicineDose)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.bottom, 10)
                    
                    Button("Add Medicine") {
                        if !newMedicine.isEmpty {
                            medicines.append(newMedicine)
                            UserDefaults.standard.setArray(medicines, forKey: "medicines")
                            newMedicine = ""
                        }
//                        let medicine = Medicine(name: newMedicineName, dose: newMedicineDose)
//                        medicines.append(medicine)
//                        Medicine.saveToUserDefaults(medicines: medicines)
//
//                        newMedicineName = ""
//                        newMedicineDose = ""
//                        isAddingMedicine = false
                        
                    }
                    .padding(.bottom, 10)
                }
                .padding()
            }
            
            
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
//                ForEach(medicines, id: \.id) { medicine in
//                    VStack {
//                        Image(systemName: "pills")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(colors.randomElement() ?? .blue)
//                        Text(medicine.name)
//                            .font(.caption)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                }
//            }
//            .padding()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(medicines, id: \.self) { medicine in
                    VStack {
                        Image(systemName: "pills")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(colors.randomElement() ?? .blue)
                        Text(medicine)
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
                }
            }
            .padding()
            
            Text("Closest Pharmacies")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 15)

            // Map view
            Map(coordinateRegion: $region)
                .cornerRadius(10)
                .padding()
                .frame(height: 200)

            Spacer()
        }
        .onAppear {
            // Refresh medicines from UserDefaults when the view appears
            self.medicines = UserDefaults.standard.arrayValue(forKey: "medicines")
        }
    }
}

//struct Medicine: Identifiable, Codable {
//    var id = UUID()
//    var name: String
//    var dose: String
//
//    static func loadFromUserDefaults() -> [Medicine] {
//        let userDefaults = UserDefaults.standard
//
//        guard let savedData = userDefaults.data(forKey: "medicines"),
//              let decodedMedicines = try? JSONDecoder().decode([Medicine].self, from: savedData) else {
//            return []
//        }
//
//        return decodedMedicines
//    }
//
//    static func saveToUserDefaults(medicines: [Medicine]) {
//        if let encodedData = try? JSONEncoder().encode(medicines) {
//            UserDefaults.standard.set(encodedData, forKey: "medicines")
//        }
//    }
//}

extension UserDefaults {
    func setArray(_ array: [String], forKey key: String) {
        set(array, forKey: key)
    }

    func arrayValue(forKey key: String) -> [String] {
        return stringArray(forKey: key) ?? []
    }
}

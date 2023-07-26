//
//  MedicineCabinetView.swift
//  notbs
//
//  Created by Pranav Krishnan on 7/16/23.
//

import SwiftUI


//struct MedicineCabinetView: View {
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//    let medicines = ["Synthroid", "Lipitor", "Glucophage", "Zocor", "Prilosec", "Norvasc", "Lopressor", "Acetaminophen", "Ventolin"]
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
//        }
//    }
//}

import SwiftUI
import MapKit

struct MedicineCabinetView: View {
    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
    let medicines = ["Synthroid", "Lipitor", "Glucophage", "Zocor", "Prilosec", "Norvasc", "Lopressor", "Acetaminophen", "Ventolin"]
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

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20) {
                ForEach(0..<medicines.count, id: \.self) { index in
                    VStack {
                        Image(systemName: "pills")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(colors[index % colors.count])
                        Text(medicines[index])
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
    }
}

struct MedicineCabinetView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineCabinetView()
    }
}


////
////  MedicalVisitsView.swift
////  notbs
////
////  Created by Pranav Krishnan on 7/16/23.
////
//
//import SwiftUI
//
//struct MedicalVisitsView: View {
//    @State private var visitType = 0
//    var body: some View {
//        Form {
//            Section(header: Text("Primary Care Provider")) {
//                TextField("Primary Care Provider", text: .constant("Dr. John Smith"))
//            }
//            Section(header: Text("Hospital")) {
//                TextField("Hospital", text: .constant("City Hospital"))
//            }
//            Section(header: Text("Type of Visit")) {
//                Picker("Visit Type", selection: $visitType) {
//                    Text("Emergency").tag(0)
//                    Text("Annual").tag(1)
//                    Text("Injury").tag(2)
//                    Text("Illness").tag(3)
//                }.pickerStyle(SegmentedPickerStyle())
//            }
//            Section(header: Text("Most Recent Checkup")) {
//                DatePicker("Date", selection: .constant(Date()), displayedComponents: .date)
//                DatePicker("Time", selection: .constant(Date()), displayedComponents: .hourAndMinute)
//            }
//        }
//    }
//}
//
//struct MedicalVisitsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalVisitsView()
//    }
//}

import SwiftUI

struct MedicalVisitsView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Medical History")
                    .font(.largeTitle)
                    .padding()
                
                SearchBarView() // Custom view for search bar
                
                SectionTitle(title: "Body Measurements")
                MeasurementsView()
                
                SectionTitle(title: "Medical Visits")
                MedicalVisitView(title: "Physical Therapy Week 6", subtitle: "Part of ACL Recovery")
                MedicalVisitView(title: "Physical Check Up", subtitle: "Part of General Health")
                
                SectionTitle(title: "Hospital Visits")
                // You can add the content for hospital visits here.
                
                Spacer()
            }
        }
    }
}

struct SearchBarView: View {
    @State private var searchText = ""
    
    var body: some View {
        TextField("Search History", text: $searchText)
            .padding(.all, 10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding()
    }
}

struct SectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.horizontal)
            .padding(.vertical, 10)
    }
}

struct MeasurementsView: View {
    var body: some View {
        HStack {
            MeasurementTile(title: "Cholesterol")
            MeasurementTile(title: "BMI")
            MeasurementTile(title: "EKG")
        }
        .padding(.horizontal)
    }
}

struct MeasurementTile: View {
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: "stethoscope") // Placeholder
                .resizable()
                .frame(width: 60, height: 60)
            Text(title)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct MedicalVisitView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Button(action: {}) {
                Text("View")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct MedicalVisitsView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalVisitsView()
    }
}


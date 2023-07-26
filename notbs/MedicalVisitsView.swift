//
//  MedicalVisitsView.swift
//  notbs
//
//  Created by Pranav Krishnan on 7/16/23.
//

import SwiftUI

struct MedicalVisitsView: View {
    @State private var visitType = 0
    var body: some View {
        Form {
            Section(header: Text("Primary Care Provider")) {
                TextField("Primary Care Provider", text: .constant("Dr. John Smith"))
            }
            Section(header: Text("Hospital")) {
                TextField("Hospital", text: .constant("City Hospital"))
            }
            Section(header: Text("Type of Visit")) {
                Picker("Visit Type", selection: $visitType) {
                    Text("Emergency").tag(0)
                    Text("Annual").tag(1)
                    Text("Injury").tag(2)
                    Text("Illness").tag(3)
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Most Recent Checkup")) {
                DatePicker("Date", selection: .constant(Date()), displayedComponents: .date)
                DatePicker("Time", selection: .constant(Date()), displayedComponents: .hourAndMinute)
            }
        }
    }
}

struct MedicalVisitsView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalVisitsView()
    }
}

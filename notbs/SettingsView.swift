//
//  SettingsView.swift
//  notbs
//
//  Created by Pranav Krishnan on 7/16/23.
//

import SwiftUI

struct SettingsView: View {
    @State var name: String = "Pranav Krishnan"
    @State var weight: String = ""
    @State var age: String = ""
    @State var birthdate = Date()

    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                TextField("Weight", text: $weight)
                DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
            }

            Section(header: Text("Privacy Settings")) {
                Toggle(isOn: .constant(true)) {
                    Text("Enable biometrics")
                }

                Toggle(isOn: .constant(false)) {
                    Text("Use location")
                }
            }
        }
        .navigationTitle("Settings")
    }
}


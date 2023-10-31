////
////  SettingsView.swift
////  notbs
////
////  Created by Pranav Krishnan on 7/16/23.
////
//
//import SwiftUI
//
//struct SettingsView: View {
//    @State var name: String = "Pranav Krishnan"
//    @State var weight: String = ""
//    @State var age: String = ""
//    @State var birthdate = Date()
//
//    var body: some View {
//        Form {
//            Section(header: Text("Personal Information")) {
//                TextField("Name", text: $name)
//                TextField("Age", text: $age)
//                TextField("Weight", text: $weight)
//                DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
//            }
//
//            Section(header: Text("Privacy Settings")) {
//                Toggle(isOn: .constant(true)) {
//                    Text("Enable biometrics")
//                }
//
//                Toggle(isOn: .constant(false)) {
//                    Text("Use location")
//                }
//            }
//        }
//        .navigationTitle("Settings")
//    }
//}
//

import SwiftUI

//struct SettingsView: View {
//    @State var name: String = UserDefaults.standard.string(forKey: "userName") ?? "Pranav Krishnan"
//    @State var age: String = UserDefaults.standard.string(forKey: "userAge") ?? ""
//    @State var weight: String = UserDefaults.standard.string(forKey: "userWeight") ?? ""
//    @State var birthdate: Date = UserDefaults.standard.object(forKey: "userBirthdate") as? Date ?? Date()
//
//    var body: some View {
//        Form {
//            Section(header: Text("Personal Information")) {
//                TextField("Name", text: $name.onChange {
//                    UserDefaults.standard.set($0, forKey: "userName")
//                })
//                TextField("Age", text: $age.onChange {
//                    UserDefaults.standard.set($0, forKey: "userAge")
//                })
//                TextField("Weight", text: $weight.onChange {
//                    UserDefaults.standard.set($0, forKey: "userWeight")
//                })
//                DatePicker("Birthdate", selection: $birthdate.onChange {
//                    UserDefaults.standard.set($0, forKey: "userBirthdate")
//                }, displayedComponents: .date)
//            }
//
//            Section(header: Text("Privacy Settings")) {
//                Toggle(isOn: .constant(true)) {
//                    Text("Enable biometrics")
//                }
//                Toggle(isOn: .constant(false)) {
//                    Text("Use location")
//                }
//            }
//        }
//        .navigationTitle("Settings")
//    }
//}

import SwiftUI

//struct SettingsView: View {
//    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? "Pranav Krishnan"
//    @State private var age: String = UserDefaults.standard.string(forKey: "userAge") ?? ""
//    @State private var weight: String = UserDefaults.standard.string(forKey: "userWeight") ?? ""
//    @State private var birthdate: Date = UserDefaults.standard.object(forKey: "userBirthdate") as? Date ?? Date()
//
//    var body: some View {
//        Form {
//            Section(header: Text("Personal Information")) {
//                TextField("Name", text: $name)
//                TextField("Age", text: $age)
//                TextField("Weight", text: $weight)
//                DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
//            }
//
//            Section(header: Text("Privacy Settings")) {
//                Toggle(isOn: .constant(true)) {
//                    Text("Enable biometrics")
//                }
//
//                Toggle(isOn: .constant(false)) {
//                    Text("Use location")
//                }
//            }
//        }
//        .navigationTitle("Settings")
//        .onDisappear(perform: saveData)
//    }
//
//    func saveData() {
//        UserDefaults.standard.set(name, forKey: "userName")
//        UserDefaults.standard.set(age, forKey: "userAge")
//        UserDefaults.standard.set(weight, forKey: "userWeight")
//        UserDefaults.standard.set(birthdate, forKey: "userBirthdate")
//    }
//
//}
import SwiftUI

//struct SettingsView: View {
//    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
//    @State private var age: String = UserDefaults.standard.string(forKey: "userAge") ?? ""
//    @State private var weight: String = UserDefaults.standard.string(forKey: "userWeight") ?? ""
//    @State private var birthdate: Date = UserDefaults.standard.object(forKey: "userBirthdate") as? Date ?? Date()
//
//    var body: some View {
//        Form {
//            Section(header: Text("Personal Information")) {
//                TextField("Name", text: $name)
//                TextField("Age", text: $age)
//                TextField("Weight", text: $weight)
//                DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
//            }
//
//            Section(header: Text("Privacy Settings")) {
//                Toggle(isOn: .constant(true)) {
//                    Text("Enable biometrics")
//                }
//
//                Toggle(isOn: .constant(false)) {
//                    Text("Use location")
//                }
//            }
//
//            Section {
//                Button("Submit") {
//                    saveData()
//                }
//            }
//        }
//        .navigationTitle("Settings")
//    }
//
//    func saveData() {
//        UserDefaults.standard.set(name, forKey: "userName")
//        UserDefaults.standard.set(age, forKey: "userAge")
//        UserDefaults.standard.set(weight, forKey: "userWeight")
//        UserDefaults.standard.set(birthdate, forKey: "userBirthdate")
//    }
//}

import SwiftUI

struct SettingsView: View {
    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @State private var age: String = UserDefaults.standard.string(forKey: "userAge") ?? ""
    @State private var weight: String = UserDefaults.standard.string(forKey: "userWeight") ?? ""
    @State private var birthdate: Date = UserDefaults.standard.object(forKey: "userBirthdate") as? Date ?? Date()

    var body: some View {
        VStack {
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

            Button(action: saveData) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
        }
        .navigationTitle("Settings")
    }
    
    func saveData() {
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(age, forKey: "userAge")
        UserDefaults.standard.set(weight, forKey: "userWeight")
        UserDefaults.standard.set(birthdate, forKey: "userBirthdate")
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

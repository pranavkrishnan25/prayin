

// Azure B2C Config
//let kTenantName = "thelyx.onmicrosoft.com"
//let kAuthorityHostName = "thelyx.b2clogin.com"
//let kClientID = "d6f0b68e-0706-40b5-a060-3a5f80b385f0"
//let kRedirectUri = "msauth.com.microsoft.identitysample.MSALiOS://auth"
//let kSignupOrSigninPolicy = "your-signup-or-signin-policy-id-here"
//let kEditProfilePolicy = "your-edit-profile-policy-id-here"
//let kGraphURI = "https://contoso.azurewebsites.net/hello"
//let kScopes: [String] = ["scope1", "scope2"]

import SwiftUI
import FirebaseAuth
import FirebaseFirestore


struct LaunchScreenView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var navigation: Int? = nil
    @State var visible = false
    @State var loginError: String = ""
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)

    var body: some View {
        NavigationView {
            VStack {
                Image("thelyx")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                Image("blue_diamond_texture")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)

                Text("Sign in to your account")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color.blue)
                    .padding(.top, 15)

                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                    .padding(.top, 0)

                HStack(spacing: 15){
                    VStack{
                        if self.visible {
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                        } else {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                        }
                    }

                    Button(action: {
                        self.visible.toggle()
                    }) {
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(Color.black.opacity(0.7))
                            .opacity(0.8)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).stroke(borderColor, lineWidth: 2))
                .padding(.top, 10)

                Button(action: {
                    self.login()
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color.blue)
                .cornerRadius(6)
                .padding(.top, 15)

                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }

                Spacer()

                NavigationLink(tag: 1, selection: $navigation) {
                    SignUpView()
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }

                NavigationLink(tag: 2, selection: $navigation) {
                    ContentView() // Your main content view
                } label: {
                    Text("Continue as Guest")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 25)
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: self.username, password: self.password) { (result, error) in
            if let error = error {
                self.loginError = error.localizedDescription
            } else {
                self.navigation = 2 // Redirect to ContentView
            }
        }
    }
}



struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var repass: String = ""
    @State var phoneNumber: String = "" // Added phone number state variable
    @State var visible = false
    @State var revisible = false
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)

    var body: some View {
        VStack(alignment: .leading){
            GeometryReader{ _ in
                VStack{
                    Image("thelyx")
                        .resizable()
                        .frame(width: 300.0, height: 255.0, alignment: .center)

                    Text("Sign up a new account")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color.blue)
                        .padding(.top, 15)

                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                        .padding(.top, 0)

                    // Phone Number TextField
//                    TextField("Phone Number", text: $phoneNumber)
//                        .keyboardType(.numberPad)
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
//                        .padding(.top, 0)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .onChange(of: phoneNumber) { newValue in
                            formatPhoneNumber()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                        .padding(.top, 0)
                    
                    passwordField(isRepass: false)
                    passwordField(isRepass: true)

                    Button(action: {
                        print("Sign up when button pressed")
                        self.register()
                    }) {
                        Text("Sign up")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color.blue)
                    .cornerRadius(6)
                    .padding(.top, 15)
                }
                .padding(.horizontal, 25)
            }
        }
    }
    
    func formatPhoneNumber() {
        if phoneNumber.count == 3 || phoneNumber.count == 7 {
            phoneNumber += "-"
        }
        if phoneNumber.count > 12 { // Limit to 12 characters: 111-333-4444
            phoneNumber = String(phoneNumber.prefix(12))
        }
    }

    func passwordField(isRepass: Bool) -> some View {
        HStack(spacing: 15){
            VStack{
                if isRepass ? self.revisible : self.visible {
                    TextField(isRepass ? "Confirm Password" : "Password", text: isRepass ? $repass : $password)
                        .autocapitalization(.none)
                } else {
                    SecureField(isRepass ? "Confirm Password" : "Password", text: isRepass ? $repass : $password)
                        .autocapitalization(.none)
                }
            }

            Button(action: {
                if isRepass {
                    self.revisible.toggle()
                } else {
                    self.visible.toggle()
                }
            }) {
                Image(systemName: (isRepass ? self.revisible : self.visible) ? "eye.slash.fill" : "eye.fill")
                    .opacity(0.8)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).stroke(self.borderColor, lineWidth: 2))
        .padding(.top, 10)
    }

    func register() {
        if password != repass {
            print("Passwords do not match") // You can also display an error message here
            return
        }

        Auth.auth().createUser(withEmail: self.username, password: self.password) { (result, error) in
            if let error = error {
                print("Registration error: \(error.localizedDescription)") // Again, you can display this in a better way
            } else if let userId = result?.user.uid {
                // Registration was successful, store the phone number in Firestore
                let db = Firestore.firestore()
                db.collection("users").document(userId).setData([
                    "email": self.username,
                    "Password": self.password, // Storing passwords in Firestore is not recommended. Consider removing this.
                    "Phone Number": self.phoneNumber
                ]) { error in
                    if let error = error {
                        print("Error saving user data to Firestore: \(error.localizedDescription)")
                    } else {
                        print("User data saved successfully!")
                    }
                }
            }
        }
    }
}

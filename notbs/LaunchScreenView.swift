//
//
//import SwiftUI
//import FirebaseAuth
//
//struct LaunchScreenView: View {
//    @State var username: String = ""
//    @State var password: String = ""
//    @State var navigation: Int? = nil
//    @State var visible = false
//    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Image("thelyx")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
//
//                Image("blue_diamond_texture")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 100)
//
//                Text("Sign in to your account")
//                    .font(.title2)
//                    .fontWeight(.medium)
//                    .foregroundColor(Color.blue)
//                    .padding(.top, 15)
//
//                TextField("Username", text: $username)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
//                    .padding(.top, 0)
//
//                HStack(spacing: 15){
//                    VStack{
//                        if self.visible {
//                            SecureField("Password", text: $password)
//                                .autocapitalization(.none)
//                        } else {
//                            TextField("Password", text: $password)
//                                .autocapitalization(.none)
//                        }
//                    }
//
//                    Button(action: {
//                        self.visible.toggle()
//                    }) {
//                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
//                            .foregroundColor(Color.black.opacity(0.7))
//                            .opacity(0.8)
//                    }
//                }
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 6)
//                .stroke(borderColor,lineWidth: 2))
//                .padding(.top, 10)
//
//                NavigationLink(destination: ContentView()) {
//                    Button(action: {
//                        self.login()
//                    }) {
//                        Text("Sign In")
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .padding(.vertical)
//                            .frame(width: UIScreen.main.bounds.width - 50)
//                    }
//                    .background(Color.blue)
//                    .cornerRadius(6)
//                    .padding(.top, 15)
//                }
//
//                Spacer()
//
//                NavigationLink(tag: 1, selection: $navigation) {
//                    SignUpView()
//                } label: {
//                    Button(action: {
//                        self.navigation = 1
//                    }) {
//                        Text("Sign Up")
//                            .foregroundColor(.blue)
//                            .fontWeight(.bold)
//                            .padding(.vertical)
//                            .frame(width: UIScreen.main.bounds.width - 50)
//                    }
//                }
//
//                NavigationLink(tag: 2, selection: $navigation) {
//                    ContentView()
//                } label: {
//                    Button(action: {
//                        self.navigation = 2
//                    }) {
//                        Text("Continue as Guest")
//                            .foregroundColor(.blue)
//                            .fontWeight(.bold)
//                    }
//                }
//            }
//            .padding(.horizontal, 25)
//        }
//    }
//
//    func login() {
//        Auth.auth().signIn(withEmail: self.username, password: self.password) { (result, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//        }
//    }
//}
//
//struct SignUpView: View {
//    @State var username: String = ""
//    @State var password: String = ""
//    @State var repass = ""
//    @State var dateOfBirth = Date()
//    @State var age: String = ""
//    @State var weight: String = ""
//    @State var height: String = ""
//    @State var visible = false
//    @State var revisible = false
//    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
//
//    var body: some View {
//        VStack(alignment: .leading){
//            GeometryReader{_ in
//                VStack{
//                    Image("thelyx").resizable().frame(width: 300.0, height: 255.0, alignment: .center)
//
//                    Image("blue_diamond_texture")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 100)
//
//                    Text("Sign up a new account")
//                        .font(.title2)
//                        .fontWeight(.medium)
//                        .foregroundColor(Color.blue)
//                        .padding(.top, 15)
//
//                    TextField("Username", text: $username)
//                        .autocapitalization(.none)
//                        .padding()
//                        .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
//                        .padding(.top, 0)
//
//                    HStack(spacing: 15){
//                        VStack{
//                            if self.visible {
//                                TextField("Password", text: $password)
//                                    .autocapitalization(.none)
//                            } else {
//                                SecureField("Password", text: $password)
//                                    .autocapitalization(.none)
//                            }
//                        }
//
//                        Button(action: {
//                            self.visible.toggle()
//                        }) {
//                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
//                                .opacity(0.8)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 6)
//                    .stroke(self.borderColor,lineWidth: 2))
//                    .padding(.top, 10)
//
//
//                    // Confirm password
//                    HStack(spacing: 15){
//                        VStack{
//                            if self.revisible {
//                                TextField("Confirm Password", text: self.$repass)
//                                    .autocapitalization(.none)
//                            } else {
//                                SecureField("Confirm Password", text: self.$repass)
//                                    .autocapitalization(.none)
//                            }
//                        }
//
//                        Button(action: {
//                            self.revisible.toggle()
//                        }) {
//                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
//                                .opacity(0.8)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 6)
//                    .stroke(self.borderColor,lineWidth: 2))
//                    .padding(.top, 10)
//
//
//                    // Sign up button
//                    Button(action: {
//                        self.register()
//                    }) {
//                        Text("Sign up")
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .padding(.vertical)
//                            .frame(width: UIScreen.main.bounds.width - 50)
//                    }
//                    .background(Color.blue)
//                    .cornerRadius(6)
//                    .padding(.top, 15)
//                }
//                .padding(.horizontal, 25)
//            }
//        }
//    }
//
//    func register() {
//        Auth.auth().createUser(withEmail: self.username, password: self.password) { (result, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//        }
//    }
//}
//
//struct LaunchScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchScreenView()
//    }
//}
//


import SwiftUI
import FirebaseAuth

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
                .background(RoundedRectangle(cornerRadius: 6)
                .stroke(borderColor,lineWidth: 2))
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
                
                // Display login error message
                if !loginError.isEmpty {
                    Text(loginError)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }

                Spacer()

                NavigationLink(tag: 1, selection: $navigation) {
                    SignUpView()
                } label: {
                    Button(action: {
                        self.navigation = 1
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                }

                NavigationLink(tag: 2, selection: $navigation) {
                    ContentView()
                } label: {
                    Button(action: {
                        self.navigation = 2
                    }) {
                        Text("Continue as Guest")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding(.horizontal, 25)
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: self.username, password: self.password) { (result, error) in
            if error != nil {
                self.loginError = "Incorrect login, please try again"
            } else {
                self.navigation = 2 // Go to ContentView
            }
        }
    }
}

struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var repass = ""
    @State var dateOfBirth = Date()
    @State var age: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    @State var visible = false
    @State var revisible = false
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)

    var body: some View {
        VStack(alignment: .leading){
            GeometryReader{_ in
                VStack{
                    Image("thelyx").resizable().frame(width: 300.0, height: 255.0, alignment: .center)
                    
                    Image("blue_diamond_texture")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)

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

                    HStack(spacing: 15){
                        VStack{
                            if self.visible {
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                            }
                        }

                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .opacity(0.8)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(self.borderColor,lineWidth: 2))
                    .padding(.top, 10)


                    // Confirm password
                    HStack(spacing: 15){
                        VStack{
                            if self.revisible {
                                TextField("Confirm Password", text: self.$repass)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Confirm Password", text: self.$repass)
                                    .autocapitalization(.none)
                            }
                        }

                        Button(action: {
                            self.revisible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .opacity(0.8)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6)
                    .stroke(self.borderColor,lineWidth: 2))
                    .padding(.top, 10)


                    // Sign up button
                    Button(action: {
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
    
    func register() {
        Auth.auth().createUser(withEmail: self.username, password: self.password) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}



struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

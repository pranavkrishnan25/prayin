//
//  ModifiedHumanScreen.swift
//  notbs
//
//  Created by Pranav Krishnan on 8/25/23.
//

import SwiftUI



struct ModifiedHumanScreen_Previews: PreviewProvider {
    static var previews: some View {
        ModifiedHumanScreen()
    }
}

// ... Your existing imports and other code

struct ModifiedHumanScreen: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // ... Your existing ZStacks and other views

                // Personal Ledger Button
                NavigationLink(destination: PersonalLedgerView()) {
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 126, height: 59.91)
                            .background(Color(red: 0.59, green: 0.71, blue: 1))
                            .cornerRadius(30)
                        Text("Personal Ledger")
                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                            .lineSpacing(20)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 126, height: 59.91)
                .offset(x: -138.50, y: -213.54)

                // Medical Visits Button
                NavigationLink(destination: MedicalVisitsView()) {
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 126, height: 59.91)
                            .background(Color(red: 0.59, green: 0.71, blue: 1))
                            .cornerRadius(30)
                        Text("Medical Visits")
                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                            .lineSpacing(20)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 126, height: 59.91)
                .offset(x: -70.50, y: -213.54)

                // Medicine Cabinet Button
                NavigationLink(destination: MedicineCabinetView()) {
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 126, height: 59.91)
                            .background(Color(red: 0.59, green: 0.71, blue: 1))
                            .cornerRadius(30)
                        Text("Medicine Cabinet")
                            .font(Font.custom("Inter", size: 16).weight(.semibold))
                            .lineSpacing(20)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 126, height: 59.91)
                .offset(x: 70.50, y: -213.54)
                
                // ... Your existing ZStacks and other views
            }
        }
    }
}

// Your destination views

// ... Your existing preview code

//struct ModifiedHumanScreen: View {
//  var body: some View {
//    VStack(spacing: 0) {
//      ZStack() {
//        ZStack() {
//          ZStack() {
//            Rectangle()
//              .foregroundColor(.clear)
//              .frame(width: 32, height: 32)
//              .background(Color(red: 0.97, green: 0.97, blue: 0.97))
//              .cornerRadius(8)
//              .offset(x: 0, y: 0)
//            HStack(spacing: 0) {
//              HStack(spacing: 0) {
//
//              }
//              .padding(EdgeInsets(top: 3.33, leading: 0, bottom: 3.33, trailing: 0))
//              .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//            .frame(width: 16, height: 16)
//            .offset(x: 0, y: 0)
//          }
//          .frame(width: 32, height: 32)
//          .offset(x: -92.50, y: 0)
//          Text("Dash Board")
//            .font(Font.custom("Poppins", size: 16).weight(.bold))
//            .lineSpacing(24)
//            .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
//            .offset(x: 61, y: 0)
//        }
//        .frame(width: 217, height: 32)
//        .offset(x: -57, y: -369.50)
//        ZStack() {
//          Rectangle()
//            .foregroundColor(.clear)
//            .frame(width: 378, height: 55)
//            .background(Color(red: 0.71, green: 0.84, blue: 1))
//            .cornerRadius(30)
//            .offset(x: 0, y: 0.50)
//          Text("Click to view health card")
//            .font(Font.custom("Poppins", size: 14).weight(.medium))
//            .lineSpacing(21)
//            .foregroundColor(Color(red: 0.68, green: 0.64, blue: 0.65))
//            .offset(x: -0.50, y: 10.50)
//          Text("Maanav Karamchandani")
//            .font(Font.custom("Inter", size: 16).weight(.semibold))
//            .lineSpacing(20)
//            .foregroundColor(.black)
//            .offset(x: -0.50, y: -9)
//        }
//        .frame(width: 378, height: 56)
//        .offset(x: -10.50, y: -283.50)
//        ZStack() {
//          Rectangle()
//            .foregroundColor(.clear)
//            .frame(width: 126, height: 59.91)
//            .background(Color(red: 0.59, green: 0.71, blue: 1))
//            .cornerRadius(30)
//            .offset(x: 0, y: 0)
//          Text("Personal Ledger")
//            .font(Font.custom("Inter", size: 16).weight(.semibold))
//            .lineSpacing(20)
//            .foregroundColor(.white)
//            .offset(x: 0.17, y: -0.35)
//        }
//        .frame(width: 126, height: 59.91)
//        .offset(x: -138.50, y: -213.54)
//        ZStack() {
//          Rectangle()
//            .foregroundColor(.clear)
//            .frame(width: 126, height: 59.91)
//            .background(Color(red: 0.59, green: 0.71, blue: 1))
//            .cornerRadius(30)
//            .offset(x: -70.50, y: 0)
//          Text("Medical Visits")
//            .font(Font.custom("Inter", size: 16).weight(.semibold))
//            .lineSpacing(20)
//            .foregroundColor(.white)
//            .offset(x: -70.33, y: -0.35)
//          ZStack() {
//            Rectangle()
//              .foregroundColor(.clear)
//              .frame(width: 126, height: 59.91)
//              .background(Color(red: 0.59, green: 0.71, blue: 1))
//              .cornerRadius(30)
//              .offset(x: 0, y: 0)
//            Text("Medicine Cabinet")
//              .font(Font.custom("Inter", size: 16).weight(.semibold))
//              .lineSpacing(20)
//              .foregroundColor(.white)
//              .offset(x: 0.17, y: -0.35)
//          }
//          .frame(width: 126, height: 59.91)
//          .offset(x: 70.50, y: 0)
//        }
//        .frame(width: 267, height: 59.91)
//        .offset(x: 68, y: -213.54)
//        Text("Weekly Pain Level")
//          .font(Font.custom("Poppins", size: 14).weight(.medium))
//          .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
//          .offset(x: 6.50, y: -161)
//        ZStack() {
//          ZStack() {
//            ZStack() {
//              Text("10")
//                .font(Font.custom("Poppins", size: 10.62))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: 0, y: -55)
//              Text("9")
//                .font(Font.custom("Poppins", size: 10.62).weight(.bold))
//                .foregroundColor(Color(red: 0.57, green: 0.64, blue: 0.99))
//                .offset(x: -2, y: -27)
//              Text("8")
//                .font(Font.custom("Poppins", size: 10.62))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -2, y: 0)
//              Text("7")
//                .font(Font.custom("Poppins", size: 10.62))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -2.50, y: 28)
//              Text("6")
//                .font(Font.custom("Poppins", size: 10.62))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -2, y: 55)
//            }
//            .frame(width: 11, height: 126)
//            .offset(x: 144, y: -23)
//            ZStack() {
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 283, height: 0)
//                .overlay(
//                  Rectangle()
//                    .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
//                )
//                .offset(x: 0, y: -68.50)
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 283, height: 0)
//                .overlay(
//                  Rectangle()
//                    .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
//                )
//                .offset(x: 0, y: -40.50)
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 283, height: 0)
//                .overlay(
//                  Rectangle()
//                    .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
//                )
//                .offset(x: 0, y: -13.50)
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 283, height: 0)
//                .overlay(
//                  Rectangle()
//                    .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
//                )
//                .offset(x: 0, y: 13.50)
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 283, height: 0)
//                .overlay(
//                  Rectangle()
//                    .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
//                )
//                .offset(x: 0, y: 41.50)
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 283, height: 0)
//                .overlay(
//                  Rectangle()
//                    .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
//                )
//                .offset(x: 0, y: 68.50)
//            }
//            .frame(width: 283, height: 137)
//            .offset(x: -8, y: -9.50)
//            .opacity(0.30)
//            ZStack() {
//              Text("Sun")
//                .font(Font.custom("Poppins", size: 12))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -126, y: 0)
//              Text("Mon")
//                .font(Font.custom("Poppins", size: 12))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -81.50, y: 0)
//              Text("Tue")
//                .font(Font.custom("Poppins", size: 12))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -37.50, y: 0)
//              Text("Wed")
//                .font(Font.custom("Poppins", size: 12))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: 7.50, y: 0)
//              Text("Thu")
//                .font(Font.custom("Poppins", size: 12).weight(.bold))
//                .foregroundColor(Color(red: 0.57, green: 0.64, blue: 0.99))
//                .offset(x: 53.50, y: 0)
//              Text("Fri")
//                .font(Font.custom("Poppins", size: 12))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: 90.50, y: 0)
//              Text("Sat")
//                .font(Font.custom("Poppins", size: 12))
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: 127.50, y: 0)
//            }
//            .frame(width: 275, height: 18)
//            .offset(x: -8, y: 77)
//          }
//          .frame(width: 299, height: 172)
//          ZStack() { }
//          .frame(width: 285, height: 109)
//          ZStack() {
//            Rectangle()
//              .foregroundColor(.clear)
//              .frame(width: 74, height: 0)
//              .overlay(
//                Rectangle()
//                  .stroke(Color(red: 0.57, green: 0.64, blue: 0.99), lineWidth: 0.40)
//              )
//              .offset(x: 36.50, y: -32.50)
//              .rotationEffect(.degrees(-90))
//          }
//          .frame(width: 7, height: 83)
//        }
//        .frame(width: 306, height: 172)
//        .offset(x: 4.50, y: -45.50)
//        ZStack() {
//          Rectangle()
//            .foregroundColor(.clear)
//            .frame(width: 315, height: 78)
//            .background(Color(red: 0.77, green: 0.77, blue: 0.77))
//            .cornerRadius(12)
//            .offset(x: 0, y: 0)
//          ZStack() { }
//          .frame(width: 429.55, height: 65)
//          .offset(x: -0, y: -6.50)
//          ZStack() { }
//          .frame(width: 356.45, height: 65)
//          .offset(x: 9.27, y: 65.50)
//        }
//        .frame(width: 315, height: 78)
//        .offset(x: -11, y: -21.50)
//        ZStack() {
//          Rectangle()
//            .foregroundColor(.clear)
//            .frame(width: 315, height: 57)
//            .background(
//              LinearGradient(gradient: Gradient(colors: [Color(red: 0.57, green: 0.64, blue: 0.99), Color(red: 0.62, green: 0.81, blue: 1)]), startPoint: .trailing, endPoint: .leading)
//            )
//            .cornerRadius(16)
//            .offset(x: 0, y: 0)
//            .opacity(0.20)
//          Text("Injury Progress")
//            .font(Font.custom("Poppins", size: 14).weight(.medium))
//            .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
//            .offset(x: -85.50, y: 0)
//          ZStack() {
//            Rectangle()
//              .foregroundColor(.clear)
//              .frame(width: 68, height: 28)
//              .background(Color(red: 0.33, green: 0.60, blue: 0.84))
//              .cornerRadius(50)
//              .offset(x: 0, y: 0)
//            Text("Check")
//              .font(Font.custom("Poppins", size: 12))
//              .foregroundColor(.white)
//              .offset(x: 0, y: 0)
//          }
//          .frame(width: 68, height: 28)
//          .offset(x: 103.50, y: 0.50)
//        }
//        .frame(width: 315, height: 57)
//        .offset(x: -8, y: 88)
//        ZStack() {
//          Text("Today Schedule")
//            .font(Font.custom("Poppins", size: 16).weight(.semibold))
//            .lineSpacing(24)
//            .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
//            .offset(x: -92, y: -108)
//          ZStack() {
//            Rectangle()
//              .foregroundColor(.clear)
//              .frame(width: 315, height: 93)
//              .background(.white)
//              .cornerRadius(20)
//              .offset(x: 0, y: 0)
//              .shadow(
//                color: Color(red: 0.11, green: 0.09, blue: 0.09, opacity: 0.07), radius: 40, y: 10
//              )
//            ZStack() {
//
//            }
//            .frame(width: 14, height: 14)
//            .offset(x: 135.50, y: -24.50)
//            ZStack() {
//              Text("ACL Therapy Session")
//                .font(Font.custom("Poppins", size: 14).weight(.medium))
//                .lineSpacing(24)
//                .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
//                .offset(x: 0, y: -14.50)
//              Text("in 6hours 22minutes")
//                .font(Font.custom("Poppins", size: 14))
//                .lineSpacing(24)
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: -0.50, y: 14.50)
//            }
//            .frame(width: 146, height: 53)
//            .offset(x: -24.50, y: 0)
//          }
//          .frame(width: 315, height: 93)
//          .offset(x: 0, y: -34.50)
//          ZStack() {
//            Rectangle()
//              .foregroundColor(.clear)
//              .frame(width: 315, height: 93)
//              .background(.white)
//              .cornerRadius(20)
//              .offset(x: 0, y: 0)
//              .shadow(
//                color: Color(red: 0.11, green: 0.09, blue: 0.09, opacity: 0.07), radius: 40, y: 10
//              )
//            ZStack() {
//
//            }
//            .frame(width: 14, height: 14)
//            .offset(x: 135.50, y: -24.50)
//            ZStack() {
//              Text("Pick Up Prescription")
//                .font(Font.custom("Poppins", size: 14).weight(.medium))
//                .lineSpacing(24)
//                .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
//                .offset(x: -6.50, y: -14.50)
//              Text("in 14hours 30minutes")
//                .font(Font.custom("Poppins", size: 14))
//                .lineSpacing(24)
//                .foregroundColor(Color(red: 0.48, green: 0.44, blue: 0.45))
//                .offset(x: 0, y: 14.50)
//            }
//            .frame(width: 152, height: 53)
//            .offset(x: -21.50, y: 0)
//          }
//          .frame(width: 315, height: 93)
//          .offset(x: 0, y: 73.50)
//        }
//        .frame(width: 315, height: 240)
//        .offset(x: -8, y: 265.50)
//      }
//      .frame(width: 403, height: 771)
//    }
//    .padding(EdgeInsets(top: 49, leading: 18, bottom: 49, trailing: 9))
//    .frame(width: 430, height: 869)
//    .background(.white)
//    .cornerRadius(40);
//  }
//}

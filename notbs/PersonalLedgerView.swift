//
//  PersonalLedgerView.swift
//  notbs
//
//  Created by Pranav Krishnan on 7/16/23.
//

import SwiftUI

//struct PersonalLedgerView: View {
//    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
//
//    var body: some View {
//        VStack {
//            Text("Recent Events")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 15)
//
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
//                ForEach(0..<9) { index in
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(colors[index % colors.count])
//                        .frame(height: 100)
//                        .shadow(color: .gray, radius: 5, x: 5, y: 5)
//                        .padding(.all, 10)
//                }
//            }
//        }
//    }
//}


struct PersonalLedgerView: View {
    @State private var showingFavorites = false
    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
    let favoriteColors: [Color] = [.red, .gray, .black, .white, .purple, .pink]

    var body: some View {
        VStack {
            Toggle(isOn: $showingFavorites) {
                Text("Show Favorites")
                    .font(.headline)
            }
            .padding()
            
            Text("Recent Events")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 15)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<9) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(showingFavorites ? favoriteColors[index % favoriteColors.count] : colors[index % colors.count])
                        .frame(height: 100)
                        .shadow(color: .gray, radius: 5, x: 5, y: 5)
                        .padding(.all, 10)
                }
            }
            Spacer()
        }
    }
}
struct PersonalLedgerView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalLedgerView()
    }
}

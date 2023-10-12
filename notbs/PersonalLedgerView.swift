


import SwiftUI

struct PersonalLedgerView: View {
    @State private var showingFavorites = false
    let colors: [Color] = [.pink, .blue, .green, .orange, .yellow, .purple]
    let favoriteColors: [Color] = [.red, .gray, .black, .white, .purple, .pink]

    var body: some View {
        ScrollView {
            VStack {
                Text("Personal Ledger")
                    .font(Font.custom("Poppins", size: 16).weight(.bold))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
                
                SearchBar()
                
                HealthRecords()
                
                Rectangle5797()
                
                Toggle(isOn: $showingFavorites) {
                    Text("Show Favorites")
                        .font(.headline)
                }
                .padding()

                Text("Shared with you")
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
            }
            .padding()
        }
    }
}


struct SearchBar: View {
  var body: some View {
    ZStack() {
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 315, height: 50)
        .background(.white)
        .cornerRadius(16)
        .offset(x: 0, y: 0)
        .shadow(
          color: Color(red: 0.11, green: 0.09, blue: 0.09, opacity: 0.07), radius: 40, y: 10
        )
      HStack(spacing: 0) {
        ZStack() {
          Ellipse()
            .foregroundColor(.clear)
            .frame(width: 14.98, height: 14.98)
            .overlay(
              Ellipse()
                .stroke(Color(red: 0.68, green: 0.64, blue: 0.65), lineWidth: 0.60)
            )
            .offset(x: -0.33, y: -0.52)
        }
        .frame(width: 15.64, height: 16.02)
      }
      .padding(
        EdgeInsets(top: 2.32, leading: 2.32, bottom: 1.67, trailing: 2.05)
      )
      .frame(width: 20, height: 20)
      .offset(x: -132.50, y: 0)
      Text("Search Ledger")
        .font(Font.custom("Poppins", size: 12))
        .lineSpacing(18)
        .foregroundColor(Color(red: 0.87, green: 0.85, blue: 0.86))
        .offset(x: -69.50, y: 0)
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 20, height: 0)
        .overlay(
          Rectangle()
            .stroke(Color(red: 0.87, green: 0.85, blue: 0.86), lineWidth: 0.25)
        )
        .offset(x: 122.50, y: -10)
        .rotationEffect(.degrees(-90))
    }
    .frame(width: 315, height: 50);
  }
}

struct HealthRecords: View {
    var body: some View {
        Text("Health Records")
            .font(Font.custom("Poppins", size: 16).weight(.semibold))
            .foregroundColor(Color(red: 0.12, green: 0.09, blue: 0.09))
    }
}

struct Rectangle5797: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 200, height: 239)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.57, green: 0.64, blue: 0.99), Color(red: 0.62, green: 0.81, blue: 1)]), startPoint: .trailing, endPoint: .leading)
            )
            .cornerRadius(20)
            .opacity(0.20)
    }
}


struct PersonalLedgerView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalLedgerView()
    }
}

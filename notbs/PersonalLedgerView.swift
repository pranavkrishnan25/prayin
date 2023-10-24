import SwiftUI

struct PersonalLedgerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "arrow.left").foregroundColor(.blue)
                Spacer()
                Text("Personal Ledger")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding()

            SearchBar()

            Text("Health Records")
                .font(.title2)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    HealthRecordView(title: "ACL Tear")
                    HealthRecordView(title: "Heart Surgery")
                    HealthRecordView(title: "Rolled Ankle")
                }
            }

            Text("Recent Events")
                .font(.title2)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    EventView(title: "Physical Therapy Week 6", subtitle: "Part of ACL Recovery")
                    EventView(title: "Physical Check Up", subtitle: "Part of General Health")
                }
            }
            .padding(.horizontal)

            Text("People Shared with you")
                .font(.title2)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    PersonView(name: "Lily")
                    PersonView(name: "Mark")
                    PersonView(name: "Courtnf")
                }
            }

            Spacer()
        }
    }
}

struct HealthRecordView: View {
    var title: String
    var body: some View {
        VStack {
            Image(systemName: "heart.fill").foregroundColor(.blue) // Light blue color for the heart
            Text(title)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct EventView: View {
    var title: String
    var subtitle: String
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "gear").foregroundColor(.blue) // Light blue color for the gear
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct PersonView: View {
    var name: String
    var body: some View {
        VStack {
            Image("person_placeholder") // Placeholder image
                .resizable()
                .clipShape(Circle())
                .frame(width: 80, height: 80)
            Text(name)
        }
    }
}

struct SearchBar: View {
    var body: some View {
        TextField("Search Ledger", text: .constant(""))
            .padding(EdgeInsets(top: 8, leading: 40, bottom: 8, trailing: 8))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 0.5)
            )
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.blue)
                    Spacer()
                }.padding(.horizontal, 8)
            )
            .padding(.horizontal)
    }
}

struct PersonalLedgerView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalLedgerView()
    }
}

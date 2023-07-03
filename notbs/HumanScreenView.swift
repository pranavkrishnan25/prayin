
import SwiftUI

struct SimpleLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct GraphBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                
                let xSpacing = width / 5
                let ySpacing = height / 5
                
                for index in 0..<6 {
                    path.move(to: CGPoint(x: CGFloat(index) * xSpacing, y: 0))
                    path.addLine(to: CGPoint(x: CGFloat(index) * xSpacing, y: height))
                }
                
                for index in 0..<6 {
                    path.move(to: CGPoint(x: 0, y: CGFloat(index) * ySpacing))
                    path.addLine(to: CGPoint(x: width, y: CGFloat(index) * ySpacing))
                }
            }
            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        }
    }
}

struct GraphView: View {
    let color: Color
    
    var body: some View {
        ZStack {
            GraphBackground()
            SimpleLine()
                .stroke(color, lineWidth: 2)
        }
        .frame(height: 200)
        .padding(.horizontal)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(color, lineWidth: 2)
        )
    }
}

struct HumanScreenView: View {
    @State private var selectedGraph = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Pranav Krishnan")
                            .font(.title)
                            .foregroundColor(.black)
                        Text("6/17/23")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("3:30 PM")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    Spacer()
                }
                .background(RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.7)))
                .padding()

                NavigationLink(destination: LedgerScreenView()) {
                    Text("Personal Ledger")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue.opacity(0.8)))
                }
                .padding()

                Button(action: {}) {
                    Text("Medical Visits")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue.opacity(0.8)))
                }
                .padding()

                Button(action: {}) {
                    Text("Medicine Cabinet")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue.opacity(0.8)))
                }
                .padding()

                Text("Activity")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Picker("", selection: $selectedGraph) {
                    Text("Blue Graph").tag(0)
                    Text("Red Graph").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                if selectedGraph == 0 {
                    GraphView(color: .blue)
                } else {
                    GraphView(color: .red)
                }

                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HumanScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HumanScreenView()
    }
}

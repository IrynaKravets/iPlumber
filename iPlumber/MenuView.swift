import SwiftUI

struct MenuView: View {
    let topics = ["Threaded and Grooved Pipe"] // Add more topics here in the future

    var body: some View {
        NavigationStack {
            List(topics, id: \.self) { topic in
                NavigationLink(value: topic) {
                    Text(topic)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationDestination(for: String.self) { topic in
                DashboardView(topic: topic)
            }
            .navigationTitle("Topics")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

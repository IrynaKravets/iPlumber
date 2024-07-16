import SwiftUI

struct TopicSelectionView: View {
    let topics = ["Threaded and Grooved Pipe"]

    var body: some View {
        NavigationStack {
            List(topics, id: \.self) { topic in
                NavigationLink(value: topic) {
                    Text(topic.replacingOccurrences(of: "-", with: " ").capitalized)
                }
            }
            .navigationDestination(for: String.self) { topic in
                DashboardView(topic: topic)
            }
            .navigationTitle("Topics")
        }
    }
}

struct TopicSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TopicSelectionView()
    }
}

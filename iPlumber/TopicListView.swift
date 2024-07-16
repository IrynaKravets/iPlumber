import SwiftUI

struct TopicListView: View {
    let topics: [Topic]
    @Binding var navigationPath: NavigationPath

    var body: some View {
        List(topics) { topic in
            NavigationLink(topic.name, value: topic)
        }
        .navigationTitle("Topics")
        .navigationDestination(for: Topic.self) { topic in
            TopicDetailView(topic: topic, navigationPath: $navigationPath)
        }
    }
}

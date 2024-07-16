import SwiftUI

struct TopicListView: View {
    @StateObject private var viewModel = TopicsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.topics) { topic in
                NavigationLink(value: topic) {
                    Text(topic.name)
                }
            }
            .navigationTitle("Topics")
            .navigationDestination(for: Topic.self) { topic in
                TopicDetailView(topic: topic)
            }
        }
    }
}

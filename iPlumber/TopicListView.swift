import SwiftUI

struct TopicListView: View {
    @ObservedObject var viewModel: TopicsViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        List(viewModel.topics) { topic in
            NavigationLink(value: topic) {
                Text(topic.name)
            }
        }
        .navigationTitle("Topics")
        .onAppear {
            print("Topics in ListView: \(viewModel.topics.count)")
            for topic in viewModel.topics {
                print("Topic: \(topic.name)")
            }
        }
        .navigationDestination(for: Topic.self) { topic in
            TopicDetailView(topic: topic, navigationPath: $navigationPath)
        }
    }
}

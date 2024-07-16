import SwiftUI

struct TopicsView: View {
    let section: Section
    @Binding var navigationPath: NavigationPath

    var body: some View {
        List(section.topics) { topic in
            NavigationLink(destination: TopicDetailView(topic: topic, navigationPath: $navigationPath)) {
                Text(topic.name)
            }
        }
        .navigationTitle(section.name)
    }
}

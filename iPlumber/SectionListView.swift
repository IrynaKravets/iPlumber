import SwiftUI

struct SectionListView: View {
    @ObservedObject var viewModel: SectionsViewModel
    @Binding var navigationPath: NavigationPath

    var body: some View {
        List(viewModel.sections) { section in
            NavigationLink(section.name, value: section.topics)
        }
        .navigationTitle("Sections")
        .navigationDestination(for: [Topic].self) { topics in
            TopicListView(topics: topics, navigationPath: $navigationPath)
        }
    }
}

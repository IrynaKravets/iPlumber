import SwiftUI

struct SectionsView: View {
    @ObservedObject var sectionsViewModel = SectionsViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(sectionsViewModel.sections) { section in
                NavigationLink(destination: TopicsView(section: section, navigationPath: $navigationPath)) {
                    Text(section.name)
                }
            }
            .navigationTitle("Sections")
        }
    }
}

import SwiftUI

@main
struct iPlumberApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    @StateObject private var viewModel = TopicsViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            TopicListView(viewModel: viewModel, navigationPath: $navigationPath)
        }
    }
}

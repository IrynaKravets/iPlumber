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
    @StateObject private var viewModel = SectionsViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            SectionListView(viewModel: viewModel, navigationPath: $navigationPath)
        }
    }
}

import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func navigateToDashboard() {
        path = NavigationPath()
    }

    func navigateToTopics() {
        path = NavigationPath()
    }
}

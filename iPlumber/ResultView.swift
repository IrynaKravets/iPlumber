import SwiftUI

struct ResultView: View {
    let score: Int
    let totalQuestions: Int
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            Text("Your score is: \(score)/\(totalQuestions)")
            Button("Return to Topic") {
                navigationPath.removeLast(navigationPath.count)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

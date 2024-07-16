import SwiftUI
import Foundation

struct TopicDetailView: View {
    let topic: Topic
    @StateObject private var testViewModel = TestViewModel()
    @Binding var navigationPath: NavigationPath

    @State private var latestScore: Int?
    @State private var latestDate: Date?

    var body: some View {
        VStack {
            if let latestScore = latestScore, let latestDate = latestDate {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Latest Score: \(latestScore)/\(topic.questions.count)")
                    Text("Date: \(latestDate, formatter: DateFormatter.shortDateFormatter)")
                }
                .padding()
            } else {
                Text("No tests taken yet.")
                    .padding()
            }

            NavigationLink("Start Test", value: topic.questions)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .navigationTitle(topic.name)
        .onAppear {
            loadLatestResults()
        }
        .navigationDestination(for: [Question].self) { questions in
            QuestionView(testViewModel: testViewModel, navigationPath: $navigationPath)
                .onAppear {
                    testViewModel.startTest(with: questions)
                }
        }
    }

    private func loadLatestResults() {
        let keyScore = UserDefaultsKeys.latestScoreKey(for: topic.id)
        let keyDate = UserDefaultsKeys.latestDateKey(for: topic.id)
        latestScore = UserDefaults.standard.value(forKey: keyScore) as? Int
        latestDate = UserDefaults.standard.value(forKey: keyDate) as? Date
        print("Loaded latest score: \(String(describing: latestScore)), latest date: \(String(describing: latestDate))")
    }
}

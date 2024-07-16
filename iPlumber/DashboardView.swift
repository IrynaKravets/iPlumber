import SwiftUI

struct DashboardView: View {
    let topic: String
    @State private var isQuizActive = false
    @State private var latestScore: Int? = nil
    @State private var score = 0
    let questions: [Question]

    init(topic: String) {
        self.topic = topic
        self.questions = loadQuestions(fromFile: topic.replacingOccurrences(of: " ", with: "_").lowercased())
    }

    var body: some View {
        NavigationStack {
            VStack {
                if let latestScore = latestScore {
                    Text("Latest Score: \(latestScore)")
                } else {
                    Text("No tests taken yet")
                }

                Button(action: {
                    isQuizActive = true
                    score = 0
                }) {
                    Text("Start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(value: isQuizActive) {
                    EmptyView()
                }
            }
            .navigationDestination(isPresented: $isQuizActive) {
                QuestionView(questionIndex: 0, score: $score, questions: questions, isQuizActive: $isQuizActive, latestScore: $latestScore)
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(topic: "Threaded and Grooved Pipe")
    }
}

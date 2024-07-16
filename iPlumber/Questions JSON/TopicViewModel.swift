import SwiftUI

class TopicsViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    
    init() {
        loadTopicsFromJSON()
    }
    
    private func loadTopics() {
        // Load topics from JSON files
        // For simplicity, we are using sample data here
        let sampleQuestions = [
            Question(question: "Sample Question 1", options: ["A", "B", "C", "D"], correctAnswer: "A"),
            Question(question: "Sample Question 2", options: ["A", "B", "C", "D"], correctAnswer: "B")
        ]
        let sampleTopic = Topic(name: "Threaded and Grooved Pipe", questions: sampleQuestions)
        topics = [sampleTopic]
    }

    private func loadTopicsFromJSON() {
        guard let url = Bundle.main.url(forResource: "topics", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decodedTopics = try JSONDecoder().decode([Topic].self, from: data)
            self.topics = decodedTopics
        } catch {
            print("Error loading topics: \(error)")
        }
    }
}

class TestViewModel: ObservableObject {
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var selectedAnswer: String? = nil
    @Published var showResult: Bool = false
    @Published var questions: [Question] = []
    
    func startTest(with questions: [Question]) {
        self.questions = questions
        self.currentQuestionIndex = 0
        self.score = 0
        self.selectedAnswer = nil
        self.showResult = false
    }
    
    func submitAnswer() {
        if let selectedAnswer = selectedAnswer, selectedAnswer == currentQuestion.correctAnswer {
            score += 1
        }
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            self.selectedAnswer = nil
        } else {
            showResult = true
        }
    }
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
}

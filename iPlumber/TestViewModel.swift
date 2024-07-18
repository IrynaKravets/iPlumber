import Foundation

class TestViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedAnswer: String? = nil
    @Published var selectedAnswers: Set<String> = []
    @Published var textAnswer: String = ""
    @Published var showResult: Bool = false
    @Published var score: Int = 0
    @Published var questionAnswered: Bool = false
    
    init(questions: [Question] = []) {
        self.questions = questions
    }

    func startTest(with questions: [Question]) {
        self.questions = questions
        self.currentQuestionIndex = 0
        self.selectedAnswer = nil
        self.selectedAnswers = []
        self.textAnswer = ""
        self.showResult = false
        self.score = 0
        self.questionAnswered = false
    }

    func submitAnswer() {
        guard currentQuestionIndex < questions.count else {
            print("Error: Current question index out of range")
            return
        }

        let currentQuestion = questions[currentQuestionIndex]
        
        if currentQuestion.type == .singleType {
            if let selectedAnswer = selectedAnswer, currentQuestion.correctAnswer.contains(selectedAnswer) {
                score += 1
            }
        } else if currentQuestion.type == .checkboxType {
            let correctAnswers = Set(currentQuestion.correctAnswer)
            if selectedAnswers == correctAnswers {
                score += 1
            }
        }
        
        questionAnswered = true
    }

    func submitTextAnswer(_ textAnswer: String) {
        guard currentQuestionIndex < questions.count else {
            print("Error: Current question index out of range")
            return
        }

        let currentQuestion = questions[currentQuestionIndex]
        
        if currentQuestion.type == .textType {
            if currentQuestion.correctAnswer.contains(textAnswer) {
                score += 1
            }
        }
        
        questionAnswered = true
    }

    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            selectedAnswers = []
            textAnswer = ""
            questionAnswered = false
        } else {
            showResult = true
            saveTestResult()
        }
    }

    var currentQuestion: Question {
        guard currentQuestionIndex < questions.count else {
            fatalError("Current question index out of range")
        }
        return questions[currentQuestionIndex]
    }

    private func saveTestResult() {
        guard let topicId = questions.first?.topicId else { return }
        let keyScore = UserDefaultsKeys.latestScoreKey(for: topicId)
        let keyDate = UserDefaultsKeys.latestDateKey(for: topicId)
        UserDefaults.standard.set(score, forKey: keyScore)
        UserDefaults.standard.set(Date(), forKey: keyDate)
        print("Saved latest score \(score) and date \(Date()) for topic \(topicId)")
    }
}

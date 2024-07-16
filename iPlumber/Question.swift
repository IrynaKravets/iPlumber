import Foundation

enum QuestionType: String, Codable {
    case singleType = "single_type"
    case checkboxType = "checkbox_type"
    case textType = "text_type"
}

struct Question: Identifiable, Codable, Hashable {
    let id: UUID
    let topicId: UUID
    let question: String
    let options: [String]
    let correctAnswer: [String] // Change this to an array of strings
    let explanation: String
    let type: QuestionType
    
    init(id: UUID = UUID(), topicId: UUID, question: String, options: [String], correctAnswer: [String], explanation: String, type: QuestionType) {
        self.id = id
        self.topicId = topicId
        self.question = question
        self.options = options
        self.correctAnswer = correctAnswer
        self.explanation = explanation
        self.type = type
    }
}

extension Question {
    static func fake(
        type: QuestionType = .singleType
    ) -> Question {
        Question(
            topicId: .init(),
            question: "Fake Question?",
            options: [
                "Yes",
                "No",
                "Maybe"
            ],
            correctAnswer: ["Yes"],
            explanation: "Because",
            type: type
        )
    }
}

struct Topic: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let questions: [Question]
    
    init(id: UUID = UUID(), name: String, questions: [Question]) {
        self.id = id
        self.name = name
        self.questions = questions
    }
}

import SwiftUI
import Foundation

struct Section: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    var topics: [Topic]
    
    init(id: UUID = UUID(), name: String, topics: [Topic] = []) {
        self.id = id
        self.name = name
        self.topics = topics
    }
}

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
    let correctAnswer: [String]
    let explanation: String
    let type: QuestionType
    let imageNames: [String]?
    
    init(id: UUID = UUID(), topicId: UUID, question: String, options: [String], correctAnswer: [String], explanation: String, type: QuestionType, imageNames: [String]? = nil) {
        self.id = id
        self.topicId = topicId
        self.question = question
        self.options = options
        self.correctAnswer = correctAnswer
        self.explanation = explanation
        self.type = type
        self.imageNames = imageNames
    }
}



struct Topic: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let topicId: UUID
    var questions: [Question]
    
    init(id: UUID = UUID(), name: String, topicId: UUID, questions: [Question]) {
        self.id = id
        self.name = name
        self.topicId = topicId
        self.questions = questions
    }
}

extension Topic {
    private enum CodingKeys: String, CodingKey {
        case id, name, topicId, questions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        topicId = try container.decode(UUID.self, forKey: .topicId)
        
        questions = try container.decode([Question].self, forKey: .questions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(topicId, forKey: .topicId)
        try container.encode(questions, forKey: .questions)
    }
}

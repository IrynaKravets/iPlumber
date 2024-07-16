// Question.swift

import Foundation

struct Question: Identifiable, Codable {
    let id: UUID
    let question: String
    let type: QuestionType
    let options: [String]?
    let correctAnswer: String?
    let image: String?
    let matchingPairs: [MatchingPair]?
    
    enum QuestionType: String, Codable {
        case multipleChoice = "multiple_choice"
        case matching = "matching"
    }
    
    struct MatchingPair: Codable {
        let abbreviation: String
        let meaning: String
    }

    // Custom initializer to generate a UUID for `id` if not provided
    init(id: UUID = UUID(), question: String, type: QuestionType, options: [String]? = nil, correctAnswer: String? = nil, image: String? = nil, matchingPairs: [MatchingPair]? = nil) {
        self.id = id
        self.question = question
        self.type = type
        self.options = options
        self.correctAnswer = correctAnswer
        self.image = image
        self.matchingPairs = matchingPairs
    }

    // Custom decoding to handle `id` assignment
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.question = try container.decode(String.self, forKey: .question)
        self.type = try container.decode(QuestionType.self, forKey: .type)
        self.options = try container.decodeIfPresent([String].self, forKey: .options)
        self.correctAnswer = try container.decodeIfPresent(String.self, forKey: .correctAnswer)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.matchingPairs = try container.decodeIfPresent([MatchingPair].self, forKey: .matchingPairs)
    }
}

// Function to load questions from a JSON file
func loadQuestions(forTopic topic: String) -> [Question] {
    let formattedTopic = topic.replacingOccurrences(of: " ", with: "_").lowercased()
    guard let url = Bundle.main.url(forResource: formattedTopic, withExtension: "json") else {
        fatalError("Failed to locate \(formattedTopic).json in bundle.")
    }
    
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Failed to load \(formattedTopic).json from bundle.")
    }
    
    let decoder = JSONDecoder()
    
    do {
        let loadedQuestions = try decoder.decode([Question].self, from: data)
        return loadedQuestions
    } catch {
        fatalError("Failed to decode \(formattedTopic).json from bundle: \(error)")
    }
}

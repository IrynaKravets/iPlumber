import Foundation

struct Section: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let topics: [Topic]
    
    init(id: UUID = UUID(), name: String, topics: [Topic]) {
        self.id = id
        self.name = name
        self.topics = topics
    }
}

import SwiftUI

class TopicsViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    
    init() {
        loadTopicsFromJSON()
    }
    
    private func loadTopicsFromJSON() {
        let topicFiles = [
            "safety_legislation_regulations_industry_policy_in_the_trades_210101a",
            "climbing_lifting_rigging_hoisting_210101b",
            "hazardous_materials_and_fire_protection_210101c",
            "apprenticeship_training_program_210101d",
            "pipe_trades_codes_210101e",
            "electrical_safety_210101f",
            "hand_tools_210102a",
            "power_tools_210102b",
            "welded_pipe_and_fittings_210102c",
            "threaded_and_grooved_pipe"
        ]
        for file in topicFiles {
            if let url = Bundle.main.url(forResource: file, withExtension: "json") {
                print("File path: \(url.path)")
                do {
                    let data = try Data(contentsOf: url)
                    let topic = try JSONDecoder().decode(Topic.self, from: data)
                    self.topics.append(topic)
                    print("Loaded topic: \(topic.name)")
                } catch {
                    print("Error loading topic \(file): \(error)")
                }
            } else {
                print("File not found: \(file)")
            }
        }
        print("Total topics loaded: \(topics.count)")
    }
}

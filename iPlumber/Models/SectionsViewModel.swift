import SwiftUI
import Foundation

class SectionsViewModel: ObservableObject {
    @Published var sections: [Section] = []

    init() {
        loadSectionsFromJSON()
    }

    private func loadSectionsFromJSON() {
        // Define sections and their related topics
        let sectionData: [String: [String]] = [
            "Section 1: Workplace Safety and Rigging": [
                "safety_legislation_regulations_industry_policy_in_the_trades_210101a",
                "climbing_lifting_rigging_hoisting_210101b",
                "hazardous_materials_and_fire_protection_210101c",
                "apprenticeship_training_program_210101d",
                "pipe_trades_codes_210101e",
                "electrical_safety_210101f"
            ],
            "Section 2: Tools, Equipment and Materials": [
                "hand_tools_210102a",
                "power_tools_210102b",
                "welded_pipe_and_fittings_210102c",
                "plastic_pipe_and_tube_210102d",
                "threaded_and_grooved_pipe_210102e_Part_1",
                "threaded_and_grooved_pipe_210102e_Part_2",
                "tube_and_tubing_210102f",
                "valves_210102g_Part_1",
                "valves_210102g_Part_2",
                "hangers_supports_and_fasteners_210102h",
                "pressure_testing_210102i",
                "pumps_210102j"
            ],
            "Section 3: Metal Fabrication": [
                "welding_safety_210103a",
                "welding_part_a_210103bA",
                "welding_part_b_210103bB",
                "welding_part_c_210103bC",
                "brazing_and_soldering_210103c"
            ],
            "Section 4: Drawings and Specifications": [
                "test"
            ],
            "Sections 5: Calculations and Science": [
                // Add topic JSON filenames here
            ]
        ]

        for (sectionName, topicFiles) in sectionData {
            var topics: [Topic] = []
            for file in topicFiles {
                if let topic = loadTopic(from: file) {
                    topics.append(topic)
                } else {
                    print("Failed to load topic: \(file) in section: \(sectionName)")
                }
            }
            let section = Section(name: sectionName, topics: topics)
            self.sections.append(section)
            print("Loaded section: \(section.name) with topics: \(topics.map { $0.name })")
        }
        
        sections = sections.sorted(by: { $0.name < $1.name })
        
        print("Total sections loaded: \(sections.count)")
    }

    private func loadTopic(from fileName: String) -> Topic? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let topic = try JSONDecoder().decode(Topic.self, from: data)
                return topic
            } catch {
                print("Error loading topic \(fileName): \(error)")
                return nil
            }
        } else {
            print("File not found: \(fileName)")
            return nil
        }
    }
}

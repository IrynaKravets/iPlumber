import Foundation

struct UserDefaultsKeys {
    static func latestScoreKey(for topicId: UUID) -> String {
        return "latestScore_\(topicId.uuidString)"
    }

    static func latestDateKey(for topicId: UUID) -> String {
        return "latestDate_\(topicId.uuidString)"
    }
}

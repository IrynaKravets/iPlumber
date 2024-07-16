import SwiftUI

#Preview {
    let mockTopicId = UUID() // Create a single mock topic ID

    let sampleQuestions = [
        Question(
            id: UUID(),
            topicId: mockTopicId, // Use the same mock topic ID for consistency
            question: "Sample single choice question?",
            options: ["Option 1", "Option 2", "Option 3", "Option 4"],
            correctAnswer: ["Option 1"],
            explanation: "Explanation",
            type: .singleType
        ),
        Question(
            id: UUID(),
            topicId: mockTopicId, // Use the same mock topic ID for consistency
            question: "List three (3) requirements to be fulfilled before a certificate of progress stamp for a particular training period can be awarded in the record book?",
            options: ["Technical training for that period must be successfully completed.",
                      "Required hours and completion date of that period must be reached.",
                      "The employer must fill out a Record of Work Experience for the training period."],
            correctAnswer: ["Technical training for that period must be successfully completed.;Required hours and completion date of that period must be reached.;The employer must fill out a Record of Work Experience for the training period."],
            explanation: "Explanation",
            type: .checkboxType
        )
    ]

    let testViewModel = TestViewModel()
    testViewModel.startTest(with: sampleQuestions)

    return QuestionView(testViewModel: testViewModel, navigationPath: .constant(NavigationPath()))
}

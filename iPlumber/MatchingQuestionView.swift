import SwiftUI

struct MatchingQuestionView: View {
    let question: Question
    @Binding var selectedPairs: [String: String]
    @Binding var isAnswerSubmitted: Bool
    
    @State private var feedbackText: String = ""
    @State private var feedbackColor: Color = .black
    @State private var correctPairs: [String: String]
    @State private var incorrectFields: Set<String> = []
    @State private var correctAnswers: [String: String] = [:]

    init(question: Question, selectedPairs: Binding<[String: String]>, isAnswerSubmitted: Binding<Bool>) {
        self.question = question
        self._selectedPairs = selectedPairs
        self._isAnswerSubmitted = isAnswerSubmitted
        self._correctPairs = State(initialValue: Dictionary(uniqueKeysWithValues: question.matchingPairs?.map { ($0.abbreviation, $0.meaning) } ?? []))
    }

    var body: some View {
        VStack {
            Text(question.question)
                .font(.title)
                .padding()
            
            ForEach(question.matchingPairs ?? [], id: \.abbreviation) { pair in
                VStack(alignment: .leading) {
                    HStack {
                        Text(pair.abbreviation)
                        TextField("Enter meaning", text: Binding(
                            get: { self.selectedPairs[pair.abbreviation] ?? "" },
                            set: { self.selectedPairs[pair.abbreviation] = $0 }
                        ))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(self.incorrectFields.contains(pair.abbreviation) ? Color.red.opacity(0.3) : Color.clear)
                    }
                    if self.isAnswerSubmitted, let answer = self.correctAnswers[pair.abbreviation] {
                        Text("Correct answer: \(answer)")
                            .foregroundColor(.red)
                            .padding(.leading)
                    }
                }
            }

            Text(feedbackText)
                .font(.title)
                .foregroundColor(feedbackColor)
                .padding()

            Button(action: {
                self.submitAnswer()
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    func submitAnswer() {
        self.isAnswerSubmitted = true
        self.incorrectFields.removeAll()
        self.correctAnswers.removeAll()
        
        var isCorrect = true
        for (abbr, meaning) in correctPairs {
            if selectedPairs[abbr] != meaning {
                isCorrect = false
                self.incorrectFields.insert(abbr)
                self.correctAnswers[abbr] = meaning
            }
        }
        
        if isCorrect {
            feedbackText = "Correct!"
            feedbackColor = .green
        } else {
            feedbackText = "Incorrect"
            feedbackColor = .red
        }
    }
}

struct MatchingQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let question = Question(
            id: "1", // Use a string id here
            question: "What do the following abbreviations used to describe steel pipe stand for?",
            type: .matching,
            matchingPairs: [
                Question.MatchingPair(abbreviation: "Std", meaning: "Standard"),
                Question.MatchingPair(abbreviation: "XS", meaning: "Extra Strong"),
                Question.MatchingPair(abbreviation: "XXH", meaning: "Double Extra Heavy"),
                Question.MatchingPair(abbreviation: "XH", meaning: "Extra Heavy"),
                Question.MatchingPair(abbreviation: "XXS", meaning: "Double Extra Strong"),
                Question.MatchingPair(abbreviation: "Sch", meaning: "Schedule")
            ]
        )
        return MatchingQuestionView(question: question, selectedPairs: .constant([:]), isAnswerSubmitted: .constant(false))
    }
}


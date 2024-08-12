import SwiftUI

struct QuestionView: View {
    @ObservedObject var testViewModel: TestViewModel
    @Binding var navigationPath: NavigationPath
    @State private var isFullScreenImagePresented = false
    @State private var selectedImageName: String?

    var body: some View {
        VStack {
            if testViewModel.currentQuestionIndex < testViewModel.questions.count {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(testViewModel.currentQuestion.question)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .padding()
                        
                        if let imageNames = testViewModel.currentQuestion.imageNames {
                            ForEach(imageNames, id: \.self) { imageName in
                                Button(action: {
                                    selectedImageName = imageName
                                    isFullScreenImagePresented = true
                                }) {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                            }
                        }

                        switch testViewModel.currentQuestion.type {
                        case .singleType:
                            ForEach(testViewModel.currentQuestion.options, id: \.self) { option in
                                Button(action: {
                                    testViewModel.selectedAnswer = option
                                    testViewModel.submitAnswer()
                                }) {
                                    HStack {
                                        Image(systemName: testViewModel.selectedAnswer == option ? "circle.fill" : "circle")
                                        Text(option)
                                            .multilineTextAlignment(.leading)
                                            .padding()
                                    }
                                    .padding(.leading, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(testViewModel.selectedAnswer == option ? Color.gray.opacity(0.3) : Color.clear)
                                    .cornerRadius(8)
                                }
                            }
                        case .checkboxType:
                            ForEach(testViewModel.currentQuestion.options, id: \.self) { option in
                                Button(action: {
                                    if testViewModel.selectedAnswers.contains(option) {
                                        testViewModel.selectedAnswers.remove(option)
                                    } else {
                                        testViewModel.selectedAnswers.insert(option)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: testViewModel.selectedAnswers.contains(option) ? "checkmark.square" : "square")
                                        Text(option)
                                            .multilineTextAlignment(.leading)
                                            .padding()
                                    }
                                    .padding(.leading, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(testViewModel.selectedAnswers.contains(option) ? Color.gray.opacity(0.3) : Color.clear)
                                    .cornerRadius(8)
                                }
                            }
                        case .textType:
                            TextField("Enter your answer", text: $testViewModel.textAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }

                        if testViewModel.questionAnswered {
                            if testViewModel.currentQuestion.type == .singleType {
                                let selectedAnswer = testViewModel.selectedAnswer ?? ""
                                Text(selectedAnswer == testViewModel.currentQuestion.correctAnswer.first ? "Correct!!" : "Incorrect!! Correct answer is \(testViewModel.currentQuestion.correctAnswer.first ?? "")")
                                    .foregroundColor(selectedAnswer == testViewModel.currentQuestion.correctAnswer.first ? .green : .red)
                                    .padding(.vertical)
                            } else if testViewModel.currentQuestion.type == .checkboxType {
                                let correctAnswers = Set(testViewModel.currentQuestion.correctAnswer)
                                if testViewModel.selectedAnswers == correctAnswers {
                                    Text("Correct!!")
                                        .foregroundColor(.green)
                                        .padding(.vertical)
                                } else {
                                    Text("Incorrect!! Correct answers are \(testViewModel.currentQuestion.correctAnswer.joined(separator: ", "))")
                                        .foregroundColor(.red)
                                        .padding(.vertical)
                                }
                            } else if testViewModel.currentQuestion.type == .textType {
                                let isCorrect = testViewModel.currentQuestion.correctAnswer.contains(testViewModel.textAnswer)
                                Text(isCorrect ? "Correct!!" : "Incorrect!! Correct answer is \(testViewModel.currentQuestion.correctAnswer.joined(separator: ", "))")
                                    .foregroundColor(isCorrect ? .green : .red)
                                    .padding(.vertical)
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                Button(action: {
                    if testViewModel.currentQuestion.type == .checkboxType && !testViewModel.questionAnswered {
                        testViewModel.submitAnswer()
                    } else if testViewModel.currentQuestion.type == .textType && !testViewModel.questionAnswered {
                        testViewModel.submitTextAnswer(testViewModel.textAnswer)
                    } else {
                        testViewModel.nextQuestion()
                    }
                }) {
                    Text(testViewModel.currentQuestion.type == .checkboxType && !testViewModel.questionAnswered ? "Submit" : "Next Question")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                Text("No more questions available.")
                    .padding()
            }
        }
        .fullScreenCover(isPresented: $isFullScreenImagePresented) {
            if let selectedImageName = selectedImageName {
                FullScreenImageView(imageName: selectedImageName)
            }
        }
        .navigationDestination(isPresented: $testViewModel.showResult) {
            ResultView(score: testViewModel.score, totalQuestions: testViewModel.questions.count, navigationPath: $navigationPath)
        }
    }
}

struct FullScreenImageView: View {
    let imageName: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

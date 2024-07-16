//
//  MultipleChoiceView.swift
//  iPlumber
//
//  Created by Iryna Kravets on 2024-07-10.
//

import Foundation
import SwiftUI

struct MultipleChoiceView: View {
    @State private var selectedOption: String? = nil
    let question: String
    let options: [String]

    var body: some View {
        VStack {
            Text(question)
                .font(.title)
            ForEach(options, id: \.self) { option in
                Button(action: {
                    self.selectedOption = option
                }) {
                    Text(option)
                        .padding()
                        .background(self.selectedOption == option ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}

struct MultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(question: "What is the capital of France?", options: ["Paris", "London", "Berlin", "Madrid"])
    }
}

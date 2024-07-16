//
//  OpenEndedView.swift
//  iPlumber
//
//  Created by Iryna Kravets on 2024-07-10.
//

import Foundation
import SwiftUI

struct OpenEndedView: View {
    @State private var answer: String = ""
    let question: String

    var body: some View {
        VStack {
            Text(question)
                .font(.title)
            TextEditor(text: $answer)
                .border(Color.gray, width: 1)
                .padding()
            Button(action: {
                // Handle submission
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
}

struct OpenEndedView_Previews: PreviewProvider {
    static var previews: some View {
        OpenEndedView(question: "Describe the process of soldering pipes.")
    }
}


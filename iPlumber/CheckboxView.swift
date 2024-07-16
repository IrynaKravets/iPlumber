//
//  CheckboxView.swift
//  iPlumber
//
//  Created by Iryna Kravets on 2024-07-10.
//

import Foundation
import SwiftUI

struct CheckboxView: View {
    @State private var selectedOptions: Set<String> = []
    let question: String
    let options: [String]

    var body: some View {
        VStack {
            Text(question)
                .font(.title)
            ForEach(options, id: \.self) { option in
                HStack {
                    Button(action: {
                        if self.selectedOptions.contains(option) {
                            self.selectedOptions.remove(option)
                        } else {
                            self.selectedOptions.insert(option)
                        }
                    }) {
                        Image(systemName: self.selectedOptions.contains(option) ? "checkmark.square" : "square")
                    }
                    Text(option)
                }
                .padding()
            }
        }
        .padding()
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxView(question: "Select all the tools used for plumbing:", options: ["Wrench", "Screwdriver", "Pipe Cutter", "Hammer"])
    }
}

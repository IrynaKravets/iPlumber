//
//  MainView.swift
//  iPlumber
//
//  Created by Iryna Kravets on 2024-07-10.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: MultipleChoiceView(question: "What is the capital of France?", options: ["Paris", "London", "Berlin", "Madrid"])) {
                    Text("Multiple Choice Question")
                }
                NavigationLink(destination: OpenEndedView(question: "Describe the process of soldering pipes.")) {
                    Text("Open Ended Question")
                }
                NavigationLink(destination: CheckboxView(question: "Select all the tools used for plumbing:", options: ["Wrench", "Screwdriver", "Pipe Cutter", "Hammer"])) {
                    Text("Checkbox Question")
                }
            }
            .navigationTitle("Plumber Training")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

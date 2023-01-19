//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Melody Davis on 1/18/23.
//

import SwiftUI

enum Choices: String, CaseIterable {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}

struct ContentView: View {
    @State private var compChoice = Choices.allCases[Int.random(in: 0...2)]
    @State private var winOrLose = Bool.random()
    @State private var playerChoice: Choices = .paper
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Section {
                    Text("Computer chooses")
                    Text(compChoice.rawValue.uppercased())
                }
                Spacer()
                Section {
                    Text("To")
                    Text(winOrLose ? "win".uppercased() : "lose".uppercased())
                    Text("Please choose")
                    Picker("Game Choices", selection: $playerChoice) {
                        ForEach(Choices.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Spacer()
                Button("Enter") {
                    playRound(compChoice: compChoice, playerChoice: playerChoice, gameCondition: winOrLose)
                }
                Spacer()
            }
        }
    }
}

func playRound(compChoice: Choices, playerChoice: Choices, gameCondition playerToWin: Bool) {
    if playerToWin {
        switch compChoice {
        case .rock:
            playerChoice == .paper ? print("win") : print("lose")
        case .paper:
            playerChoice == .scissors ? print("win") : print("lose")
        case .scissors:
            playerChoice == .rock ? print("win") : print("lose")
        }
    } else {
        switch compChoice {
        case .rock:
            playerChoice == .scissors ? print("win") : print("lose")
        case .paper:
            playerChoice == .rock ? print("win") : print("lose")
        case .scissors:
            playerChoice == .paper ? print("win") : print("lose")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

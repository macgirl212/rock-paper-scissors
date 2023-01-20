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
    @State private var showScoreAlert = false
    @State private var showFinalScoreAlert = false
    @State private var completedRounds = 0
    @State private var compChoice = Choices.allCases[Int.random(in: 0...2)]
    @State private var winOrLose = Bool.random()
    @State private var playerChoice: Choices = .paper
    @State private var score = 0
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                }
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
                    let wasWon = verifyHands(compChoice: compChoice, playerChoice: playerChoice, gameCondition: winOrLose)
                    adjustScore(wasWon)
                }
                Spacer()
            }
            .alert(scoreTitle, isPresented: $showScoreAlert) {
                Button("Next Round", action: playRound)
            }
            .alert("Game Over", isPresented: $showFinalScoreAlert) {
                Button("Play Again", action: restartGame)
            } message: {
                Text("Your final score is \(score).")
            }
        }
    }
    
    func adjustScore(_ wasWon: Bool) {
        if wasWon {
            score += 1
            scoreTitle = "Congratulations!"
        } else {
            score -= 1
            scoreTitle = "Sorry, that was incorrect."
        }
        
        showScoreAlert = true
        
        completedRounds += 1
    }
    
    func playRound() {
        compChoice = Choices.allCases[Int.random(in: 0...2)]
        winOrLose = Bool.random()
        playerChoice = .paper
        
        if completedRounds == 10 {
            showFinalScoreAlert = true
        }
    }
    
    func restartGame() {
        completedRounds = 0
        score = 0
    }
}

func verifyHands(compChoice: Choices, playerChoice: Choices, gameCondition playerToWin: Bool) -> Bool {
    if playerToWin {
        switch compChoice {
        case .rock:
            return playerChoice == .paper
        case .paper:
            return playerChoice == .scissors
        case .scissors:
            return playerChoice == .rock
        }
    } else {
        switch compChoice {
        case .rock:
            return playerChoice == .scissors
        case .paper:
            return playerChoice == .rock
        case .scissors:
            return playerChoice == .paper
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

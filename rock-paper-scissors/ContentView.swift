//
//  ContentView.swift
//  rock-paper-scissors
//
//  Created by Melody Davis on 1/18/23.
//

import SwiftUI

enum Choices: String, CaseIterable {
    case rock = "🪨"
    case paper = "📃"
    case scissors = "✂️"
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
            LinearGradient(colors: [Color(red: 0.38, green: 0.52, blue: 0.85), .white], startPoint: .top, endPoint: .bottom)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .padding(10)
                }
                Spacer()
                Section {
                    Text("Computer chooses:")
                    Text(compChoice.rawValue)
                        .font(.system(size: 60))
                }
                Spacer()
                Section {
                    Text("To")
                    Text(winOrLose ? "win".uppercased() : "lose".uppercased())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(winOrLose ? .green : .red)
                        .padding(5)
                    Text("Please choose:")
                    Picker("Game Choices", selection: $playerChoice) {
                        ForEach(Choices.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Spacer()
                Button("Submit") {
                    let wasWon = verifyHands(compChoice: compChoice, playerChoice: playerChoice, gameCondition: winOrLose)
                    adjustScore(wasWon)
                }
                .padding()
                .background(.white)
                .buttonBorderShape(.roundedRectangle)
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
        } .ignoresSafeArea()
    }
    
    func adjustScore(_ wasWon: Bool) {
        // if round was won, add one point, or else subtract one point
        if wasWon {
            score += 1
            scoreTitle = "👏 Congratulations! 👏"
        } else {
            score -= 1
            scoreTitle = "😑 Mmm... Let's try this again."
        }
        
        showScoreAlert = true
        
        completedRounds += 1
    }
    
    func playRound() {
        // randomize all game states for next round
        compChoice = Choices.allCases[Int.random(in: 0...2)]
        winOrLose = Bool.random()
        playerChoice = .paper
        
        // if 10 games were completed, show the final score alert
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
        // if player should win, they need to pick...
        switch compChoice {
        case .rock:
            return playerChoice == .paper
        case .paper:
            return playerChoice == .scissors
        case .scissors:
            return playerChoice == .rock
        }
    } else {
        // if player should lose, they need to pick...
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

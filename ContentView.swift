

import SwiftUI

protocol GameGesture {
    func beats(_ other: GameGesture) -> Bool
    var name: String { get }
}

enum Move: String, CaseIterable, GameGesture {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"

    var name: String {
        return self.rawValue
    }

    func beats(_ other: GameGesture) -> Bool {
        if let otherMove = other as? Move {
            switch (self, otherMove) {
            case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
                return true
            default:
                return false
            }
        }
        return false
    }
}

struct ContentView: View {
    @State private var playerMove = ""
    @State private var computerMove = ""
    @State private var result = "Choose your move"

    var body: some View {
        VStack(spacing: 30) {
            Text("Rock Paper Scissors")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("You: \(playerMove)")
            Text("Computer: \(computerMove)")

            Text(result)
                .font(.title2)
                .foregroundColor(.blue)

            HStack(spacing: 20) {
                ForEach(Move.allCases, id: \.self) { move in
                    Button(action: {
                        play(move)
                    }) {
                        Text(move.name)
                            .frame(width: 100, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding()
    }

    func play(_ player: Move) {
        let computer = Move.allCases.randomElement()!

        playerMove = player.name
        computerMove = computer.name

        if player == computer {
            result = "Draw"
        } else if player.beats(computer) {
            result = "You win 🎉"
        } else {
            result = "You lose 😢"
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marcel Mravec on 03.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = [0.0, 0.0, 0.0]
    @State private var opacities = [ 1.0, 1.0, 1.0 ]
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var gameRounds = 0
    @State private var gameOver = false
    @State private var highScore = 0
    @State private var wrongAnswer = false
    @State private var tappedAnswer = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                            Text("Tap the flag of")
                            .foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                            Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                        
                        }
                ForEach(0..<3) { number in
                    Button {
                        if number == correctAnswer {
                        withAnimation {
                            animationAmount[number] += 360
                            flagTapped(number)
                        }
                        } else {
                            withAnimation {
                                
                                flagTapped(number)
                                wrongAnswer = true
                            }
                            //opacities[number] = 0.2
                        }
                        if wrongAnswer == false {
                            askQuestion()
                        }
                            
                           
                    } label: {
                            Image(countries[number])
                                .renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
                        }
                    .rotation3DEffect(.degrees(animationAmount[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.opacities[number])
                    
                        
                }
                
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                Text("High Score: \(highScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
        } // end ZStack
//        .alert(scoreTitle, isPresented: $showingScore) {
//            Button("Continue", action: askQuestion)
//        } message: {
//            Text("Your score is \(userScore)")
//        }
        .alert("Game Over", isPresented: $gameOver) {
            
            Button("New Game?") {
                if userScore > highScore {
                    highScore = userScore
                }
                newGame()
            }
        } message: {
            Text("Starting a new game")
            
        }
        .alert("Wrong answer", isPresented: $wrongAnswer) {
            Button(role: .cancel) {
                askQuestion()
            } label: {
                Text("This is flag of \(countries[tappedAnswer]).")
            }
        }
    } // end body
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 5
            gameRounds += 1
        } else {
            scoreTitle = "Wrong"
            userScore -= 15
            gameRounds += 1
            wrongAnswer = true
            tappedAnswer = number
        }

        showingScore = true
    }
    
    func askQuestion() {
        if gameRounds == 7 {
            gameOver = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func newGame() {
        gameOver = false
        gameRounds = 0
        userScore = 0
        countries.shuffle()
    }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

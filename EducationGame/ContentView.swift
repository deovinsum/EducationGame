// Created by deovinsum

import SwiftUI

struct ContentView: View {
    
    let contentNumbers = Array(2...9)
    let quantityQuestions = [5, 10, 15, 20 ,25]
    
    @State private var upToNumber = 2
    @State private var upToQuestion = 5
    
    @State private var gamesPlayed = 1
    @State private var totalScore = 0
    
    @State private var userAnswer = ""
    @State private var currentQuestion: Question?
    
    @State private var showingAlert = false
    @State private var showingSettings = true
    
    @FocusState private var answerIsFocused: Bool
    
    var body: some View {
        NavigationStack {
                Form {
                    Section("Select Up To") {
                        Picker("Select Up To", selection: $upToNumber) {
                            ForEach(contentNumbers, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(showingSettings == false)
                        .pickerStyle(.segmented)
                    }
                    Section("How many questions you want") {
                        Picker("How many questions you want", selection: $upToQuestion) {
                            ForEach(quantityQuestions, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.segmented)
                        .disabled(showingSettings == false)
                        
                    }
//                    Section("New Game") {
                        Button("New Game") {
                            newGame()
                        }
//                    }
                    
                    if let question = currentQuestion?.question {
                        Section("Question \(gamesPlayed) out of \(upToQuestion)") {
                            Text("\(question)")
                        }
                    }
                    
                    if currentQuestion != nil {
//                        Section("Enter your answer") {
                            TextField("Enter your answer", text: $userAnswer)
                                .keyboardType(.decimalPad)
                                .focused($answerIsFocused)
//                        }
                    }
                    
                }
//                .navigationTitle("EducationGame")
                .toolbar {
                    if answerIsFocused {
                        Button("Done") {
                            answerIsFocused = false
                            buttonTapped(userAnswer)
                        }
                    }
                }
            
        }
        .alert("The Game End", isPresented: $showingAlert) {
            Button("OK") {
                currentQuestion = nil
                showingSettings = true
            }
        } message: {
            Text("After \(gamesPlayed) questions correctly answered is \(totalScore)")
        }
    }
    
    func askQuestion() -> Void {
        var n: Int
        
        if questionsArray.isEmpty {
            generateQuestions(intArray: contentNumbers)
            n = 8 * (upToNumber - 1)
            n -= 1
            questionsArray = Array(questionsArray[0...n])
        }
        
        
        if upToNumber <= 3, upToQuestion <= 15 {
        currentQuestion =  questionsArray.randomElement()
        } else {
            questionsArray.shuffle()
            currentQuestion = questionsArray.removeLast()
        }
        
        showingSettings = false
        
    }
    
    func buttonTapped(_ answer: String) {
        if answer == String(currentQuestion!.answer) {
            totalScore += 1
        }
        gameResume()
    }
    
    func gameResume() {
        if gamesPlayed == upToQuestion {
            showingAlert = true
        } else {
            askQuestion()
            userAnswer = ""
            gamesPlayed += 1
        }
    }
    
    func newGame() {
        gamesPlayed = 0
        gameResume()
        
    }
}
    

#Preview {
    ContentView()
}

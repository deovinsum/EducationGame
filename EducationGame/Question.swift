// Created by deovinsum

import Foundation

struct Question {
    var question: String
    var answer: Int
}

var questionsArray: [Question] = []

func generateQuestions( intArray: [Int]) -> Void {
    for first in intArray {
        for second in intArray {
            let questionTemplate = "How much \(first) x \(second)?"
            let answer = first * second
            let tempQuestion = Question(question: questionTemplate, answer: answer)
            questionsArray.append(tempQuestion)
        }
    }
}

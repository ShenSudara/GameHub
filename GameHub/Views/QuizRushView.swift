//
//  QuizRushView.swift
//  GameHub
//
//  Created by Ashen Sudaraka on 2026-07-03.
//

import SwiftUI

struct QuizRushView: View {
    // view model
    @StateObject private var quizRushVM = QuizRushViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // header cards
            HStack {
                QuizRushScoreCard(title: "SCORE", value: quizRushVM.getScore())
                QuizRushQuestionCountCard(title: "QUESTIONS", currentQuestion: quizRushVM.getCurrentIndex() + 1, totalQuestions: max(quizRushVM.getTotalQuestionsCount(), 1))
            }
            .padding(.horizontal)

            // main content
            VStack {
                //progress view
                if quizRushVM.isLoading {
                    ProgressView("Loading Questions...")
                        .tint(.orange)
                        .padding()
                }
                // manual load button
                else if let error = quizRushVM.errorMessage, !error.isEmpty {
                    VStack(spacing: 12) {
                        Text(error)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)

                        Button("Retry") {
                            Task { await quizRushVM.loadQuestions() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
                // question container
                else if quizRushVM.isGameActive() || quizRushVM.isGameReset{
                    // show current question
                    if let question = quizRushVM.currentQuestion {
                        VStack(spacing: 18) {
                            Text(question.question)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.primary)

                            VStack(spacing: 12) {
                                ForEach(question.answers, id: \.self) { answer in
                                    Button(action: {
                                        quizRushVM.selectAnswer(answer)
                                    }) {
                                        Text(answer)
                                            .font(.body)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(RoundedRectangle(cornerRadius: 14).fill(Color.orange))
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                } else {
                    // game over / overview
                    QuizRushOverView(
                        score: quizRushVM.getScore(),
                        highScore: quizRushVM.getHighScore(),
                        onRestart: {
                            Task { await quizRushVM.restartGame() }
                        }
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)

            // start button
            if !quizRushVM.isGameActive() && !quizRushVM.isLoading && quizRushVM.getTotalQuestionsCount() == 0{
                Button(action: {
                    Task { await quizRushVM.loadQuestions() }
                }) {
                    Text("Start Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .padding(.vertical)
        .animation(.easeInOut(duration: 0.3), value: quizRushVM.isGameReset)
    }
}

#Preview {
    QuizRushView()
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/17.
//

import Foundation
import FeelzCommonDomain

public class MainScreenInteractor: MainScreenUseCase {
    private var mainScreenNameWorker: MainScreenNameWorker
    private var mainScreenTimeOfDayWorker: MainScreenTimeOfDayWorker

    public init(mainScreenNameWorker: MainScreenNameWorker,
                mainScreenTimeOfDayWorker: MainScreenTimeOfDayWorker) {
        self.mainScreenNameWorker = mainScreenNameWorker
        self.mainScreenTimeOfDayWorker = mainScreenTimeOfDayWorker
    }

    private func get() async throws -> String? {
        try await mainScreenNameWorker.get()
    }

    private func timeOfDay() -> TimeOfDay {
        mainScreenTimeOfDayWorker.get(date: Date())
    }

    public func sections() async throws -> [MainScreenSection] {
        let name = try await get()
        let timeOfDay = timeOfDay()
        return [
            MainScreenSection(
                items: [
                    .greeting(GreetingSectionItem(timeOfDay: timeOfDay, name: name ?? ""))
                ],
                title: "",
                type: .greeting
            ),
            MainScreenSection(items: [
                .action(ActionSectionItem(title: "Check-in",
                                          subtitle: "Check in with your self and capture your mood.",
                                          imageURL: "app.badge.checkmark.fill",
                                          type: .checkin))
            ], title: "", type: .action),
            MainScreenSection(
                items: [
                    .exercise(ExerciseSectionItem(title: "Affirmation",
                                                  subtitle: "Affirmations to get your day going",
                                                  imageURL: "",
                                                  type: .audio)),
                    .exercise(ExerciseSectionItem(title: "Daily Mantra",
                                                  subtitle: "Find inner peace",
                                                  imageURL: "",
                                                  type: .audio)),
                    .exercise(ExerciseSectionItem(title: "Evening Journal",
                                                  subtitle: "Wind down before bed",
                                                  imageURL: "",
                                                  type: .journal)),
                    .exercise(ExerciseSectionItem(title: "Wow",
                                                  subtitle: "Just WOW",
                                                  imageURL: "",
                                                  type: .journal)),
                    .exercise(ExerciseSectionItem(title: "Compassion",
                                                  subtitle: "become more compassionate",
                                                  imageURL: "",
                                                  type: .journal)),
                    .exercise(ExerciseSectionItem(title: "Empathy Journal",
                                                  subtitle: "learn to grow empathy",
                                                  imageURL: "",
                                                  type: .journal)),
                    .exercise(ExerciseSectionItem(title: "Love Journal",
                                                  subtitle: "cultivate self love",
                                                  imageURL: "",
                                                  type: .journal)),
                    .exercise(ExerciseSectionItem(title: "Average Journal",
                                                  subtitle: "a modern classic",
                                                  imageURL: "",
                                                  type: .journal)),
                    .exercise(ExerciseSectionItem(title: "A Special Journal",
                                                  subtitle: "the most special journal",
                                                  imageURL: "",
                                                  type: .journal))
                ],
                title: "Exercises",
                subtitle: "Helpful Exercises to improve your mental health",
                type: .exercise
            )
        ]
    }
}

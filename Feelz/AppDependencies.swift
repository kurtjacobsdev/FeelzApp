//
//  AppDependencies.swift
//  Feelz
//
//  Created by Kurt Jacobs on 2022/10/15.
//

import Foundation
import FeelzCommonData
import OnboardingFeatureDomain
import OnboardingFeatureData
import MainScreenFeatureData
import MainScreenFeatureDomain
import CheckinFeatureDomain
import CheckinFeatureData
import EntriesFeatureDomain
import EntriesFeatureData

class AppDependencies: AppCoordinatorDependencies {
    // Repository
    var defaultsStorage: LocalStorage = UserDefaultsLocalStorage()
    var realmDatabase: DatabaseStorage = RealmDatabaseStorage()

    // Worker
    lazy var nameEntryWorker: OnboardingNameEntryWorker = DefaultsOnboardingNameEntryWorker(storage: defaultsStorage)
    lazy var mainScreenNameWorker: MainScreenNameWorker = DefaultsMainScreenNameWorker(storage: defaultsStorage)
    lazy var mainScreenTimeOfDayWorker: MainScreenTimeOfDayWorker = LocalMainScreenTimeOfDayWorker()
    lazy var checkinWorker: CheckinWorker = RealmCheckinWorker(database: realmDatabase)
    lazy var checkinEntryWorker: CheckinEntryWorker = RealmCheckinEntryWorker(database: realmDatabase)
    lazy var onboardingCompletionStatusWorker: OnboardingCompletionStatusWorker = DefaultsOnboardingCompletionStatusWorker(storage: defaultsStorage)
    lazy var checkinEntryDetailWorker: CheckinEntryDetailWorker = RealmCheckinEntryDetailWorker(database: realmDatabase)

    // UseCase
    lazy var nameEntryUseCase: OnboardingNameEntryUseCase = OnboardingNameEntryInteractor(nameEntryWorker: nameEntryWorker)
    lazy var mainScreenUseCase: MainScreenUseCase = MainScreenInteractor(mainScreenNameWorker: mainScreenNameWorker, mainScreenTimeOfDayWorker: mainScreenTimeOfDayWorker)
    lazy var checkinInteractor = CheckinInteractor(checkinWorker: checkinWorker)
    lazy var moodCaptureUseCase: MoodCaptureUseCase = checkinInteractor
    lazy var notesCaptureUseCase: NotesCaptureUseCase = checkinInteractor
    lazy var checkinSummaryUseCase: CheckinSummaryUseCase = checkinInteractor
    lazy var onboardingCompletionStatusUseCase: OnboardingCompletionStatusUseCase = OnboardingCompletionStatusInteractor(completionStatusWorker: onboardingCompletionStatusWorker)
    lazy var entriesListingUseCase: EntriesListingUseCase = EntriesListingInteractor(checkinEntryWorker: checkinEntryWorker)
    lazy var entriesDetailUseCase: EntriesDetailUseCase = EntriesDetailInteractor(checkinEntryDetailWorker: checkinEntryDetailWorker)
}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/19.
//

import UIKit
import FeelzCommonUI

public protocol ExercisesCoordinatorDependencies {}

public protocol ExercisesCoordinatorDelegate: AnyObject {
    func didFinishExercise()
}

public class ExercisesCoordinator {
    public weak var delegate: ExercisesCoordinatorDelegate?
    private let dependencies: ExercisesCoordinatorDependencies
    private (set) public var navigationController: UINavigationController = FeelzNavigationController()
    private var journalViewController: JournalViewController?
    private var audioViewController: AudioViewController?

    public init(dependencies: ExercisesCoordinatorDependencies) {
        self.dependencies = dependencies
        setup()
    }

    func setup() {

    }

    public func startJournal(identifier: String) {
        let journalViewController = JournalViewController(viewModel: JournalViewModel())
        journalViewController.delegate = self
        self.journalViewController = journalViewController
        navigationController.viewControllers = [journalViewController]
    }

    public func startAudio(identifier: String) {
        let audioViewController = AudioViewController(viewModel: AudioViewModel())
        audioViewController.delegate = self
        self.audioViewController = audioViewController
        navigationController.viewControllers = [audioViewController]
    }

}

extension ExercisesCoordinator: JournalViewControllerDelegate {
    public func didFinishJournalViewController() {
        delegate?.didFinishExercise()
    }
}

extension ExercisesCoordinator: AudioViewControllerDelegate {
    public func didFinishAudioViewController() {
        delegate?.didFinishExercise()
    }
}

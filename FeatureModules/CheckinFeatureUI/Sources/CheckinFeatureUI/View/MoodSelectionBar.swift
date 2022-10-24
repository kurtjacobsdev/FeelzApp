//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import UIKit
import FeelzCommonUI

class MoodSelectionBar: UIView {
    private var moodButtons: [UIButton] = []
    private var buttonStack = UIStackView()
    private var currentSelectedLabel = UILabel()
    private (set) var currentMood: Mood?

    init() {
        super.init(frame: .zero)
        setup()
        configureHierarchy()
        configureConstraints()
        configureProperties()
        configureStyling()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        for mood in Mood.allCases {
            let button = UIButton()
            button.titleLabel?.textAlignment = .center
            button.tag = mood.tag
            button.setTitle(mood.emoji, for: .normal)
            moodButtons.append(button)
            buttonStack.addArrangedSubview(button)
            button.snp.makeConstraints {
                $0.width.equalTo(50)
                $0.height.equalTo(50)
            }
            button.layer.cornerRadius = 25
            button.backgroundColor = AppColor.primary.withAlphaComponent(0.6)
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 4
            button.addTarget(self, action: #selector(selectMood), for: .touchUpInside)
        }
    }

    private func configureHierarchy() {
        addSubview(buttonStack)
        addSubview(currentSelectedLabel)
    }

    private func configureConstraints() {
        currentSelectedLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(buttonStack.snp.bottom).offset(20)
            $0.height.equalTo(26)
        }

        buttonStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureStyling() {

    }

    private func configureProperties() {
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.alignment = .center
        buttonStack.spacing = 20
        currentSelectedLabel.numberOfLines = 0
        currentSelectedLabel.textAlignment = .center
        currentSelectedLabel.textColor = .white
        currentSelectedLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }

    @objc func selectMood(button: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn) {
            for moodButton in self.moodButtons {
                moodButton.snp.updateConstraints {
                    $0.height.equalTo(50)
                    $0.width.equalTo(50)
                }
                moodButton.layer.cornerRadius = 25
                moodButton.titleLabel?.font = .systemFont(ofSize: 16)
            }
            self.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn) {
            button.snp.updateConstraints {
                $0.height.equalTo(80)
                $0.width.equalTo(80)
            }
            button.layer.cornerRadius = 40
            button.titleLabel?.font = .systemFont(ofSize: 36)
            self.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.2) {
            self.currentSelectedLabel.alpha = 0.0
            self.currentMood = Mood.allCases.first(where: {$0.tag == button.tag})
            self.currentSelectedLabel.text = self.currentMood?.title
            UIView.animate(withDuration: 0.2) {
                self.currentSelectedLabel.alpha = 1.0
            }
        }

    }

}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/20.
//

import UIKit

public class RoundedTextView: UITextView {
    public init() {
        super.init(frame: .zero, textContainer: nil)
        self.backgroundColor = AppColor.primary
        self.textColor = AppColor.secondary
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.tintColor = AppColor.text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }

}

//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/24.
//

import UIKit

public class RoundedLabel: UILabel {
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = AppColor.primary
        self.textColor = AppColor.secondary
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.tintColor = AppColor.text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var topInset: CGFloat = 10
    var bottomInset: CGFloat = 10
    var leftInset: CGFloat = 20
    var rightInset: CGFloat = 20

    public override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: rect.inset(by: insets))
        }

    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    public override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }

    public override func layoutSubviews() {
        if self.text == nil || self.text?.isEmpty == true { self.isHidden = true } else { self.isHidden = false }
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}

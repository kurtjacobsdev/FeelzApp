//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/11.
//

import UIKit

public class RoundedTextField: UITextField {
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = AppColor.primary
        self.textColor = AppColor.secondary
        self.font = .systemFont(ofSize: 20, weight: .bold)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var insetX: CGFloat = 25
    private var insetY: CGFloat = 0

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
}

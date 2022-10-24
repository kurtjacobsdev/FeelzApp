//
//  File.swift
//  
//
//  Created by Kurt Jacobs on 2022/10/18.
//

import UIKit

public class SectionHeaderView: UICollectionReusableView {
    public var title: UILabel = UILabel()
    public var subtitle: UILabel = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureConstraints()
        configureProperties()
        configureStyling()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureHierarchy() {
        self.addSubview(title)
        self.addSubview(subtitle)
    }

    private func configureConstraints() {
        title.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
        }

        subtitle.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview().inset(16)
            $0.top.equalTo(title.snp.bottom).offset(2)
        }
    }

    private func configureStyling() {
        title.textColor = AppColor.background
        subtitle.textColor = AppColor.background
    }

    private func configureProperties() {
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 36, weight: .bold)
        subtitle.numberOfLines = 0
        subtitle.font = .systemFont(ofSize: 14, weight: .medium)
    }
}

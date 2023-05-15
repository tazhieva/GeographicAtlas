//
//  HeaderTitleView.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 15.05.2023.
//

import UIKit

class HeaderTitleView: UIView {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(red: 0.672, green: 0.702, blue: 0.732, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Config UI
extension HeaderTitleView {
    func configUI() {
        backgroundColor = .clear
        
        addSubview(titleLabel)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.left.equalToSuperview().offset(24)
            m.right.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(-10)
        }
    }
}

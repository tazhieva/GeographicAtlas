//
//  CountryInfoCell.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//

import UIKit
import SnapKit

class CountryInfoCell: UITableViewCell {
    
    
    static let identifier = "CountryInfoCell"
    
    var expandClicked: (() -> Void)?
    
    var isExpanded: Bool = false
    
    // MARK: - UIElements
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Japan"
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Tokyo"
        return label
    }()
    
    fileprivate lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .equalSpacing
        return stack
    }()
    
    fileprivate let flagImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "flag"))
        image.frame.size = CGSize(width: 12, height: 12)
        return image
    }()
    
    fileprivate lazy var expandButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "expandButton"), for: .normal)
        btn.frame.size = CGSize(width: 14, height: 8)
        btn.addTarget(self, action:#selector(expandTapped), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellColor")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate let populationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Population: 19 mln"
        return label
    }()
    
    fileprivate let areaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Population: 19 mln"
        return label
    }()
    
    fileprivate let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Population: 19 mln"
        return label
    }()
    
    fileprivate let learnMoreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Learn More", for: .normal)
        btn.tintColor = .blue
        return btn
    }()
    
    
    fileprivate lazy var vStack2: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [populationLabel, areaLabel, currencyLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Actions
extension CountryInfoCell {
    @objc func expandTapped() {
        expandClicked?()
        isExpanded.toggle()
    }
}

//MARK: - ConfigUI

extension CountryInfoCell {
    private func configUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(mainContainer)
        
        [flagImageView, vStackView, expandButton].forEach {
            mainContainer.addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        mainContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(12)
        }
        
        vStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(flagImageView.snp.right).offset(12)
        }
        
        expandButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(17)
            make.top.bottom.equalToSuperview().inset(4)
        }
    }
}


//
//bottomContainer.snp.makeConstraints { make in
//    make.top.equalTo(topContainer.snp.bottom).offset(12)
//    make.left.right.equalToSuperview()
//    make.bottom.equalToSuperview()
//    make.height.equalTo(200)
//}
//
//vStack2.snp.makeConstraints { make in
//    make.top.equalToSuperview()
//    make.left.equalToSuperview().offset(12)
//    make.bottom.equalToSuperview().offset(24)
//}
//
//learnMoreButton.snp.makeConstraints { make in
//    make.top.equalTo(vStack2.snp.bottom).offset(26)
//    make.centerX.equalTo(bottomContainer.snp.centerX)
//}

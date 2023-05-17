//
//  CountryListCell.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 15.05.2023.
//

import UIKit
import SnapKit

class CountryListCell: UITableViewCell {
    
    static let identifier = Constants.countryInfoCellIdentifier
    
    var flagImage: UIImage? {
        didSet {
            guard let flagImage = flagImage else { return }
            flagImageView.image = flagImage
        }
    }
    
    var learnMoreButtonClicked: (() -> Void)?
//    var expandButtonClicked: (() -> Void)?
    var isExpanded: Bool = false
    
    // MARK: - UI Elements
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let flagImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var expandButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Constants.expandButtonImageName), for: .normal)
        btn.frame.size = CGSize(width: 14, height: 8)
        btn.addTarget(self, action:#selector(expandButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var countryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryNameLabel, capitalLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private lazy var cardStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [flagImageView, countryStackView, expandButton])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .fill
        return stack
    }()
    
    private let populationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var detailStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [populationLabel, areaLabel, currencyLabel, learnMoreButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
//        stack.isHidden = true
        return stack
    }()
    
    private let learnMoreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        btn.setTitle(Constants.learnMoreButtonTitle, for: .normal)
        btn.setTitleColor(UIColor(red: 0, green: 0.478, blue: 1, alpha: 1), for: .normal)
        btn.addTarget(self, action:#selector(learnMoreButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.cellColor)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension CountryListCell {
    func configureLabels(country: Country) {
        countryNameLabel.text = country.name.common
        capitalLabel.text =  country.capital?.first
        
        let populationText = "Population: \(formatPopulation(country.population ?? 0))"
        populationLabel.attributedText = attributedText(withText: populationText)

        let areaText = "Area: \(formatArea(country.area ?? 0)) km²"
        areaLabel.attributedText = attributedText(withText: areaText)
        
        if let curr = country.currencies {
            curr.forEach {
                let currencyText = "Currency: \($0.value.name ?? "Tenge (₸) (KZT)")"
                currencyLabel.attributedText = attributedText(withText: currencyText)
            }
        }
    }
}

// MARK: - Actions

extension CountryListCell {
    @objc func expandButtonTapped() {
        isExpanded.toggle()
        if isExpanded {
            detailStackView.isHidden = false
            expandButton.setImage(UIImage(named: Constants.collapseButtonImageName), for: .normal)
        } else {
            detailStackView.isHidden = true
            expandButton.setImage(UIImage(named: Constants.expandButtonImageName), for: .normal)
        }
    }
    
    @objc func learnMoreButtonTapped() {
        learnMoreButtonClicked?()
    }
}

// MARK: - ConfigUI
extension CountryListCell {
    private func configUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(cardStackView)
        mainContainerView.addSubview(detailStackView)
        //        vStackView2.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        cardStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview().offset(-18)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(12)
            make.width.equalTo(82)
            make.height.equalTo(48)
        }
        
        countryStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(flagImageView.snp.right).offset(12)
            
        }
        
        expandButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-18)
        }
        
        detailStackView.snp.makeConstraints{ make in
            make.top.equalTo(cardStackView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(26)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.centerX.equalTo(detailStackView.snp.centerX)
        }
    }
    
}

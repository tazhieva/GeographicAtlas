//
//  CountryListCell.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 15.05.2023.
//

import UIKit
import SnapKit

class CountryListCell: UITableViewCell {
    
    static let identifier = "CountryInfoCell"
    
    var learnMoreButtonClicked: (() -> Void)?
    
    var isExpanded = false
    
    fileprivate let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    fileprivate let flagImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "flag"))
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate lazy var expandButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "expandButton"), for: .normal)
        btn.frame.size = CGSize(width: 14, height: 8)
        btn.addTarget(self, action:#selector(expandButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var vStackView1: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryNameLabel, capitalLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    fileprivate lazy var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [flagImageView, vStackView1, expandButton])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .fill
        //        stack.setCustomSpacing(140, after: vStackView1)
        return stack
    }()
    
    fileprivate let populationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    fileprivate let areaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    fileprivate let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    fileprivate lazy var vStackView2: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [populationLabel, areaLabel, currencyLabel, learnMoreButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.setCustomSpacing(26, after: currencyLabel)
        return stack
    }()
    
    fileprivate let learnMoreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        btn.setTitle("Learn More", for: .normal)
        btn.setTitleColor(UIColor(red: 0, green: 0.478, blue: 1, alpha: 1), for: .normal)
        btn.addTarget(self, action:#selector(learnMoreButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellColor")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabels(country: Country) {
        let countryName = country.name.common
        let capital = country.capital?.first
        let population = country.population ?? 19
        let area = country.area ?? 2724900
        let currency = country.currencies?.afn?.name ?? "Kazakh"
        
        countryNameLabel.text = countryName
        capitalLabel.text = capital
        
        let populationText = "Population: \(formatPopulation(population))"
        populationLabel.attributedText = attributedText(withText: populationText)
        
        let areaText = "Area: \(formatArea(area)) km²"
        areaLabel.attributedText = attributedText(withText: areaText)

        
        let currencyText = "Currency: \(currency)"
        currencyLabel.attributedText = attributedText(withText: currencyText)
    }

}

extension CountryListCell {
    @objc func expandButtonTapped() {
        isExpanded.toggle()
        if isExpanded {
            vStackView2.isHidden = false
            expandButton.setImage(UIImage(named: "collapseButton"), for: .normal)
        } else {
            vStackView2.isHidden = true
            expandButton.setImage(UIImage(named: "expandButton"), for: .normal)
        }
    }
    
    @objc func learnMoreButtonTapped() {
        learnMoreButtonClicked?()
    }
}

extension CountryListCell {
    private func configUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(mainContainer)
        
        mainContainer.addSubview(hStackView)
        mainContainer.addSubview(vStackView2)
        //        vStackView2.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        hStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalToSuperview().offset(-18)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(12)
            make.width.equalTo(82)
            make.height.equalTo(48)
        }
        
        vStackView1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(flagImageView.snp.right).offset(12)
            
        }
        
        expandButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-18)
        }
        
        vStackView2.snp.makeConstraints{ make in
            make.top.equalTo(hStackView.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(26)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.centerX.equalTo(mainContainer.snp.centerX)
        }
    }
    
}

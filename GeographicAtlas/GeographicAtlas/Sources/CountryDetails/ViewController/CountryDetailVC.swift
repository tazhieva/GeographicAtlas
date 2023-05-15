//
//  CountryDetailVC.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 14.05.2023.
//

import UIKit
import SnapKit

class CountryDetailVC: UIViewController {
    
    var country: Country
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "flag")
        return imageView
    }()
    
    let regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.text = "Region:\nAsia"
        label.numberOfLines = 0
        return label
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.text = "Capital:\nAstana"
        label.numberOfLines = 0
        return label
    }()
    
    let capitalCoordinatesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.text = "Capital coordinates:\n51°08′, 71°26′"
        label.numberOfLines = 0
        return label
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.text = "Area: 38928392"
        label.numberOfLines = 0
        return label
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.text = "Currency:\nTenge (₸) (KZT)"
        label.numberOfLines = 0
        return label
    }()
    
    let timezonesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        label.text = "Timezones:\nGMT+6"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [regionLabel, capitalLabel, capitalCoordinatesLabel, populationLabel, areaLabel, currencyLabel, timezonesLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .leading
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configUI()
    }
    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
        configureDetailVC(with: country)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDetailVC(with country: Country) {
        title = country.name.common ?? ""
        regionLabel.text = "Region:\n\(country.subregion ?? "" )"
        capitalLabel.text = "Capital:\n\(country.capital?.first ?? "" )"
        capitalCoordinatesLabel.text = "Capital Coordinates:\n\(country.capitalInfo?.latlng ?? [] )"
        populationLabel.text = "Population: \n\(country.population ?? 0)"
        areaLabel.text = "Area:\n\(country.area ?? 0) km²"
        currencyLabel.text = "Currency: \(country.currencies?.afn?.name ?? "")"
        timezonesLabel.text = "Timezones:\n\(country.timezones ?? []) "
    }
}

extension CountryDetailVC {
    func configUI() {
        view.addSubview(flagImageView)
        view.addSubview(stackView)
        makeConstraints()
        
    }
    func makeConstraints() {
        flagImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}

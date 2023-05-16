//
//  CountryDetailVC.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 14.05.2023.
//

import UIKit
import SnapKit

class CountryDetailVC: UIViewController {
    
    var cca2Code: String
    
    // MARK: - Private Properties
    
    private let viewModel = CountryDetailsViewModel()
    
    // MARK: - UI Elemenets
    
    private let flagImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = -1
        label.frame.size = CGSize(width: 300, height: 800)
        return label
    }()
    
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let capitalCoordinatesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let populationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let timezonesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [regionLabel, capitalLabel, capitalCoordinatesLabel, populationLabel, areaLabel, currencyLabel, timezonesLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 200)
    }
    
    // MARK: - LifeCycyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configUI()
        fetchCountryDetails()
    }
    
    init(cca2Code: String) {
        self.cca2Code = cca2Code
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private Methods
extension CountryDetailVC {
    private func configureLabels(country: Country) {
        let regionText = " Region: \(country.subregion ?? "")"
        regionLabel.attributedText = formatBulletList(withText: regionText)
        
        let capitalText = "Capital: \(country.capital?.first ?? "")"
        capitalLabel.attributedText = formatBulletList(withText: capitalText)
        
        let coordinatesText = "Capital coordinates: \(formatCoordinates(country.capitalInfo?.latlng ?? [0]))"
        capitalCoordinatesLabel.attributedText = formatBulletList(withText: coordinatesText)
        
        let populationText = "Population: \(formatPopulation(country.population ?? 0))"
        populationLabel.attributedText = formatBulletList(withText: populationText)
        
        let areaText = "Area: \(formatNumber(Int(country.area ?? 0))) km²"
        areaLabel.attributedText = formatBulletList(withText: areaText)
        
        let currencyText = "Currency: \(country.currencies?.afn?.name ?? "Tenge (₸) (KZT)")"
        currencyLabel.attributedText = formatBulletList(withText: currencyText)
        
        let timezonesText = "Timezones: \(country.timezones?.joined(separator: ", ") ?? "")"
        timezonesLabel.attributedText = formatBulletList(withText: timezonesText)
    }
}

// MARK: - Fetch Data

extension CountryDetailVC {
    private func fetchCountryDetails() {
        viewModel.getCountryDetails(cca2Code: cca2Code) { [weak self] country, error in
            if let error = error {
                print("Error fetching country details: \(error)")
            } else if let country = country?.first {
                self?.configureLabels(country: country)
                if let urlString = country.flags?.png {
                    self?.viewModel.downloadImage(from: urlString) { [weak self] image in
                        DispatchQueue.main.async {
                            self?.flagImageView.image = image
                        }
                    }
                }
            }
        }
        
    }
}


// MARK: - ConfigUI

extension CountryDetailVC {
    private func configUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(flagImageView)
        scrollView.addSubview(stackView)

        
        makeConstraints()
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        flagImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).inset(20)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

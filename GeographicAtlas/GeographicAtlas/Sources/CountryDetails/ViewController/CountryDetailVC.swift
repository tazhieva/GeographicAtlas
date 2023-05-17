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
    private let imageLoader = ImageDownloader()
    
    // MARK: - UI Elemenets
    
    private let flagImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
    
    private lazy var capitalCoordinatesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openMap)))
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
        DispatchQueue.main.async {
            let regionText = "Region: \(country.subregion ?? "")"
            self.regionLabel.attributedText = self.formatBulletList(withText: regionText)
            
            let capitalText = "Capital: \(country.capital?.first ?? "")"
            self.capitalLabel.attributedText = self.formatBulletList(withText: capitalText)
            
            let coordinatesText = "Capital coordinates: \(self.formatCoordinates(country.capitalInfo?.latlng ?? [0]))"
            self.capitalCoordinatesLabel.attributedText = self.formatBulletList(withText: coordinatesText)
            
            let populationText = "Population: \(self.formatPopulation(country.population ?? 0))"
            self.populationLabel.attributedText = self.formatBulletList(withText: populationText)
            
            let areaText = "Area: \(self.formatNumber(Int(country.area ?? 0))) km²"
            self.areaLabel.attributedText = self.formatBulletList(withText: areaText)
            
            let currencyText = "Currency: \(country.currencies?.afn?.name ?? "Tenge (₸) (KZT)")"
            self.currencyLabel.attributedText = self.formatBulletList(withText: currencyText)
            
            let timezonesText = "Timezones: \(country.timezones?.joined(separator: ", \n\n") ?? "")"
            self.timezonesLabel.attributedText = self.formatBulletList(withText: timezonesText)
        }
    }

}


 // MARK: - Actions

extension CountryDetailVC {
    @objc private func openMap() {
        if let urlString = viewModel.country.first?.maps?.openStreetMaps,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - Fetch Data

extension CountryDetailVC {
    private func fetchCountryDetails() {
        viewModel.getCountryDetails(cca2Code: cca2Code) { [weak self] country, error in
            if let error = error {
                print(error.errorMessage)
            } else if let country = country?.first {
                DispatchQueue.main.async {
                    self?.configureLabels(country: country)
                    if let urlString = country.flags?.png {
                        self?.imageLoader.downloadImage(from: urlString) { image in
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
            make.top.equalTo(scrollView.snp.top).inset(15)
            make.left.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(27)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}

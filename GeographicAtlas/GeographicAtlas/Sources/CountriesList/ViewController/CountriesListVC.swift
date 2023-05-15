//  CountriesListVC.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//

import UIKit
import SnapKit

class CountriesListVC: UIViewController {
    
    private let viewModel = CountryListViewModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = true
        tableView.register(CountryListCell.self, forCellReuseIdentifier: CountryListCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.getCountries { [weak self] in
            print(self?.viewModel.countries)
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UI Configuration
    
    private func configUI() {
        view.addSubview(tableView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension CountriesListVC {
    func openDetaiVC() {
        let detailVC = CountryDetailVC()
        navigationController?.pushViewController(detailVC, animated: false)
    }
}

// MARK: - UITableView

extension CountriesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.identifier, for: indexPath) as? CountryListCell else {
            return UITableViewCell()
        }
        cell.configureLabels(country: viewModel.countries[indexPath.row])
        cell.learnMoreButtonClicked = { [weak self] in
            guard let self = self else { return }
            self.openDetaiVC()
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       
//    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
}


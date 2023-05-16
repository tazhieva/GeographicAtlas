import UIKit
import SnapKit

class CountriesListVC: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel = CountryListViewModel()
    
    // MARK: - UI Elements
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.allowsMultipleSelection = true
        view.register(CountryListCell.self, forCellReuseIdentifier: CountryListCell.identifier)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // MARK: - LifeCycyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backButtonDisplayMode = .minimal
        configureTableView()
        fetchCountries()
    }
}

// MARK: - Fetch Data

extension CountriesListVC {
    private func fetchCountries() {
        viewModel.getCountries { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func openDetaiVC() {
    
    }
}

// MARK: - Configure TableView

extension CountriesListVC {
    private func configureTableView() {
    
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableView

extension CountriesListVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.countriesByContinent.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let continent = Continent.allCases[section]
        return continent.rawValue.uppercased()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let continent = Continent.allCases[section]
        return viewModel.countriesByContinent[continent]?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryListCell.identifier, for: indexPath) as? CountryListCell else {
            return UITableViewCell()
        }
        
        let continent = Continent.allCases[indexPath.section]
        guard let country = viewModel.countriesByContinent[continent]?[indexPath.row], let cca2 = country.cca2 else {
            return cell
        }
        
        if let urlString = country.flags?.png {
            viewModel.downloadImage(from: urlString) { [weak self] image in
                cell.flagImage = image
            }
        }
        
        cell.configureLabels(country: country)
        cell.learnMoreButtonClicked = { [weak self] in
            guard let self = self else { return }
            let detailVC = CountryDetailVC(cca2Code: cca2)
            detailVC.title = country.name.common
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        return cell
    }
}

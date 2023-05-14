//  CountriesListVC.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 13.05.2023.
//

import UIKit
import SnapKit

class CountriesListVC: UIViewController {

    var expandedCell: IndexSet = []
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = true
        tableView.register(CountryInfoCell.self, forCellReuseIdentifier: CountryInfoCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
     let cell = CountryInfoCell()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        tableView.delegate = self
        tableView.dataSource = self
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
// MARK: - UITableView DataSource

extension CountriesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryInfoCell.identifier, for: indexPath) as? CountryInfoCell else {return UITableViewCell()}
        
        cell.expandClicked = {
            if self.expandedCell.contains(indexPath.row) {
                self.expandedCell.remove(indexPath.row)
            }else {
                self.expandedCell.insert(indexPath.row)
            }
            print("11")
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cell.isExpanded { return 300 }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


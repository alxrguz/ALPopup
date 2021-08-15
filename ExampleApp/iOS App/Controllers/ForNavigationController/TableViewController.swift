//
//  TableViewController.swift
//  ALPopupController Example
//
//  Created by Alexandr Guzenko on 16.08.2021.
//  Copyright © 2021 alxrguz. All rights reserved.
//

import UIKit

final class TableViewController: UITableViewController {
    
    // MARK: - Life cycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Open Methods
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        cell.textLabel?.text = String("Content #" + String(indexPath.row + 1))
        cell.detailTextLabel?.text = "Detail"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentDetail(at: indexPath.row + 1)
    }
}

// MARK: - Navigation
private extension TableViewController {
    func presentDetail(at index: Int) {
        let vc = DetailViewController()
        vc.titleLabel.text = String(index)
        navigationController?.pushViewController(vc)
    }
}

// MARK: - Layout Setup
private extension TableViewController {
    func setupColors() {
        
    }
    
    func setupView() {
        setupColors()
        
        navigationItem.do {
            $0.title = "Navigation Example"
        }
    }
}


//
//  ViewController.swift
//  CodingAssign
//
//  Created by Ruoming Gao on 4/10/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//
import UIKit
import Foundation

class ViewController: UIViewController {
    var viewModel: ViewModelProtocol?
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        let updateCallBack: ()->Void = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel = ViewModel(updateCallBack: updateCallBack)
        viewModel?.loadData()
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }
    
    func setupTableView() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.getConfigure(viewModelLoadImage: viewModel?.getViewModelImage(index: indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.getConfigure(viewModelLoadImage: viewModel?.getViewModelImage(index: indexPath.row))
        return cell
    }
}

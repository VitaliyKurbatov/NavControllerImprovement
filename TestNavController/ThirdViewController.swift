//
//  ThirdViewController.swift
//  TestNavController
//
//  Created by Vitaliy on 12.07.2021.
//

import UIKit

class ThirdViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.dataSource = self
        return tv
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func didTapBackButton() {
        print("didTapBackButton on \(String(describing: Self.self))")
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Third VC"
        addTwoLinesTitle()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func addTwoLinesTitle() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let firstLabel = UILabel()
        firstLabel.font = UIFont.boldSystemFont(ofSize: 23)
        firstLabel.textAlignment = .center
        
        let secondLabel = UILabel()
        secondLabel.font = UIFont.boldSystemFont(ofSize: 23)
        secondLabel.textAlignment = .center
        
        [firstLabel, secondLabel].forEach { stackView.addArrangedSubview($0) }
        
        firstLabel.text = "First label"
        secondLabel.text = "Second label"
        
        navigationItem.titleView = stackView
    }
}


extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        cell.selectionStyle = .none
        return cell
    }
}

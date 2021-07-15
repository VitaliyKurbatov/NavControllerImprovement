//
//  SecondViewController.swift
//  TestNavController
//
//  Created by Vitaliy on 07.07.2021.
//

import UIKit

class SecondViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.dataSource = self
        return tv
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = Button { [weak self] in
            self?.didTapButton()
        }
        return button
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func willTapBackButton() -> Bool {
        let alert = UIAlertController(title: "Уверен?", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .cancel, handler: { [weak self] _ in
            self?.popForce()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        return false
    }
    
    override func didTapBackButton() {
        print("didTapBackButton on \(String(describing: Self.self))")
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Second VC"
        
        view.addSubview(tableView)
        view.addSubview(bottomButton)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -16),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
    }
    
    private func didTapButton() {
        let vc = ThirdViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SecondViewController: UITableViewDataSource {
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

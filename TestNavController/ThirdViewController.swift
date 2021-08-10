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
        tv.delegate = self
        return tv
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    let array = [[1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3], [1, 2, 3]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
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
        addTwoLinesTitle(first: "First label", second: "Second label")
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension ThirdViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(array[indexPath.section][indexPath.row]) // "\(array[indexPath.section][indexPath.row])"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .purple

        let label = UILabel()
        label.textColor = .white
        label.accessibilityTraits = .header
        label.text = "Section \(section)"

        let button = UIButton()
        button.backgroundColor = .clear
        button.accessibilityTraits = .button
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Button", for: .normal)

        [label, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: button.leadingAnchor, constant: -16),

            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)
        ])
        
        // Не включать. От этого возникают проблемы со свайпом по заголовкам секций.
        //view.accessibilityElements = [label, button]
        return view
    }
}

//
//  FirstViewController.swift
//  TestNavController
//
//  Created by Vitaliy on 07.07.2021.
//

import UIKit

class FirstViewController: UIViewController {
    private lazy var progressBar: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.tintColor = .purple
        view.trackTintColor = .white
        return view
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
        setupBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        addProgressBar()
        bottomButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startProgressBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressBar.removeFromSuperview()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "First VC"
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])
    }
    
    private func addProgressBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        ])
    }
    
    private func startProgressBar() {
        progressBar.isHidden = false
        progressBar.setProgress(1, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [weak self] in
            self?.progressBar.isHidden = true
            self?.progressBar.progress = 0
            self?.bottomButton.isHidden = false
        }
    }
    
    private func didTapButton() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

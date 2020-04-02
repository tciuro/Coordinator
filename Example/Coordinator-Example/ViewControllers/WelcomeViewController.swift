//  WelcomeViewController.swift
//  Coordinator-Example
//
//  Created by Dave Neff.

import UIKit

// MARK: - Delegate

protocol WelcomeViewControllerDelegate: class {
    func welcomeControllerDidTapButton(_ controller: WelcomeViewController)
}

// MARK: - View Controller

final class WelcomeViewController: UIViewController {
    
    weak var delegate: WelcomeViewControllerDelegate?
    
    // MARK: - UI Elements
    
    private let titleLabel = UILabel {
        $0.setDefaultStyle(size: .title, weight: .heavy)
    }
    
    private let descriptionLabel = UILabel {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.setDefaultStyle(size: .paragraph, weight: .light)
    }
    
    private let button = UIButton(type: .system).applying {
        $0.addTarget(nil, action: #selector(didTapButton), for: .touchUpInside)
        $0.titleLabel?.setDefaultStyle(size: .paragraph, weight: .semibold)
    }
    
    // MARK: - Init
    
    init(title: String?, description: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        descriptionLabel.text = description
        button.setTitle(buttonTitle, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureConstraints()
    }
    
}

// MARK: - Configuration

private extension WelcomeViewController {
    
    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let padding: CGFloat = 30
        
        view.addSubview(titleLabel, constraints: [titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
                                                  titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        view.addSubview(descriptionLabel, constraints: [descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                                        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                                                        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
        view.addSubview(button, constraints: [button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -(padding / 2)),
                                              button.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
}

// MARK: - Action

private extension WelcomeViewController {
    
    @objc func didTapButton() {
        delegate?.welcomeControllerDidTapButton(self)
    }
    
}

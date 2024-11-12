//
//  ViewController.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//

import UIKit
import Combine

final class AuthViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()
    private let viewModel = AuthViewModel()
    let settingsScreen = SettingsScreen()

    private var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name here"
        textField.borderStyle = .roundedRect
        return textField
    }()

     private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email here"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private var saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .trailing
        config.imagePadding = 10
        config.image = UIImage(systemName: "square.and.arrow.down")
        config.cornerStyle = .medium
        config.title = "Save"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        })
        let button = UIButton(configuration: config)
        return button
    }()

    @Autolayout private var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.spacing = 16
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        return vStack
    }()

    @Autolayout private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Name is:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    @Autolayout private var storedNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    @Autolayout private var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Email is:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    @Autolayout private var storedEmailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    @Autolayout private var labelsVStack: UIStackView = {
        let vStack = UIStackView()
        vStack.spacing = 16
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        return vStack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupUI()
        setupCredentials()
        addActions()
        setAppTheme()

    }
    
    private func setupCredentials() {
        storedNameLabel.text = viewModel.getCredentials().0
        storedEmailLabel.text = viewModel.getCredentials().1
    }

    private func setupUI() {
        vStack.addArrangedSubview(usernameTextField)
        vStack.addArrangedSubview(emailTextField)
        vStack.addArrangedSubview(saveButton)
        view.addSubview(vStack)
        view.addSubview(labelsVStack)
        labelsVStack.addArrangedSubview(nameLabel)
        labelsVStack.addArrangedSubview(storedNameLabel)
        labelsVStack.addArrangedSubview(emailLabel)
        labelsVStack.addArrangedSubview(storedEmailLabel)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.widthAnchor.constraint(equalToConstant: 340),

            labelsVStack.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 12),
            labelsVStack.widthAnchor.constraint(equalToConstant: 250),
            labelsVStack.heightAnchor.constraint(equalToConstant: 200),
            labelsVStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupBindings() {

        viewModel.$username
            .map({ $0 })
            .assign(to: \.text, on: storedNameLabel)
            .store(in: &cancellables)

        viewModel.$email
            .map({ $0 })
            .assign(to: \.text, on: storedEmailLabel)
            .store(in: &cancellables)

        viewModel.$buttonIsActive
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellables)

        viewModel.$usernameTextColor
            .assign(to: \.textColor, on: usernameTextField)
            .store(in: &cancellables)

        viewModel.$emailTextColor
            .assign(to: \.textColor, on: emailTextField)
            .store(in: &cancellables)
    }
}

// MARK: Actions
private extension AuthViewController {

    private func addActions() {
        let saveAction = UIAction { _ in
            self.viewModel.saveCredentials(name: self.storedNameLabel.text!, email: self.storedEmailLabel.text!)
        }
        saveButton.addAction(saveAction, for: .primaryActionTriggered)

        let rightBarButton = UIBarButtonItem(
            image: UIImage(
                systemName: "gearshape"
            ),
            style: .plain,
            target: self,
            action: #selector(
                openSettings
            )
        )
        rightBarButton.tintColor = .white

        navigationItem.rightBarButtonItem = rightBarButton

        usernameTextField.addTarget(self, action: #selector(userNameChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
    }

    @objc private func userNameChanged() {
        viewModel.username = usernameTextField.text ?? ""
    }

    @objc private func emailChanged() {
        viewModel.email = emailTextField.text ?? ""
    }

    @objc private func openSettings() {
        present(settingsScreen, animated: true)
    }
}


// MARK: Setting app theme
private extension AuthViewController {
    func setAppTheme() {

        settingsScreen.viewModel.$themePublisher
            .sink { [weak self] theme in
                guard let self else { return }
                view.backgroundColor = theme.background
                saveButton.configuration?.baseBackgroundColor = theme.blue
                storedNameLabel.backgroundColor = theme.secondaryText
                storedEmailLabel.backgroundColor = theme.secondaryText
            }
            .store(in: &cancellables)
    }
}


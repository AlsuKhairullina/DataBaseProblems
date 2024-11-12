//
//  SettingsScreen.swift
//  DataBaseSolutions
//
//  Created by Alexander Korchak on 13.12.2023.
//

import UIKit
import Combine

final class SettingsScreen: UIViewController {

    var cancellables = Set<AnyCancellable>()
    let viewModel = SettingsScreenViewModel()

    @Autolayout private var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Choose the app theme"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    @Autolayout private var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.spacing = 16
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        return vStack
    }()

    @Autolayout private var themeOneButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .trailing
        config.imagePadding = 10
        config.image = UIImage(systemName: "paintpalette.fill")
        config.cornerStyle = .medium
        config.title = "Theme 1"
        config.baseBackgroundColor = .systemBlue
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        })
        let button = UIButton(configuration: config)
        return button
    }()

    @Autolayout private var themeTwoButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .trailing
        config.imagePadding = 10
        config.image = UIImage(systemName: "paintpalette.fill")
        config.cornerStyle = .medium
        config.title = "Theme 2"
        config.baseBackgroundColor = .systemOrange
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        })
        let button = UIButton(configuration: config)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setAppTheme()
        addActions()
    }

    private func setupUI() {

        view.addSubview(label)
        view.addSubview(vStack)

        vStack.addArrangedSubview(themeOneButton)
        vStack.addArrangedSubview(themeTwoButton)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 60),
            label.widthAnchor.constraint(equalToConstant: 250),

            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.widthAnchor.constraint(equalToConstant: 300),
            vStack.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setAppTheme() {
        view.backgroundColor = .systemBackground
    }
}


// MARK: Actions
private extension SettingsScreen {

    private func addActions() {
        let themeOneButtonAction = UIAction { _ in self.themeOneButtonDidTap() }

        themeOneButton.addAction(themeOneButtonAction, for: .primaryActionTriggered)

        let themeTwoButtonAction = UIAction { _ in self.themeTwoButtonDidTap() }

        themeTwoButton.addAction(themeTwoButtonAction, for: .primaryActionTriggered)
    }

    private func themeOneButtonDidTap() {
        viewModel.themePublisher = ColorTheme1()
        dismiss(animated: true)
    }

    private func themeTwoButtonDidTap() {
        viewModel.themePublisher = ColorTheme2()
        dismiss(animated: true)
    }
}


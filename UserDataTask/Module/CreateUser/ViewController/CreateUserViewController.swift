//
//  CreateUserViewController.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import UIKit

final class CreateUserViewController: UIViewController {

    // MARK: - UI Components

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    private let nameField = CustomTextField()
    private let emailField = CustomTextField()
    private let genderSegment = GenderSegmentedControl()
    private let submitButton = CustomButton()

    // MARK: - Properties

    var viewModel: UserViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupUI()
        observeKeyboardChanges(scrollView: scrollView)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - View Setup

    private func configureView() {
        title = Constants.PageTitle.addUserData
        view.backgroundColor = AppTheme.backgroundColor
    }

    private func setupUI() {
        setupScrollView()
        setupStackView()
        setupTextFields()
        setupGenderSegment()
        setupSubmitButton()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func setupStackView() {
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.alignment = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20)
        ])
    }

    private func setupTextFields() {
        [nameField, emailField].forEach {
            $0.borderStyle = .roundedRect
            $0.backgroundColor = .white
            $0.layer.borderColor = AppTheme.borderColor.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.cornerRadius = 5
            $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }

        nameField.placeholder = Constants.TextFieldPlaceholder.namePlaceholder
        emailField.placeholder = Constants.TextFieldPlaceholder.emailPlaceholder
        emailField.autocapitalizationType = .none
        contentStackView.addArrangedSubview(nameField)
        contentStackView.addArrangedSubview(emailField)
    }

    private func setupGenderSegment() {
        genderSegment.selectedSegmentIndex = 0
        genderSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        contentStackView.addArrangedSubview(genderSegment)
    }

    private func setupSubmitButton() {
        submitButton.setTitle(Constants.ButtonTitle.submitButtonTitle, for: .normal)
        submitButton.backgroundColor = AppTheme.primaryColor
        submitButton.setTitleColor(AppTheme.buttonTextColor, for: .normal)
        submitButton.layer.cornerRadius = AppTheme.buttonCornerRadius
        submitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        contentStackView.addArrangedSubview(submitButton)
    }

    // MARK: - Actions

    @objc private func submitTapped() {
        guard let name = nameField.text, !name.isEmpty,
              let email = emailField.text, !email.isEmpty else {
            showAlert(message: Constants.AlertMessage.alertMessageEmptyFields)
            return
        }

        guard email.isValidEmail() else {
            showAlert(message: Constants.AlertMessage.alertMessageInvalidEmail)
            return
        }

        let gender = genderSegment.selectedSegmentIndex == 0 ? Constants.Gender.male : Constants.Gender.female
        submitButton.isEnabled = false
        
        let request = CreateUserRequest(name: name, email: email, gender: gender, status: "active")
        
        viewModel.createUser(request: request) { [weak self] result in
            DispatchQueue.main.async {
                self?.submitButton.isEnabled = true
                switch result {
                case .success:
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

}

//
//  UserListViewController.swift
//  UserDataTask
//
//  Created by Nanda Pradeesh on 23/07/25.
//

import UIKit
import Combine

final class UserListViewController: UIViewController {

    // MARK: - UI Elements
    private let tableView = UITableView()
    private let createUserButton = FloatingButton()
    private let loader = UIActivityIndicatorView(style: .large)

    // MARK: - Properties
    private let viewModel = UserViewModel()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.PageTitle.userDataList
        view.backgroundColor = AppTheme.backgroundColor

        setupTableView()
        setupFloatingButton()
        setupLoader()
        bindViewModel()
        viewModel.getUsers()
    }

    // MARK: - Setup UI

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppTheme.tableViewBGColor
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UserTableViewCell.identifier)

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupFloatingButton() {
        view.addSubview(createUserButton)

        NSLayoutConstraint.activate([
            createUserButton.widthAnchor.constraint(equalToConstant: 56),
            createUserButton.heightAnchor.constraint(equalToConstant: 56),
            createUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createUserButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        createUserButton.addTarget(self, action: #selector(goToCreateUser), for: .touchUpInside)
    }

    private func setupLoader() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Bind ViewModel

    private func bindViewModel() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.loader.startAnimating() : self?.loader.stopAnimating()
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { error in
                print("Error: \(error)")
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions

    @objc private func goToCreateUser() {
        let createVC = CreateUserViewController()
        createVC.viewModel = viewModel
        let backItem = UIBarButtonItem()
        backItem.title = Constants.ButtonTitle.back
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(createVC, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard viewModel.users.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }

        let user = viewModel.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
}

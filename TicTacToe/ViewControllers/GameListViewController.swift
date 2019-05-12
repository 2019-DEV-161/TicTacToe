//
//  GameListViewController.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

protocol GameListViewControllerDelegate: class {
    func didSelect(game: GameListViewModel.GameIdentifier, on gameListViewController: GameListViewController)
    func didTapBack(on gameListViewController: GameListViewController)
}

class GameListViewController: BaseViewController {

    weak var delegate: GameListViewControllerDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.registerCellClass(ofType: GameCell.self)
        return tableView
    }()

    private let viewModel: GameListViewModel

    // MARK: Initialisers

    init(viewModel: GameListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View config

    func goBack() {
        self.delegate?.didTapBack(on: self)
    }

    override func setupTitle() {
        self.title = viewModel.title
    }

    override func setupLoadView() {
        view.addSubview(tableView)
    }

    override func setupConstraints() {
        tableView.pin(.top)
        tableView.pinToSuperViewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
    }
}

extension GameListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cellType(at: indexPath) {
        case .game(let viewModel):
            let cell = tableView.dequeueReusableCell(ofType: GameCell.self, for: indexPath)
            cell.viewModel = viewModel
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let identifier = viewModel.gameIdentifier(at: indexPath)
        self.delegate?.didSelect(game: identifier, on: self)
    }
}

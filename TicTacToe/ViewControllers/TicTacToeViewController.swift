//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

protocol TicTacToeViewControllerDelegate: class {
    func didSelectItem(at index: Int, on ticTacToeViewController: TicTacToeViewController)
    func didFinishGame(on ticTacToeViewController: TicTacToeViewController)
}

class TicTacToeViewController: BaseViewController {

    private struct Layout {
        static let headerHeight: CGFloat = 100
    }

    weak var delegate: TicTacToeViewControllerDelegate?
    private let viewModel: TicTacToeViewModel

    // MARK: Initialisers

    init(viewModel: TicTacToeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var playerLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.text = self.viewModel.currentPlayer
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.registerCellClass(ofType: BoardCell.self)
        return collectionView
    }()

    override func setupTitle() {
        self.title = viewModel.title
    }

    override func setupLoadView() {
        self.view.addSubview(stackView)
        self.view.addSubview(collectionView)

        self.stackView.addArrangedSubview(self.playerLabel)
    }

    override func setupConstraints() {
        stackView.pinToTopLayoutGuide(of: self)
        stackView.pinTo(edges: [.left, .right])
        stackView.setDimension(.height, toSize: Layout.headerHeight)
        collectionView.pin(.top, to: .bottom, of: stackView)
        collectionView.pinToSuperViewEdges(with: .zero, excludingEdge: .top)
    }

    func updateView(with state: TicTacToe.State) {
        self.collectionView.reloadData()
        self.playerLabel.text = self.viewModel.currentPlayer

        switch state {
        case .win(let player):
            self.present(title: "Congratulations \(player.name)", message: "You won") { [weak self] in
                guard let self = self else { return }
                self.delegate?.didFinishGame(on: self)
            }
        case .draw:
            self.present(title: "Sorry", message: "It's a draw") { [weak self] in
                guard let self = self else { return }
                self.delegate?.didFinishGame(on: self)
            }
        case .play:
            break
        }
    }
}

extension TicTacToeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.cellType(at: indexPath.row) {
        case .piece(let viewModel):
            let cell = collectionView.dequeueReusableCell(ofType: BoardCell.self, for: indexPath)
            cell.viewModel = viewModel
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareSize = self.view.bounds.size.width / self.viewModel.numberOfItemsPerLine
        return CGSize(width: squareSize, height: squareSize)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(at: indexPath.row, on: self)
    }
}

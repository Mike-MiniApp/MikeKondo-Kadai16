//
//  ViewController.swift
//  MikeKondo-Kadai16
//
//  Created by 近藤米功 on 2022/09/14.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var fruitTableView: UITableView!

    private var fruitTableViewCell = FruitTableViewCell()
    private var selectedFruitName = String()
    private var selectedIndex = Int()

    private var fruits = [Fruit(name: "りんご", isCheck: false),
                         Fruit(name: "みかん", isCheck: true),
                         Fruit(name: "バナナ", isCheck: false),
                         Fruit(name: "パイナップル", isCheck: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFruitTableView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigation = segue.destination as? UINavigationController else { return }
        guard let select = navigation.topViewController as? InputFruitViewController else { return }
        switch segue.identifier {
        case "InputFruit":
            select.modeType = ModeType.input
            select.delegate = self
        case "EditFruit":
            select.modeType = ModeType.edit
            select.selectedFruitName = selectedFruitName
            select.selectedIndex = selectedIndex
            select.delegate = self
        default:
            break
        }
    }

    private func setupFruitTableView() {
        fruitTableView.delegate = self
        fruitTableView.dataSource = self
        fruitTableView.register(UINib(nibName: FruitTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FruitTableViewCell.identifier)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fruits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FruitTableViewCell.identifier, for: indexPath) as? FruitTableViewCell else {
            fatalError("The dequeued cell is not instance")
        }
        cell.configure(fruit: fruits[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fruits[indexPath.row].isCheck.toggle()
        fruitTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.selectedFruitName = fruits[indexPath.row].name
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "EditFruit", sender: nil)
    }
}

// MARK: - InputFruitViewControllerDelegate
extension ViewController: InputFruitViewControllerDelegate {
    func didEditFruit(name: String, index: Int) {
        fruits[index].name = name
        fruitTableView.reloadData()
    }

    func didSaveFruit(name: String) {
        fruits.append(Fruit(name: name, isCheck: false))
        fruitTableView.reloadData()
    }
}

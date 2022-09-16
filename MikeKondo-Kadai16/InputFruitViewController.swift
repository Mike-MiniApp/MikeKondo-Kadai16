//
//  InputFruitViewController.swift
//  MikeKondo-Kadai16
//
//  Created by 近藤米功 on 2022/09/14.
//

import UIKit
protocol InputFruitViewControllerDelegate: AnyObject {
    func didSaveFruit(name: String)
    func didEditFruit(name: String, index: Int)
}

final class InputFruitViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var fruitTextField: UITextField!
    var selectedFruitName = String()
    var selectedIndex = Int()
    var modeType: ModeType?
    weak var delegate: InputFruitViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        fruitTextField.text = selectedFruitName
    }

    @IBAction private func didSaveFruitButton(_ sender: Any) {
        guard let fruitName = fruitTextField.text else { return }
        switch modeType {
        case .input:
            delegate?.didSaveFruit(name: fruitName)
        case .edit:
            delegate?.didEditFruit(name: fruitName, index: selectedIndex)
        default:
            break
        }
        dismiss(animated: true)
    }

    @IBAction private func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

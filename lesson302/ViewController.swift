//
//  ViewController.swift
//  lesson302
//
//  Created by Garib Agaev on 30.08.2023.
//

import UIKit

struct MyStruct: Decodable {
    let date: String
    let localName: String
    let name: String
    let countryCode: String
    let fixed: Bool
    let global: Bool
    let counties: [String]?
    let launchYear: Int?
    let type: String
}

class ViewController: UIViewController {
    
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func actionButton() {
        guard let url = URL(string: "https://date.nager.at/api/v2/publicholidays/2020/US") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let _ = response else {
                print(error?.localizedDescription ?? "data = nil or response = nil")
                return
            }
            DispatchQueue.main.async {
                do {
                    let myStruct = try JSONDecoder().decode([MyStruct].self, from: data)
                    print(myStruct)
                    self.showAlet("😊")
                } catch let error {
                    print(error.localizedDescription)
                    print(error)
                    self.showAlet("🥲")
                }
            }
        }.resume()
    }
}
//MARK: - Setting View
private extension ViewController {
    func setupView() {
        view.backgroundColor = .systemMint
        setupButton()
        setupConstraintButton()
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
}

//MARK: - Setting
private extension ViewController {
    func setupButton() {
        button.backgroundColor = .systemCyan
        button.setTitle("Hello, URL😭", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
    }
    
    func showAlet(_ string: String) {
        let alert = UIAlertController(title: "Hello!", message: string, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

//MARK: - Layout
private extension ViewController {
    func setupConstraintButton() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: button, attribute: .centerX,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .centerX,
                multiplier: 1, constant: 0
            ),
            NSLayoutConstraint(
                item: button, attribute: .centerY,
                relatedBy: .equal,
                toItem: view.safeAreaLayoutGuide, attribute: .centerY,
                multiplier: 1, constant: 0
            ),
            NSLayoutConstraint(
                item: button, attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: button.titleLabel, attribute: .width,
                multiplier: 2, constant: 0
            ),
        ])
    }
}

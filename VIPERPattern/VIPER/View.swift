//
//  View.swift
//  VIPERPattern
//
//  Created by 신승아 on 7/6/24.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: Content)
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayout()
    }
    
    func addLayout() {
        view.addSubview(label)
        view.backgroundColor = .green
        
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}

extension UserViewController {
    
    func update(with contents: Content) {
        DispatchQueue.main.async {
            self.content = contents.text
            self.label.text = self.title
            self.label.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.content = ""
            self.label.text = error
            self.label.isHidden = false
        }
    }
}

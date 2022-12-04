//
//  ViewController.swift
//  Practice1202
//
//  Created by Ellen J on 2022/12/02.
//

import UIKit

import RxSwift
import RxCocoa

extension MainViewController {
    static func instance() -> MainViewController {
        return MainViewController(nibName: nil, bundle: nil)
    }
}

class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    lazy var changeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("CHANGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .black
        return button
    }()

    private let mainViewModel = MainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setConstraints()
        view.backgroundColor = .white
    }

    private func bind() {
        mainViewModel.colorObservable
            .subscribe { [weak self] in self?.view.backgroundColor = $0 }
            .disposed(by: disposeBag)
        
        changeButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.mainViewModel.input.tapChangeButton()})
            .disposed(by: disposeBag)
    }
    
    private func setConstraints() {
        view.addSubview(changeButton)
        
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.widthAnchor.constraint(equalToConstant: 100),
            changeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}


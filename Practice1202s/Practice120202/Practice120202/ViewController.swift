//
//  ViewController.swift
//  Practice120202
//
//  Created by Ellen J on 2022/12/02.
//

import UIKit

import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    private var mainViewModel: MainViewmodelable?
    private let disposeBag = DisposeBag()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("CHANGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .black
           return button
    }()
    
    static func instance(viewModel: MainViewmodelable) -> MainViewController {
        let viewController = MainViewController(nibName: nil, bundle: nil)
        viewController.mainViewModel = viewModel
        return viewController
    }
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        setupConstraints()
        
        mainViewModel?.input.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainViewModel?.input.viewWillAppear()
    }
    
    private func bind() {
        changeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.mainViewModel?.input.tapChangeButton()
            })
            .disposed(by: disposeBag)
        
        mainViewModel?.output.colorObservable
            .subscribe { [weak self] color in
                self?.view.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
//        mainViewModel?.output.textObservable
//            .subscribe { [weak self] text in
//                self?.changeButton.setTitle(text, for: .normal)
//            }
//            .disposed(by: disposeBag)
//        
//        mainViewModel?.output.completeTextObservable
//            .subscribe { [weak self] text in
//                self?.changeButton.setTitle(text, for: .normal)
//            }
//            .disposed(by: disposeBag)
        
        mainViewModel?.output.combineTextObservable
            .subscribe { [weak self] text in
                self?.changeButton.setTitle(text, for: .normal)
            }.disposed(by: disposeBag)
    }

    private func setupConstraints() {
        view.addSubview(changeButton)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            changeButton.widthAnchor.constraint(equalToConstant: 100),
            changeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}


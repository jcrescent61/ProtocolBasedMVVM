//
//  MainViewModel.swift
//  Practice120202
//
//  Created by Ellen J on 2022/12/02.
//

import UIKit
import RxSwift
import RxRelay

protocol MainViewModelInputInterface {
    func viewDidLoad()
    func viewWillAppear()
    func tapChangeButton()
}

protocol MainViewModelOutputInterface {
    var colorObservable: Observable<UIColor> { get }
    var textObservable: Observable<String> { get }
    var completeTextObservable: Observable<String> { get }
    var combineTextObservable: Observable<String> { get }
}

protocol MainViewmodelable {
    var input: MainViewModelInputInterface { get }
    var output: MainViewModelOutputInterface { get }
}

final class MainViewModel: MainViewmodelable {
    var input: MainViewModelInputInterface { self }
    var output: MainViewModelOutputInterface { self }
    
    private let bag = DisposeBag()
    private let viewDidLoadRelay = PublishRelay<String>()
    private let viewWillAppearRelay = PublishRelay<String>()
    private let colorRelay = PublishRelay<UIColor>()
    private let textRelay = PublishRelay<String>()
}

extension MainViewModel: MainViewModelInputInterface {
    func viewDidLoad() {
        viewDidLoadRelay.accept("혜지")
        textRelay.accept("혜지 쵸 천재")
    }
    
    func viewWillAppear() {
        viewWillAppearRelay.accept("천재")
    }
    
    func tapChangeButton() {
        colorRelay.accept(.red)
    }

    func combineTexts(_ text: String) -> Observable<String> {
        return viewWillAppearRelay
            .flatMap { atext -> Observable<String> in
                return .just(text + atext)
            }
         
    }
}

extension MainViewModel: MainViewModelOutputInterface {
    var textObservable: Observable<String> {
        return self.textRelay.asObservable()
    }
    var colorObservable: Observable<UIColor> {
        return self.colorRelay.asObservable()
    }
    
    var completeTextObservable: Observable<String> {
        return Observable.zip(
            viewDidLoadRelay.asObservable(),
            viewWillAppearRelay.asObservable()
        )
            .map { vslur, vslue2 in
                return "완료했어요"
            }
    }
    
    var combineTextObservable: Observable<String> {
        return viewDidLoadRelay
            .flatMap { [weak self] text -> Observable<String> in
                guard let self = self else { return .empty() }
                return self.combineTexts(text).asObservable()
            }.asObservable()
    }
}


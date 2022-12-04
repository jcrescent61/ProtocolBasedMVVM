//
//  MainViewModel.swift
//  Practice1202
//
//  Created by Ellen J on 2022/12/02.
//

import UIKit
import RxSwift
import RxRelay

protocol MainViewModelInputInterface {
    func tapChangeButton()
}

protocol MainViewModelOutputInterface {
    var colorObservable: Observable<UIColor> { get }
}

protocol MainViewModelable {
    var input: MainViewModelInputInterface { get }
    var output: MainViewModelOutputInterface { get }
}

final class MainViewModel: MainViewModelable {
    var input: MainViewModelInputInterface { self }
    var output: MainViewModelOutputInterface { self }
    
    private let bag = DisposeBag()
    private let colorSubject = PublishRelay<UIColor>()
}

extension MainViewModel: MainViewModelInputInterface {
    func tapChangeButton() {
        colorSubject.accept(.red)
    }
}

extension MainViewModel: MainViewModelOutputInterface {
    var colorObservable: Observable<UIColor> {
        return self.colorSubject
            .debounce(.seconds(5), scheduler: MainScheduler.instance)
            .asObservable()
    }
}

//
//  Practice1202Tests.swift
//  Practice1202Tests
//
//  Created by Ellen J on 2022/12/02.
//

import XCTest

import UIKit
import RxSwift
import RxBlocking
import RxRelay

@testable import Practice1202
final class Practice1202Tests: XCTestCase {

    private let mainViewModel = MainViewModel()
    private let disposeBag = DisposeBag()

    func test_tapChangeButton이_실행됐을때_UIColor가_잘_방출되는지_테스트() {
        // given
        var result = UIColor.clear
        let expect = UIColor.red
        let expectation = expectation(description: "Test after 5 seconds")
        
        // when
        mainViewModel.colorObservable
            .subscribe { color in
                result = color
                
                expectation.fulfill()
        }.disposed(by: disposeBag)
        
        mainViewModel.input.tapChangeButton()
        
        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertEqual(result, expect)
        
    }
}

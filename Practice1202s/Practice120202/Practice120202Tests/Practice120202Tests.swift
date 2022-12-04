//
//  Practice120202Tests.swift
//  Practice120202Tests
//
//  Created by Ellen J on 2022/12/02.
//

import XCTest

import UIKit
import RxSwift
import RxBlocking
import RxRelay

@testable import Practice120202

final class Practice120202Tests: XCTestCase {
    private let mainViewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    func test_ChangeButton이_실행됐을때_UIColor가_방출된다() {
        // given
        var result = UIColor.clear
        let expect = UIColor.red
        let expectation = expectation(description: "Test after 3 seconds")
        // when
        mainViewModel.colorObservable
            .subscribe { color in
                result = color
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        mainViewModel.input.tapChangeButton()
        
        wait(for: [expectation], timeout: 3.0)
        
        // then
        XCTAssertEqual(result, expect)
    }
    
    func test_viewDidLoad가_실행됐을때_Text가_방출된다() {
        // given
        var result = ""
        let expect = "혜지 쵸 천재"
        let expectation = expectation(description: "Test after 3 seconds")
        // when
        mainViewModel.output.textObservable
            .subscribe { text in
                result = text
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        mainViewModel.input.viewDidLoad()
        
        wait(for: [expectation], timeout: 3.0)
        
        // then
        XCTAssertEqual(result, expect)
    }
}

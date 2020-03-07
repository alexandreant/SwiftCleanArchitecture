//
//  RepositoriesTableViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import Domain
import RxSwift
import RxTest
import RxBlocking
@testable import Presentation

class MockGitRepoRepository: GitRepoRepository {

    private let result: Observable<[Repository]>
    init(result: Observable<[Repository]>){
        self.result = result
    }

    func list(term: String) -> Observable<[Repository]> {
        return result
    }


}

class RepositoriesTableViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListRepository() {
        let scheduler = TestScheduler(initialClock: 0)
        let testRepositories = scheduler.createObserver([Repository].self)
        let disposeBag = DisposeBag()

        let repositoryData = Repository()
        let mockRepository = MockGitRepoRepository(result: Observable.just([repositoryData, repositoryData]))
        let viewModel = RepositoriesTableViewModel(gitRepository: mockRepository)

        viewModel.repositories.asDriver(onErrorJustReturn: []).drive(testRepositories).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, "Javascript")])
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testRepositories.events, [.next(1, [repositoryData, repositoryData])])
    }

    func testSelectRepository() {
        let scheduler = TestScheduler(initialClock: 0)
        let testRoute = scheduler.createObserver(GitRepositoriesListRoute.self)
        let disposeBag = DisposeBag()

        var repository1Data = Repository()
        repository1Data.name = "repository1DataName"
        repository1Data.author = "repository1DataAuthor"
        var repository2Data = Repository()
        repository2Data.name = "repository2DataName"
        repository2Data.author = "repository2DataAuthor"

        let mockRepository = MockGitRepoRepository(result: Observable.just([repository1Data, repository2Data]))
        let viewModel = RepositoriesTableViewModel(gitRepository: mockRepository)

        viewModel.route.asDriver(onErrorJustReturn: .none).drive(testRoute).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, "Javascript")])
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(2, 1)])
            .bind(to: viewModel.select)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testRoute.events, [.next(2, .showPullRequests(owner: repository2Data.author, repository: repository2Data.name))])
    }
}
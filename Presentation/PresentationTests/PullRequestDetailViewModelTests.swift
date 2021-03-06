//
//  PullRequestDetailViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataSource
import Domain
@testable import Presentation
import XCTest

class PullRequestDetailViewModelTests: XCTestCase {
    func testLoadDetail() {
        let resultExpectation = XCTestExpectation(description: "Waiting result")
        let loadingExpectation = XCTestExpectation(description: "Waiting loading status")

        var data = GitPullRequest()
        data.author = "author"
        data.id = 10

        let dataSource = MockGitPullRequestDataSource(result: data)
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = FetchPullRequestDetailUseCase(repository: repository)
        let viewModel = PullRequestDetailsViewModel(useCase: useCase)
        useCase.delegateInterfaceAdapter = viewModel

        viewModel.isLoading.observe { isLoading in
            if isLoading {
                loadingExpectation.fulfill()
            }
        }

        viewModel.pullRequest.observe { pullRequest in
            if pullRequest != nil {
                resultExpectation.fulfill()
            }
        }

        viewModel.load(pullRequestid: 0, fromRepo: .init())

        wait(for: [resultExpectation, loadingExpectation], timeout: 2)
    }
}

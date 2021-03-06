//
//  GithubAPIRouter.swift
//  DataSource
//
//  Created by Victor C Tavernari on 06/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Alamofire

enum GithubAPIRouter: URLRequestConvertible {
    case search(term: String)
    case listPullRequest(owner: String, repoName: String)
    case getPullRequest(owner: String, repoName: String, pullNumber: Int)

    struct ProductionServer {
        static var baseURL = { () -> String in
            var url = "https://api.github.com"

            if ProcessInfo.processInfo.arguments.contains("ui-testing"),
                let port = Int(ProcessInfo.processInfo.environment["localhostPort"] ?? "80") {
                url = "http://localhost:\(port)"
            }

            return url
        }()
    }

    private var path: String {
        switch self {
        case let .search(term):
            return "/search/repositories?q=\(term)"
        case let .listPullRequest(owner, repoName):
            return "/repos/\(owner)/\(repoName)/pulls"
        case let .getPullRequest(owner, repoName, pullNumber):
            return "/repos/\(owner)/\(repoName)/pulls/\(pullNumber)"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try "\(GithubAPIRouter.ProductionServer.baseURL)\(path)".asURL()
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
}

//
//  GitRepoDataSource.swift
//  DataSource
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import RxSwift
import Domain

public protocol GitRepoDataSource {
    func list(term: String) -> Observable<[GitRepository]>
}

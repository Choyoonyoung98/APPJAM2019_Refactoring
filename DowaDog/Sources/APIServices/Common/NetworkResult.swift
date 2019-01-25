//
//  NetworkResult.swift
//  homework_4+5
//
//  Created by wookeon on 30/11/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}

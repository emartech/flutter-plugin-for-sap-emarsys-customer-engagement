//
//  EmptyCommand.swift
//  emarsys_sdk
//
//  Created by Mihaly Hunyady on 2021. 05. 21..
//

import Foundation
class EmptyCommand: EmarsysCommandProtocol {
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        resultCallback(["success":true])
    }
}

//
// Created by Emarsys
//


import Foundation

struct InvalidError: Error {
    enum ErrorKind {
        case invalidPushTokenError
    }
    
    let message: String
    let kind: ErrorKind
}
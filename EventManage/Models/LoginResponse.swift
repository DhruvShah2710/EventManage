//
//  LoginResponse.swift
//  EventManage
//

import Foundation

struct LoginResponse: Decodable {
    let code: Int
    let name: String
    let type: String
    let message: String
}

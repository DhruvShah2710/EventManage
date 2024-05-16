//
//  AttendResponse.swift
//  EventManage
//

import Foundation

struct AttendResponse: Decodable {
    let code: Int
    let name: String
    let event: String
    let email: String
    let message: String
}

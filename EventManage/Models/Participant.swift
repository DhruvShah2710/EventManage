//
//  Participant.swift
//  EventManage
//

import Foundation

struct Participant: Identifiable, Codable {
    var id: Int
    var name: String
    var phoneNumber: String
    var semester: String
    var email: String
    var college: String
    var eventName: String
}

//
//  API.swift
//  EventManage
//

import Foundation

struct API {
    static let BASE = "http://localhost:8888"
    static let LOGIN = "\(BASE)/api/login"
    static let REGISTER = "\(BASE)/api/register"
    static let EVENTREGISTER = "\(BASE)/api/event/register"
    static let PARTSLIST = "\(BASE)/api/participants/list"
    static let ATTEND = "\(BASE)/api/event/attend"
}

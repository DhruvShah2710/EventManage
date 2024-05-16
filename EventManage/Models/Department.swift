//
//  Department.swift
//  EventManage
//

import Foundation

enum Department: String, CaseIterable {
    case computer = "Computer"
    case civil = "Civil"
    case mechanical = "Mechanical"
    case electrical = "Electrical"
    case chemical = "Chemical"
    
    var events: [Event] {
        switch self {
        case .computer: return [.placementDrive, .pitchers]
        case .civil: return [.ePlacement, .absoluteH2O, .chakravyuh]
        case .mechanical: return [.junkYard, .latheWar]
        case .electrical: return [.buzzWire, .eQuiz, .aquaRobo]
        case .chemical: return [.chemOQuiz, .chemOLive]
        }
    }
}

enum Event {
    case placementDrive
    case pitchers
    case ePlacement
    case absoluteH2O
    case chakravyuh
    case chemOQuiz
    case chemOLive
    case junkYard
    case latheWar
    case buzzWire
    case eQuiz
    case aquaRobo
    
    var name: String {
        switch self {
        case .placementDrive: return "Placement Drive"
        case .pitchers: return "Pitchers"
        case .ePlacement: return "E-Placement"
        case .absoluteH2O: return "Absolute H2O"
        case .chakravyuh: return "Chakravyuh"
        case .chemOQuiz: return "Chem-O-Quiz"
        case .chemOLive: return "Chem-O-Live"
        case .junkYard: return "Junk Yard"
        case .latheWar: return "Lathe War"
        case .buzzWire: return "Buzz Wire"
        case .eQuiz: return "E-Quiz"
        case .aquaRobo: return "Aqua Robo"
        }
    }
    
    var code: String {
        switch self {
        case .placementDrive: return "COMP-PLAC"
        case .pitchers: return "COMP-PITCH"
        case .ePlacement: return "CIVIL-EPLA"
        case .absoluteH2O: return "CIVIL-AH2O"
        case .chakravyuh: return "CIVIL-CHKR"
        case .chemOQuiz: return "CHEM-OQUIZ"
        case .chemOLive: return "CHEM-OLIVE"
        case .junkYard: return "MECH-JUNKY"
        case .latheWar: return "MECH-LATH"
        case .buzzWire: return "ELEC-BUZZ"
        case .eQuiz: return "ELEC-QUIZ"
        case .aquaRobo: return "ELEC-AQUA"
        }
    }
}

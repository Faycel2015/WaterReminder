//
//  AvatarType.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

enum AvatarType: String, CaseIterable {
    case robot, superhero, ninja, astronaut, wizard, eliteWarrior, hydrationMaster
    
    var imageName: String {
        return self.rawValue
    }
    
    var isRare: Bool {
        return self == .eliteWarrior || self == .hydrationMaster
    }
    
    static func unlockableAvatars(for streak: Int) -> [AvatarType] {
        switch streak {
        case 0..<7:
            return [.robot, .superhero, .ninja]
        case 7..<30:
            return [.robot, .superhero, .ninja, .astronaut]
        case 30..<60:
            return [.robot, .superhero, .ninja, .astronaut, .wizard]
        case 60..<100:
            return [.robot, .superhero, .ninja, .astronaut, .wizard, .eliteWarrior]
        default:
            return AvatarType.allCases
        }
    }
}

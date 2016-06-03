//
//  FacialExpression.swift
//  FaceIt_l5
//
//  Created by 雪 禹 on 5/28/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import Foundation

// UI-independent representation of a facial expression


struct FacialExpression {
    enum Eyes: Int {
        case Open
        case Closed
        case Squinting
    }
    enum EyeBrows: Int {
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        
        func moreFurrowedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue + 1) ?? .Relaxed
        }
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        
        func happierMouth() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .Smile

        }
    }
    
    var eyes : Eyes
    var eyeBrows : EyeBrows
    var mouth : Mouth
    
}

//
//  EmotionsViewController.swift
//  FaceIt_l6
//
//  Created by 雪 禹 on 6/1/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpression >= [
        "angry" : FacialExpression(eyes:.Closed,eyeBrows: .Furrowed,mouth: .Frown),
        "happy" : FacialExpression(eyes:.Open,eyeBrows: .Normal,mouth: .Smile),
        "worried" : FacialExpression(eyes:.Open,eyeBrows: .Relaxed,mouth: .Smirk),
        "mischievious" : FacialExpression(eyes:.Open,eyeBrows: .Furrowed,mouth: .Grin),
    ]
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationvc =  segue.destinationViewController
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        
        if let facevc = destinationvc as? FaceViewController{
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier]{
                    facevc.expression = expression
                    if let sendingButton = sender as? UIButton {
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
            
        }
        
        
    }

}

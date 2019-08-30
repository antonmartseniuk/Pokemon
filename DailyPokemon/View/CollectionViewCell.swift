//
//  CollectionViewCell.swift
//  DailyPokemon
//
//  Created by Anton Martsenyuk on 8/5/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    private struct Constants {
        static let lineWidth: CGFloat = 5
        static let arcWidth: CGFloat = 35
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - Constants.arcWidth/2,
                                startAngle: .pi,
                                endAngle: .pi * 2,
                                clockwise: true)
        
        path.lineWidth = Constants.arcWidth
        UIColor.red.setStroke()
        path.stroke()
        
        let outlinePath1 = UIBezierPath(arcCenter: center,
                                        radius: radius/2 - Constants.lineWidth / 2,
                                        startAngle: .pi,
                                        endAngle: .pi * 2,
                                        clockwise: true)
        outlinePath1.addArc(withCenter: center,
                            radius: radius/2 - Constants.arcWidth + Constants.lineWidth / 2,
                            startAngle: .pi * 2,
                            endAngle: .pi ,
                            clockwise: false)
    

        outlinePath1.close()
        UIColor.black.setStroke()
        outlinePath1.lineWidth = Constants.lineWidth
        outlinePath1.stroke()
        
        
        
        let outlinePath2 = UIBezierPath(arcCenter: center, radius: radius/2 - Constants.lineWidth / 2,
                                        startAngle: 0, endAngle: .pi, clockwise: true)
        outlinePath2.addArc(withCenter: center, radius: radius/2 - Constants.arcWidth + Constants.lineWidth / 2,
                           startAngle: .pi, endAngle: 0 , clockwise: false)

        outlinePath2.close()
        UIColor.black.setStroke()
        outlinePath2.lineWidth = Constants.lineWidth
        outlinePath2.stroke()
        
    
    }
}

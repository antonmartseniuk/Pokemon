//
//  CustomCVLayout.swift
//  DailyPokemon
//
//  Created by Anton Martsenyuk on 8/5/19.
//  Copyright © 2019 Anton Martsenyuk. All rights reserved.
//

import UIKit

class CustomCVLayout: UICollectionViewLayout {
    
    var numberOfColumns: Int = 3
    let cellPadding: CGFloat = 8
    let cellHeight: CGFloat = 150

    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var contentHeight: CGFloat = 0
    var contentWidth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        let insets = collectionView.contentInset
        return collectionView.frame.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {return}
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        var xOffset = [CGFloat]()
        var yOffset = [CGFloat]()
        
        for column in 0..<numberOfColumns {
            xOffset.append(columnWidth * CGFloat(column))
            yOffset.append(column % 2 == 1 ? cellHeight : 0)
        }
        
        var column = 0

        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column],
                               width: columnWidth, height: columnWidth)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(collectionView.frame.height + 10, frame.maxY + cellHeight)
            yOffset[column] = yOffset[column] + 2 * cellHeight
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        
        
        
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}

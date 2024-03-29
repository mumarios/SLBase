//
//  UICollectionView+Extension.swift
//  Esaad
//
//  Created by Faraz Haider on 28/08/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

public extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle = Bundle(for: T.self)) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    public func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle = Bundle(for: T.self)) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    public func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                                      ofKind kind: String = UICollectionElementKindSectionHeader,
                                                      bundle: Bundle = Bundle(for: T.self)) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    public func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                                      ofKind kind: String = UICollectionElementKindSectionHeader,
                                                      bundle: Bundle = Bundle(for: T.self)) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    public func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                                 for indexPath: IndexPath,
                                                                 ofKind kind: String = UICollectionElementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

//
//  UICollectionViewCells.swift
//  Clouds
//
//  Created by Omar Allaham on 3/16/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

extension UICollectionView {

   enum ReusableKind: Int {
      case header
      case footer
   }

   func register<T: UICollectionViewCell>(_ cell: T.Type) {

      let nib = UINib.init(nibName: typeName(of: T.self), bundle: nil)

      register(nib, forCellWithReuseIdentifier: typeName(of: cell.self))
   }

   func register<T: UICollectionReusableView>(_ cell: T.Type, kind: ReusableKind = .header) {

      let nib = UINib.init(nibName: typeName(of: T.self), bundle: nil)

      let kind = kind == .header ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter

      register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: typeName(of: cell.self))
   }

   func cell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {

      let type = typeName(of: cell.self)

      let result = dequeueReusableCell(withReuseIdentifier: type, for: indexPath)

      assert(result is T, "The found cell does not match the requested type \(type)")

      return result as! T
   }

   func cell<T: UICollectionReusableView>(_ cell: T.Type, indexPath: IndexPath, kind: ReusableKind = .header) -> T {

      let type = typeName(of: cell.self)

      let kind = kind == .header ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter

      let result = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type, for: indexPath) as? T

      assert(result != nil, "The found reusable view does not match the requested kind \(type)")

      return result!
   }

   func deselectItem(at indexPath: IndexPath) {
      delay(0) {
         self.deselectItem(at: indexPath, animated: false)
         self.delegate?.collectionView?(self, didDeselectItemAt: indexPath)
      }
   }
}

func delay(_ seconds: Double, closure: @escaping () -> Void) {
   let delayTime = DispatchTime.now() + Double(Int64(Double(seconds) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
   DispatchQueue.main.asyncAfter(deadline: delayTime) {
      closure()
   }
}

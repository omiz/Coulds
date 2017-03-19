//
//  AirportCollectionViewCell.swift
//  Clouds
//
//  Created by Omar Allaham on 3/16/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

class AirportCollectionViewCell: UICollectionViewCell {

   @IBOutlet weak var label: UILabel!

   var circleLayer: CAShapeLayer!

   var padding: CGFloat = 5

   var edge: CGFloat {
      return min(bounds.width, bounds.height) - (padding * 2)
   }
   var radius: CGFloat {
      return edge / 2
   }

   var isAcitve: Bool {
      get { return circleLayer.borderWidth == 3 }
      set {
         let color: UIColor = newValue ? .primary : .background
         circleLayer.fillColor = color.withAlphaComponent(0.4).cgColor
         circleLayer.borderWidth = newValue ? 3 : 0
      }
   }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

      circleLayer = CAShapeLayer()
      circleLayer.fillColor = UIColor.accent.cgColor
      circleLayer.borderColor = UIColor.primary.cgColor
      circleLayer.borderWidth = 2
      circleLayer.masksToBounds = false

      circleLayer.shadowColor = UIColor.white.cgColor
      circleLayer.shadowOffset = CGSize(width: 1.5, height: 1.5)
      circleLayer.shadowOpacity = 0.2
      circleLayer.shouldRasterize = false
      clipsToBounds = false
      circleLayer.masksToBounds = false

      layer.insertSublayer(circleLayer, at: 0)

      label.textColor = .text
    }

   override var isHighlighted: Bool {
      didSet {
         let color = UIColor.accent
         circleLayer.fillColor = isHighlighted ? color.withAlphaComponent(0.4).cgColor : color.cgColor
      }
   }

   func setup(_ airport: Airport) {

      label.text = airport.title
   }

   override func layoutSubviews() {
      super.layoutSubviews()

      circleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: edge, height: edge), cornerRadius: radius).cgPath
      circleLayer.position = CGPoint(x: bounds.midX - radius, y: bounds.midY - radius)
   }

}

func typeName(_ some: Any) -> String {
   return (some is Any.Type) ? "\(some)" : "\(type(of: (some) as AnyObject))"
}

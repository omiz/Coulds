//
//  BottomView.swift
//  Clouds
//
//  Created by Omar Allaham on 3/19/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

class BottomView: UIView {

   @IBOutlet weak var playButton: UIButton!

   @IBOutlet weak var settingsButton: UIButton!

   var isPlaying: Bool = false {
      didSet {
         let image = UIImage.init(named: isPlaying ? "pause" : "play")?.with(color: .imageTint)
         playButton.setImage(image, for: .normal)
      }
   }

   func setup() {

      isPlaying = false

      settingsButton.setImage(UIImage(named: "settings")?.with(color: .imageTint), for: .normal)

      layer.shadowColor = UIColor.white.cgColor
      layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//      layer.shadowOpacity = 0.5
//      layer.shouldRasterize = false
      clipsToBounds = false
      layer.masksToBounds = false

      backgroundColor = UIColor.background.withAlphaComponent(0.7)
   }

   @IBAction func playToggle(_ sender: UIButton) {
      delay(0) {
         self.isPlaying ? Player.shared.pause() : Player.shared.play()
      }
   }

}

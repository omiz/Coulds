//
//  TitleCollectionReusableView.swift
//  Clouds
//
//  Created by Omar Allaham on 3/16/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {

   @IBOutlet weak var label: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

      label.textColor = .text
    }
    
}

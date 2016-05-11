//
//  ColorView.swift
//  NetworkAndLayout
//
//  Created by Jam on 16/5/10.
//  Copyright © 2016年 Jam. All rights reserved.
//

import UIKit

class ColorView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.purpleColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.cyanColor()
    }
}

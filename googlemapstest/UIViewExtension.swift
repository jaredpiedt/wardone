//
//  UIViewExtension.swift
//  googlemapstest
//
//  Created by Camron Godbout on 3/16/15.
//  Copyright (c) 2015 Camron Godbout. All rights reserved.
//

import Foundation

extension UIView
{
    class func viewFromNibName(name: String) -> UIView? {
        let views = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        return views.first as? UIView
    }
}
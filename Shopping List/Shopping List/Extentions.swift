//
//  Extentions.swift
//  Shopping List
//
//  Created by Julia Potapenko on 11/1/16.
//  Copyright © 2016 Julia Potapenko. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {

    private weak static var currentFirstResponder: UIResponder?
    
    class func getCurrentFirstResponder() -> UIResponder? {
        currentFirstResponder = nil
        UIApplication.sharedApplication().sendAction(#selector(UIResponder.findFirstResponder), to: nil, from: nil, forEvent: nil)
        return currentFirstResponder
    }
    
    func findFirstResponder() {
        UIResponder.currentFirstResponder = self
    }
}

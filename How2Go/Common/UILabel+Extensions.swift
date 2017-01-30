//
//  UILabel+Extensions.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/30/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import Foundation
@IBDesignable extension UILabel {

    @IBInspectable var localizationKey: String {
        set {
            self.text = NSLocalizedString(newValue, comment: "Loading value")
        }
        get {
            guard let text = self.localizationKeyString else { return "" }
            return text
        }
    }

}

private var localizationString: String = ""

extension UILabel {

    var localizationKeyString: String? {
        get {
            return objc_getAssociatedObject(self, &localizationString) as? String
        }
        set (newValue) {
            objc_setAssociatedObject(self, &localizationString, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

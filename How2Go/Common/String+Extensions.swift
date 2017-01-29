//
//  String+Extensions.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/29/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import Foundation
extension String {
    func formateDateString (_ dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        var date = dateFormatter.date(from: self)

        guard let dateUnWrapped = date else { return "" }
        
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: dateUnWrapped)
        
    }
}

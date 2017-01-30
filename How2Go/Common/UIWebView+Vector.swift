//
//  UIWebView+Vector.swift
//  How2Go
//
//  Created by Mohammed Elsammak on 1/28/17.
//  Copyright © 2017 How2Go. All rights reserved.
//
/// Display vector images in UIWebView objects.
import Foundation
import UIKit
extension UIWebView {
    
    func loadSVGImage(imageUrl: String) {
        let html = String.init(format: "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style type=\"text/css\">" +
            "img{" +
            "position: absolute;" +
            "top: 0;" +
            "bottom: 0;" +
            "left: 0;" +
            "right: 0;" +
            "margin: auto;" +
            "max-width: 100%;" +
            "max-height: 100%;" +
            "}" +
            "</style>" +
            "</head>" +
            "<img src='\(imageUrl)'/> </body></html>")
  
        self.loadHTMLString(html, baseURL: nil)

    }
}

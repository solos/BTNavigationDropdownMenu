//
//  BTConfiguration.swift
//
//  Copyright (c) 2017 PHAM BA THO (phambatho@gmail.com). All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

final class BTConfiguration {
    var menuTitleColor: UIColor?
    var cellHeight: CGFloat!
    var cellBackgroundColor: UIColor?
    var cellSeparatorColor: UIColor?
    var cellTextLabelColor: UIColor?
    var selectedCellTextLabelColor: UIColor?
    var cellTextLabelFont: UIFont!
    var navigationBarTitleFont: UIFont
    var cellTextLabelAlignment: NSTextAlignment!
    var cellSelectionColor: UIColor?
    var checkMarkImage: UIImage!
    var shouldKeepSelectedCellColor: Bool!
    var arrowTintColor: UIColor?
    var arrowImage: UIImage!
    var arrowPadding: CGFloat!
    var animationDuration: TimeInterval!
    var maskBackgroundColor: UIColor!
    var maskBackgroundOpacity: CGFloat!
    var shouldChangeTitleText: Bool!
    
    init() {
        // Path for image
        let bundle = Bundle(for: BTConfiguration.self)
        let url = bundle.url(forResource: "BTNavigationDropdownMenu", withExtension: "bundle")
        let imageBundle = url != nil ? Bundle(url: url!) : nil
        let checkMarkImagePath = imageBundle?.path(forResource: "checkmark_icon", ofType: "png")
        let arrowImagePath = imageBundle?.path(forResource: "arrow_down_icon", ofType: "png")

        // Set default values
        self.menuTitleColor = UIColor.darkGray
        self.cellHeight = 50
        self.cellBackgroundColor = UIColor.white
        self.arrowTintColor = UIColor.white
        self.cellSeparatorColor = UIColor.darkGray
        self.cellTextLabelColor = UIColor.darkGray
        self.selectedCellTextLabelColor = UIColor.darkGray
        self.cellTextLabelFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.navigationBarTitleFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.cellTextLabelAlignment = NSTextAlignment.left
        self.cellSelectionColor = UIColor.lightGray
        
        // Safely load images with fallbacks
        if let checkMarkImagePath = checkMarkImagePath {
            self.checkMarkImage = UIImage(contentsOfFile: checkMarkImagePath)
        } else {
            // Create a simple checkmark image as fallback
            self.checkMarkImage = createFallbackCheckmarkImage()
        }
        
        if let arrowImagePath = arrowImagePath {
            self.arrowImage = UIImage(contentsOfFile: arrowImagePath)
        } else {
            // Create a simple arrow image as fallback
            self.arrowImage = createFallbackArrowImage()
        }
        
        self.shouldKeepSelectedCellColor = false
        self.animationDuration = 0.5
        self.arrowPadding = 15
        self.maskBackgroundColor = UIColor.black
        self.maskBackgroundOpacity = 0.3
        self.shouldChangeTitleText = true
    }
    
    // MARK: - Fallback Image Creation
    
    private func createFallbackCheckmarkImage() -> UIImage {
        let size = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.darkGray.cgColor)
        context?.setLineWidth(2.0)
        
        // Draw checkmark
        context?.move(to: CGPoint(x: 4, y: 10))
        context?.addLine(to: CGPoint(x: 8, y: 14))
        context?.addLine(to: CGPoint(x: 16, y: 6))
        context?.strokePath()
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    private func createFallbackArrowImage() -> UIImage {
        let size = CGSize(width: 12, height: 12)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.darkGray.cgColor)
        context?.setLineWidth(2.0)
        
        // Draw arrow
        context?.move(to: CGPoint(x: 2, y: 4))
        context?.addLine(to: CGPoint(x: 6, y: 8))
        context?.addLine(to: CGPoint(x: 10, y: 4))
        context?.strokePath()
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

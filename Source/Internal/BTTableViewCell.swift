//
//  BTTableViewCell.swift
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

class BTTableViewCell: UITableViewCell {
    let checkmarkIconWidth: CGFloat = 50
    let horizontalMargin: CGFloat = 20
    
    var checkmarkIcon: UIImageView!
    var cellContentFrame: CGRect!
    var configuration: BTConfiguration!
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, configuration: BTConfiguration) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configuration = configuration
        
        // Setup cell - safely get window width
        let windowWidth: CGFloat
        if #available(iOS 13.0, *) {
            // For iOS 13+, use the first connected scene's window
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                windowWidth = window.frame.width
            } else {
                // Fallback to screen width if no window is available
                windowWidth = UIScreen.main.bounds.width
            }
        } else {
            // For iOS 12 and below, use keyWindow
            windowWidth = UIApplication.shared.keyWindow?.frame.width ?? UIScreen.main.bounds.width
        }
        
        cellContentFrame = CGRect(x: 0, y: 0, width: windowWidth, height: self.configuration.cellHeight)
        self.contentView.backgroundColor = self.configuration.cellBackgroundColor
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // Safely configure textLabel
        if let textLabel = self.textLabel {
            textLabel.textColor = self.configuration.cellTextLabelColor
            textLabel.font = self.configuration.cellTextLabelFont
            textLabel.textAlignment = self.configuration.cellTextLabelAlignment
            
            if textLabel.textAlignment == .center {
                textLabel.frame = CGRect(x: 0, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            } else if textLabel.textAlignment == .left {
                textLabel.frame = CGRect(x: horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            } else {
                textLabel.frame = CGRect(x: -horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            }
        }
        
        // Checkmark icon
        if let textLabel = self.textLabel {
            if textLabel.textAlignment == .center {
                self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
            } else if textLabel.textAlignment == .left {
                self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
            } else {
                self.checkmarkIcon = UIImageView(frame: CGRect(x: horizontalMargin, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
            }
        } else {
            // Fallback if textLabel is nil
            self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 30)/2, width: 30, height: 30))
        }
        
        self.checkmarkIcon.isHidden = true
        self.checkmarkIcon.image = self.configuration.checkMarkImage
        self.checkmarkIcon.contentMode = UIView.ContentMode.scaleAspectFill
        self.contentView.addSubview(self.checkmarkIcon)
        
        // Separator for cell
        let separator = BTTableCellContentView(frame: cellContentFrame)
        if let cellSeparatorColor = self.configuration.cellSeparatorColor {
            separator.separatorColor = cellSeparatorColor
        }
        self.contentView.addSubview(separator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.bounds = cellContentFrame
        self.contentView.frame = self.bounds
    }
}

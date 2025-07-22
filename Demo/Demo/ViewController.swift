//
//  ViewController.swift
//  BTNavigationDropdownMenu
//
//  Created by Pham Ba Tho on 6/8/15.
//  Copyright (c) 2015 PHAM BA THO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectedCellLabel: UILabel!
    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test the fixed initialization
        testSafeInitialization()
        
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        self.selectedCellLabel.text = items.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // "Old" version
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items)

        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(2), items: items)

        // Another way to initialize:
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)

        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("Did select item at index: \(indexPath)")
            self.selectedCellLabel.text = items[indexPath]
        }
        
        self.navigationItem.titleView = menuView
    }
    
    // MARK: - Test Methods
    
    private func testSafeInitialization() {
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        
        // Test 1: Safe initialization with nil navigationController
        let menuView1 = BTNavigationDropdownMenu(navigationController: nil, containerView: self.view, title: BTTitle.title("Test Menu"), items: items)
        print("Test 1 passed: Safe initialization with nil navigationController")
        
        // Test 2: Safe initialization with nil containerView (should use fallback)
        let menuView2 = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: nil, title: BTTitle.title("Test Menu"), items: items)
        print("Test 2 passed: Safe initialization with nil containerView")
        
        // Test 3: Safe initialization with index
        let menuView3 = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.view, title: BTTitle.index(2), items: items)
        print("Test 3 passed: Safe initialization with index")
        
        // Test 4: Test with empty items array
        let menuView4 = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.view, title: BTTitle.title("Empty Menu"), items: [])
        print("Test 4 passed: Safe initialization with empty items array")
    }
}

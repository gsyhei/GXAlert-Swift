//
//  ViewController.swift
//  GXAlertSample
//
//  Created by Gin on 2020/11/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "GXAlert"
    }
    
    @IBAction func button1Clicked(_ sender: UIButton) {
        var frame = self.view.bounds
        frame.size.width = 300.0
        frame.size.height = 200.0
        let menu = MenuView(frame: frame)
        menu.show(style: .alert)
    }
    
    @IBAction func button2Clicked(_ sender: UIButton) {
        var frame = self.view.bounds
        frame.size.height = 200.0
        let menu = MenuView(frame: frame)
        menu.show(style: .sheetTop)
    }
    
    @IBAction func button3Clicked(_ sender: UIButton) {
        var frame = self.view.bounds
        frame.size.width = 200.0
        let menu = MenuView(frame: frame)
        menu.show(style: .sheetLeft)
    }
    
    @IBAction func button4Clicked(_ sender: UIButton) {
        var frame = self.view.bounds
        frame.size.width = 200.0
        let menu = MenuView(frame: frame)
        menu.show(style: .sheetRight)
    }
    
    @IBAction func button5Clicked(_ sender: UIButton) {
        var frame = self.view.bounds
        frame.size.height = 200.0
        let menu = MenuView(frame: frame)
        menu.show(style: .sheetBottom)
    }
    


//    - (IBAction)button3Click:(id)sender {
//        MenuView *menu = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
//        [menu showAlertStyle:GXAlertStyleSheetTop backgoundTapDismissEnable:YES usingSpring:YES];
//    }
//
//    - (IBAction)button4Click:(id)sender {
//        MenuView *menu = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 200, SCREEN_WIDTH)];
//        [menu showAlertStyle:GXAlertStyleSheetLeft backgoundTapDismissEnable:YES usingSpring:YES];
//    }
//
//    - (IBAction)button5Click:(id)sender {
//        MenuView *menu = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 200, SCREEN_WIDTH)];
//        [menu showAlertStyle:GXAlertStyleSheetRight backgoundTapDismissEnable:YES usingSpring:YES];
//    }
    //    - (IBAction)button2Click:(id)sender {
    //        MenuView *menu = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    //        [menu showAlertStyle:GXAlertStyleSheet backgoundTapDismissEnable:YES usingSpring:YES];
    //    }

}


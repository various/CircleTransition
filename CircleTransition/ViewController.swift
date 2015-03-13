//
//  ViewController.swift
//  CircleTransition
//
//  Created by Tim Geng on 3/13/15.
//  Copyright (c) 2015 GF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button:UIButton!;
    
    @IBAction func circelTapped(sender:UIButton){
        self.navigationController?.popViewControllerAnimated(true);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  eHealthCareApp
//
//  Created by Lawrence Martin on 2016-12-10.
//  Copyright © 2016 Lawrence Martin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.email_txt.delegate = self;
        self.password_txt.delegate = self;
        
        bottomBorderOnly(email_txt)
        bottomBorderOnly(password_txt)
        
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        email_txt.resignFirstResponder()
        password_txt.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func bottomBorderOnly(field:UITextField){
        
        let txt_field:UITextField = field
    
        var bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, txt_field.frame.height - 1, txt_field.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.whiteColor().CGColor
        txt_field.borderStyle = UITextBorderStyle.None
        txt_field.layer.addSublayer(bottomLine)
    
    }

    @IBAction func signIn_btn(sender: AnyObject) {
        
        
        let emailTextField = self.email_txt.text
        let passwordTextField = self.password_txt.text
        
        //Sign myself in for dev/testing purposes only
        FIRAuth.auth()?.signInWithEmail(emailTextField!, password:passwordTextField!, completion: {(user:FIRUser?, error:NSError?) in
            if error == nil{
                print(user?.email)
                self.performSegueWithIdentifier("patientListViewSegue", sender: self)
            }else{
                print(error?.description)
            }
        })
        
        
    }

}


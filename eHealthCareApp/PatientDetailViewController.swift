//
//  PatientDetailViewController.swift
//  eHealthCareApp
//
//  Created by Lawrence Martin on 2016-12-11.
//  Copyright © 2016 Lawrence Martin. All rights reserved.
//

import UIKit

class PatientDetailViewController: UIViewController {
    
    var currentPatient:Patient!
    var currentIndex: Int!
    var num:Int = 0

    @IBOutlet weak var patientName_lbl: UILabel!
    
    @IBOutlet weak var patientStatus_lbl: UILabel!
    @IBAction func addTestActionSheet(sender: AnyObject) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Change Status", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if(self.patientStatus_lbl.text == "STABLE"){
                self.patientStatus_lbl.text = "CRITICAL"
                self.patientStatus_lbl.textColor = UIColor.redColor()
            }else if(self.patientStatus_lbl.text == "CRITICAL"){
                self.patientStatus_lbl.text = "STABLE"
                self.patientStatus_lbl.textColor = UIColor.blackColor()
            }
            
        })
        let saveAction = UIAlertAction(title: "View Tests", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("addBTestSegue", sender: self)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        patientName_lbl.text = currentPatient.firstName! + " " + currentPatient.lastName!
        
        if (currentPatient.patientCritical == true){
            patientStatus_lbl.text = "CRITICAL"
            patientStatus_lbl.textColor = UIColor.redColor()
        }else{
            patientStatus_lbl.text = "STABLE"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

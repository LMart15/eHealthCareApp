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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientName_lbl.text = currentPatient.firstName! + " " + currentPatient.lastName!
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

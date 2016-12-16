//
//  AddPatientViewController.swift
//  eHealthCareApp
//
//  Created by Lawrence Martin on 2016-12-15.
//  Copyright © 2016 Lawrence Martin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddPatientViewController: UIViewController, UITextFieldDelegate {
    
    var dbRef:FIRDatabaseReference!
    
    @IBOutlet weak var firstName_input: UITextField!
    
    @IBOutlet weak var lastName_input: UITextField!
    
    @IBOutlet weak var patientID_input: UITextField!
    
    @IBOutlet weak var patientAge_input: UITextField!
    
    @IBOutlet weak var patientGender_input: UITextField!
    
    @IBOutlet weak var dob_input: UITextField!
    
    @IBOutlet weak var address_input: UITextField!
    
    @IBOutlet weak var city_input: UITextField!
    
    @IBOutlet weak var province_input: UITextField!
    
    @IBOutlet weak var pcode_input: UITextField!
    
    @IBOutlet weak var roomNo_input: UITextField!
    @IBOutlet weak var addNewPatient_btn: UIButton!
    
    
    let patient1 = Patient(patientId: "37262824", firstName: "John", lastName: "Doe", dob: "07/07/1978", gender: "M", age: "37", address: "123 Broadway lane", city: "Toronto", province: "ON", postalCode: "N9C2R2", roomNo: "243", patientCritical: true)
    let patient2 = Patient(patientId: "38271936", firstName: "Gordon", lastName: "Smith", dob: "07/07/1983", gender: "M", age: "49", address: "3892 Yonge st", city: "Toronto", province: "ON", postalCode: "M4A9D3", roomNo: "237", patientCritical: false)
    let patient3 = Patient(patientId: "93473924", firstName: "Jane", lastName: "Ricks", dob: "07/07/2000", gender: "F", age: "31", address: "18 Richlie Ave", city: "Toronto", province: "ON", postalCode: "M5F2R4", roomNo: "222", patientCritical: false)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Patients"
        
        dbRef = FIRDatabase.database().reference().child("patient-data")
 
        self.patientID_input.delegate = self;
        self.firstName_input.delegate = self;
        self.lastName_input.delegate = self;
        self.dob_input.delegate = self;
        self.patientGender_input.delegate = self;
        self.patientAge_input.delegate = self;
        self.address_input.delegate = self;
        self.city_input.delegate = self;
        self.province_input.delegate = self;
        self.pcode_input.delegate = self;
        self.roomNo_input.delegate = self;
        
    }

    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        patientID_input.resignFirstResponder()
        firstName_input.resignFirstResponder()
        lastName_input.resignFirstResponder()
        dob_input.resignFirstResponder()
        patientGender_input.resignFirstResponder()
        patientAge_input.resignFirstResponder()
        address_input.resignFirstResponder()
        city_input.resignFirstResponder()
        province_input.resignFirstResponder()
        pcode_input.resignFirstResponder()
        roomNo_input.resignFirstResponder()
        return true;
    }
    

    @IBAction func addNewPatientNow_btn(sender: AnyObject) {
        
        let patientId = patientID_input.text
        let firstName = firstName_input.text
        let lastName = lastName_input.text
        let dob = dob_input.text
        let gender = patientGender_input.text
        let age = patientAge_input.text
        let address = address_input.text
        let city = city_input.text
        let province = province_input.text
        let postalCode = pcode_input.text
        let roomNo = roomNo_input.text
        let patientCritical = false
        
        let patient = Patient(patientId: patientId!, firstName: firstName!, lastName: lastName!, dob: dob!, gender: gender!, age: age!, address: address!, city: city!, province: province!, postalCode: postalCode!, roomNo: roomNo!, patientCritical: patientCritical)
        
  
        //        //create dbref with patientID as key
        let patientRef = self.dbRef.child(patient.patientId!)
        //
        //        //set patient data in firebase
        patientRef.setValue(patient.toDictionary())
        
        //navigate back to patient list
        navigationController?.popViewControllerAnimated(true)
        
    }
    

}

//
//  PatientListViewController.swift
//  eHealthCareApp
//
//  Created by Lawrence Martin on 2016-12-11.
//  Copyright © 2016 Lawrence Martin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PatientListViewController: UIViewController {
    
    @IBOutlet weak var patientStatus_sgmt: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var criticalStatusView:Bool = true
    
    @IBAction func patientStatusViewChange(sender: AnyObject) {
        
        switch patientStatus_sgmt.selectedSegmentIndex
        {
        case 0:
            criticalStatusView = true
            self.tableView.reloadData()
        case 1:
            criticalStatusView = false
            self.tableView.reloadData()
        default:
            break; 
        }
        
        
    }
    var dbRef:FIRDatabaseReference!
    var authUser: String = ""
    var authUserUid:String = ""
    
    var allPatients = [Patient]()
    var criticalPatients = [Patient]()
    let currentDateTime = NSDate()
    
    let patient1 = Patient(patientId: "37262824", firstName: "John", lastName: "Doe", dob: "07/07/1978", gender: "M", age: "37", address: "123 Broadway lane", city: "Toronto", province: "ON", postalCode: "N9C2R2", roomNo: "243", patientCritical: true)
    let patient2 = Patient(patientId: "38271936", firstName: "Gordon", lastName: "Smith", dob: "07/07/1983", gender: "M", age: "49", address: "3892 Yonge st", city: "Toronto", province: "ON", postalCode: "M4A9D3", roomNo: "237", patientCritical: false)
    let patient3 = Patient(patientId: "93473924", firstName: "Jane", lastName: "Ricks", dob: "07/07/2000", gender: "F", age: "31", address: "18 Richlie Ave", city: "Toronto", province: "ON", postalCode: "M5F2R4", roomNo: "222", patientCritical: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("patient-data")
        
        initFireAuth()
        
//        Added some patients manually
//        //create dbref with patientID as key
//        let patientRef = self.dbRef.child(patient3.patientId!)
//        
//        //set patient data in firebase
//        patientRef.setValue(patient3.toDictionary())
        
    }
    
    //get auth user
    func initFireAuth(){
        
        FIRAuth.auth()?.addAuthStateDidChangeListener({ (auth:FIRAuth, user:FIRUser?) in
            if let user = user{
                self.authUser = user.email!
                self.authUserUid = user.uid
                print("uid:" + self.authUserUid)
                self.startObservingDB()
            }else{
                print("Unauthorized")
            }
        })
    }
    
    
    //observe DB function to see changes in location value
    func startObservingDB() {
        dbRef.observeEventType(.Value, withBlock: { (snapshot:FIRDataSnapshot) in
            var aPatients = [Patient]()
            var cPatients = [Patient]()
            
            for patient in snapshot.children{
                let patientObject = Patient(snapshot: patient as! FIRDataSnapshot)
                    aPatients.append(patientObject)
                if (patientObject.patientCritical == true){
                    cPatients.append(patientObject)
                }
            }
            
            //set data
            self.allPatients = aPatients
            self.criticalPatients = cPatients
            self.tableView.reloadData()
            
        }) {(error:NSError) in
            print(error.description)
        }
        
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var patientCounter:Int?
        
        if(criticalStatusView){
            patientCounter = self.criticalPatients.count
        }else{
            patientCounter = self.allPatients.count
        }
        
        return patientCounter!
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("PatientViewCell") as? PatientViewCell {
            
            var patient:Patient?
            
            if(criticalStatusView){
                patient = self.criticalPatients[indexPath.row]
            }else{
                patient = self.allPatients[indexPath.row]
            }
            
            cell.configureCell(patient!.patientId!,
                               patientName: patient!.firstName! + " " + patient!.lastName!,
                               patientAge: patient!.age!,
                               roomNo: patient!.roomNo!)
            
            return cell
            
        } else {
            return PatientViewCell()
        }
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var patient:Patient?
        
        if segue.identifier == "patientDetailSegue" {
            let patientDetail =  segue.destinationViewController as! PatientDetailViewController
            
            // Pass the selected object to the new view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                if(criticalStatusView){
                    patient = self.criticalPatients[indexPath.row]
                }else{
                    patient = self.allPatients[indexPath.row]
                }
                
                let selectedPatient = patient
                patientDetail.currentPatient = selectedPatient
                patientDetail.currentIndex = indexPath.row
                
            }
        }
    }

}


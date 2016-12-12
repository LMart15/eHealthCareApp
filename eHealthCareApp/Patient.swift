//
//  Patient.swift
//  eHealthCareApp
//
//  Created by Lawrence Martin on 2016-12-10.
//  Copyright © 2016 Lawrence Martin. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Patient: NSObject {
    
    let key:String!
    var patientId:String?
    var firstName:String?
    var lastName:String?
    var dob:String?
    var gender:String?
    var age:String?
    var address:String?
    var city:String?
    var province:String?
    var postalCode:String?
    var roomNo:String?
    let itemRef:FIRDatabaseReference?
    
    var patientCritical:Bool?
    
    
    init(
         patientId: String,
         firstName: String,
         lastName:String,
         dob:String,
         gender:String,
         age:String,
         address:String,
         city:String,
         province:String,
         postalCode:String,
         roomNo:String,
         patientCritical:Bool,
         key:String = ""
         )
    {
        self.key = key
        self.itemRef = nil
        self.patientId = patientId
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.gender = gender
        self.age = age
        self.address = address
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.roomNo = roomNo
        self.patientCritical = patientCritical
    }
    
    init(snapshot:FIRDataSnapshot) {
        
        key = snapshot.key
        itemRef = snapshot.ref

        patientId = snapshot.value!["patientId"] as? String
        firstName = snapshot.value!["firstName"] as? String
        lastName = snapshot.value!["lastName"] as? String
        dob = snapshot.value!["dob"] as? String
        gender = snapshot.value!["gender"] as? String
        age = snapshot.value!["age"] as? String
        address = snapshot.value!["address"] as? String
        city = snapshot.value!["city"] as? String
        province = snapshot.value!["province"] as? String
        postalCode = snapshot.value!["postalCode"] as? String
        roomNo = snapshot.value!["roomNo"] as? String
        
        var pCritical:String = (snapshot.value!["patientCritical"] as? String)!
        
        if (pCritical == "true"){
            patientCritical = true
        }else{
            patientCritical = false
        }
        
    }

    func toDictionary() -> [String:String] {
        
        
        
        return ["patientId":patientId!, "firstName":firstName!, "lastName": lastName!, "dob": dob!, "gender": gender!, "age": age!, "address": address!, "city": city!, "province":province!, "postalCode": postalCode!, "roomNo": roomNo!, "patientCritical":BoolToString(patientCritical)]
    }
    
    func BoolToString(b: Bool?)->String { return b?.description ?? "<None>"}
    

}

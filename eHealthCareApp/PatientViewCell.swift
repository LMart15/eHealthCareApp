//
//  PatientViewCell.swift
//  eHealthCareApp
//
//  Created by Lawrence Martin on 2016-12-11.
//  Copyright © 2016 Lawrence Martin. All rights reserved.
//

import UIKit

class PatientViewCell: UITableViewCell {
    
    @IBOutlet weak var patientId_lbl: UILabel!
    
    @IBOutlet weak var patientName_lbl: UILabel!

    @IBOutlet weak var patientAge_lbl: UILabel!
    
    @IBOutlet weak var roomNo_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(patientId: String, patientName:String, patientAge:String, roomNo: String) {
        
        patientId_lbl.text = patientId
        patientName_lbl.text = patientName
        patientAge_lbl.text = patientAge
        roomNo_lbl.text = roomNo
    
    }
  

}

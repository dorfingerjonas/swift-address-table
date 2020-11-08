//
//  ViewController.swift
//  address_table
//
//  Created by Administrator on 06.11.20.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func save(_ sender: Any) {
        
        let regEx = try! NSRegularExpression(pattern: "^(AT-*[0-9])", options: [])
        
        if firstName.text != nil
            && lastName.text != nil
            && streetName.text != nil
            && place.text != nil
            && zipCode.text != nil
        {
            let zipCodeValid = regEx.firstMatch(in: zipCode.text!, options: [], range: NSMakeRange(0, zipCode.text!.utf16.count)) != nil
            
            if zipCodeValid {
                model.persons.append(Person(firstname: firstName.text!, lastname: lastName.text!, street: streetName.text!, place: place.text!, zip: zipCode.text!))
                performSegue(withIdentifier: "list", sender: self)
            } else {
                print("invalid format for zip code (AT-nnnn)")
            }
        } else {
            print("some fields are empty")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "list" {
            let tableViewController = segue.destination as! TableViewController
            
            tableViewController.model = self.model
        }
    }
}

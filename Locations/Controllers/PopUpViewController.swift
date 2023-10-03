//
//  PopUpViewController.swift
//  Locations
//
//  Created by Haytham on 02/10/2023.
//

import UIKit
import RealmSwift

class PopUpViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descTextView.layer.cornerRadius = 5
    }
    @IBAction func save(_ sender: UIButton) {
        print("Saved")
        dismiss(animated: true)
        
        let newLandmark = Landmark()
        newLandmark.name = nameTextField.text ?? ""
        newLandmark.desc = descTextView.text ?? ""
        newLandmark.latidute = Places.shared.userLatitude ?? 0.0
        newLandmark.longitude = Places.shared.userLongitude ?? 0.0
        
        do {
            try realm.write {
                realm.add(newLandmark)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

//
//  DetailController.swift
//  PhoneBool
//
//  Created by Andrii Pyvovarov on 14.09.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import CoreData

class DetailController: UIViewController {
    var contact : Contacts?{
        didSet {
            navigationItem.title = contact?.name
        }
    }
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "33-1")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 50
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImageView)))
        return imageView
    }()
    let imageSeparator : UIView = {
        let  cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 119, g: 75, b: 153)
        return cv
    }()
    let nameText : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator : UIView = {
        let  cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 119, g: 75, b: 153)
        return cv
    }()
    let surnameText : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Surname"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let surnameSeparator : UIView = {
        let  cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 119, g: 75, b: 153)
        return cv
    }()
    let companyText : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Company"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let companySeparator : UIView = {
        let  cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return cv
    }()
    
    let emailText : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator : UIView = {
        let  cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 119, g: 75, b: 153)
        return cv
    }()
    let numberText : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Number"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let numberSeparator : UIView = {
        let  cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(r: 119, g: 75, b: 153)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saving))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        setupSubviews()
        if let contact = contact {
            numberText.text = contact.number
            nameText.text = contact.name
            surnameText.text = contact.surname
            emailText.text = contact.email
            companyText.text = contact.company
            if let image = contact.photo  {
                imageView.image = UIImage(data: image as Data)
            }
        }
    }
   
    @objc func saving(){
        if saveContact(){
            navigationController?.popViewController(animated: true)
        }
    }
    @objc func handleCancel(){
        navigationController?.popViewController(animated: true)
    }
    func saveContact() -> Bool{
        if nameText.text!.isEmpty {
            let alert = UIAlertController(title: "Validation error", message: "input the name or phone number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        if contact == nil {
            contact = Contacts()
        }
        if let contact = contact {
            contact.number = numberText.text
            contact.name = nameText.text
            contact.surname = surnameText.text
            contact.email = emailText.text
            contact.company = companyText.text
            contact.photo = UIImagePNGRepresentation(imageView.image!) as? NSData
            CoreDataManager.instance.saveContext()
        }
        return true
    }
    func setupSubviews(){
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(imageSeparator)
        imageSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        imageSeparator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageSeparator.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant : 20).isActive = true
        imageSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(nameText)
        nameText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nameText.topAnchor.constraint(equalTo: imageSeparator.bottomAnchor).isActive = true
        nameText.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        view.addSubview(nameSeparator)
        nameSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameSeparator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant : 1).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(surnameText)
        surnameText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        surnameText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        surnameText.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
        surnameText.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        view.addSubview(surnameSeparator)
        surnameSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        surnameSeparator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        surnameSeparator.topAnchor.constraint(equalTo: surnameText.bottomAnchor, constant : 1).isActive = true
        surnameSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(companyText)
        companyText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        companyText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        companyText.topAnchor.constraint(equalTo: surnameSeparator.bottomAnchor).isActive = true
        companyText.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        view.addSubview(companySeparator)
        companySeparator.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        companySeparator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        companySeparator.topAnchor.constraint(equalTo: companyText.bottomAnchor, constant: 1).isActive = true
        companySeparator.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        view.addSubview(numberText)
        numberText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        numberText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        numberText.topAnchor.constraint(equalTo: companySeparator.bottomAnchor).isActive = true
        numberText.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        view.addSubview(numberSeparator)
        numberSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        numberSeparator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        numberSeparator.topAnchor.constraint(equalTo: numberText.bottomAnchor, constant: 1).isActive = true
        numberSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        view.addSubview(emailText)
        emailText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        emailText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        emailText.topAnchor.constraint(equalTo: numberSeparator.bottomAnchor).isActive = true
        emailText.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        view.addSubview(emailSeparator)
        emailSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        emailSeparator.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 1).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
}

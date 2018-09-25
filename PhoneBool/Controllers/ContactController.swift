//
//  ViewController.swift
//  PhoneBool
//
//  Created by Andrii Pyvovarov on 14.09.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import CoreData

class ContactController: UITableViewController, NSFetchedResultsControllerDelegate {
    var cellId = "cellId"
//    var chooseContact : Contacts?
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barTintColor = UIColor(r: 227, g: 243, b: 90)
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.title = "Contacts"
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        fetchedResultController.delegate = self
        do{
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
//        self.performSegue(withIdentifier: "MyContact", sender: self)
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let contact = fetchedResultController.object(at: indexPath) as! Contacts
                let cell = tableView.cellForRow(at: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    var fetchedResultController  = CoreDataManager.instance.fetchedResultController(entityName: "Contacts", keyForSort: "name")
    @objc func addTapped(){
        let detailController = DetailController()
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contact = fetchedResultController.object(at: indexPath) as? Contacts {
        showContact(contact: contact)
        }
    }
    @objc func showContact(contact : Contacts){
        let detailController =  DetailController()
        detailController.contact = contact
        navigationController?.pushViewController(detailController, animated: true)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MyContact" {
//            let controller = segue.destination as! DetailController
//            controller.contact = sender as? Contacts
//        }
//    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  contact = fetchedResultController.object(at: indexPath) as! Contacts
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.nameLabel.text = contact.name
        if let image = contact.photo {
            cell.profileImageView.image = UIImage(data: image as Data)
        }
        
//        var chooseContact = CoreDataManager.instance.fetchedContact(entityName: "Contacts", name: cell.nameLabel.text!).predicate
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


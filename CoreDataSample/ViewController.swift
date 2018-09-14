//
//  ViewController.swift
//  CoreDataSample
//
//  Created by IOS_Class on 9/4/18.
//  Copyright © 2018 IOS_Class. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBAction func showEmployeeTyped(_ sender: Any) {
        
        let context=appDelegate.persistentContainer.viewContext
        
        let employeeRequest:NSFetchRequest<Employee>=Employee.fetchRequest()
        
        let employees=try! context.fetch(employeeRequest)
        
        for item in employees
        {
            print(item.firstName!,item.lastName!,item.salary)
        }
        
        
        if let employee=employees.first
        {
            employee.lastName="Ahmad Abadi"
            
            try! context.save()
        }
        
        
        
    }
    
    
    @IBAction func insertTypedEmployee(_ sender: Any) {
        let context=appDelegate.persistentContainer.viewContext
        let employee=Employee(context: context)
        employee.firstName="maryam"
        employee.lastName="bahmani"
        employee.salary=400000
        
        try! context.save()
        
        
    }
    
    
    
    @IBAction func editEmployee(_ sender: Any) {
        
        var context=appDelegate.persistentContainer.viewContext
        let employeeRequest:NSFetchRequest<Employee>=NSFetchRequest(entityName: "Employee")
        
        employeeRequest.predicate=NSPredicate(format: "%K = %@", #keyPath(Employee.lastName),"hekmat")
        
        let employees=try! context.fetch(employeeRequest)
        
        if let employee=employees.first
        {
            context.delete(employee)
            
            try! context.save()
        }
        
    }
    
    
    //
    @IBAction func showAllEmployee(_ sender: Any) {

        //Sample 1
//        var employeeRequest:NSFetchRequest<Employee>=NSFetchRequest(entityName: "Employee")
//
//        var context=appDelegate.persistentContainer.viewContext
//
//        let employees=try! context.fetch(employeeRequest)
//
//        for employee in employees
//        {
//            print(employee.value(forKey: "firstName"),employee.value(forKey: "lastName"),employee.value(forKey: "salary"))
//        }
        
        //Sample 2
        var employeeRequest:NSFetchRequest<Employee>=NSFetchRequest(entityName: "Employee")
        //employeeRequest.predicate=NSPredicate(format: "lastName='hekmat'")
        //employeeRequest.predicate=NSPredicate(format: "lastName = %@", "hekmat")
        //employeeRequest.predicate=NSPredicate(format: "%K = %@", #keyPath(Employee.lastName),"hekmat")
        
        let salarySort=NSSortDescriptor(key: "salary", ascending: false)
        employeeRequest.sortDescriptors=[salarySort]
        var context=appDelegate.persistentContainer.viewContext
        
        let employees=try! context.fetch(employeeRequest)
        
        for employee in employees
        {
            print(employee.value(forKey: "firstName"),employee.value(forKey: "lastName"),employee.value(forKey: "salary"))
        }
        
    }
    
    @IBAction func insertEmployee(_ sender: Any) {
        
        var context=appDelegate.persistentContainer.viewContext
        let employee=NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        employee.setValue("amir", forKey: "firstName")
        employee.setValue("kamali", forKey: "lastName")
        employee.setValue(700000, forKey: "salary")
        
        do
        {
          try context.save()
            print("### Insert Employee Successfully ###")
        
        }
        catch
        {
            print("Error in Insert Emplouyee")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        app.persistentContainer.persistentStoreCoordinator
//        app.persistentContainer.viewContext
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  TableTabbedViewController.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import UIKit

class TableTabbedViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var refreshButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "On The Map"
        OTMClient.getStudent { (students, error) in
            StudentModel.student = students
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        OTMClient.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "postStudentFromTaple", sender: nil)
    }
    @IBAction func refreshButtonPressed(_ sender: Any) {
        OTMClient.getStudent { (students, error) in
            StudentModel.student = students
            self.tableView.reloadData()
        }
    }
}

extension TableTabbedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellTableViewCell") as? TableCellTableViewCell {
            let studentChosen = StudentModel.student[indexPath.row]
            cell.configureUI(firstName: studentChosen.firstName, lastName: studentChosen.lastName, mediaURL: studentChosen.mediaURL)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = StudentModel.student[indexPath.row]
        let app = UIApplication.shared
        app.open(URL(string: student.mediaURL)!, options: [:], completionHandler: nil)
    }
}

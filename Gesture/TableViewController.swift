//
//  TableViewController.swift
//  Gesture
//
//  Created by Sergey Pugach on 11/3/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //var extraHeight: CGFloat = 0
    var selected: Bool?
    
    var defaultCellHeight: CGFloat = 40
    var errorCellHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func reloadIt(_ sender: UIBarButtonItem) {
        
        //isHasError = !isHasError
        //extraHeight = extraHeight == 50 ? 0 : 50
        selected = !(selected ?? false)
        errorCellHeight = errorCellHeight == 40 ? 80 : 40
        tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell

        cell.label.text = "ROW: \(indexPath.row)"
        // Configure the cell...

        if 4 == indexPath.row && selected == true {
            
            cell.errorTextFieldView.fieldStyle = .error
//            if cell.errorTextFieldView.fieldStyle == .normal {
//                cell.errorTextFieldView.fieldStyle = .error
//
//            } else {
//                cell.errorTextFieldView.fieldStyle = .normal
//            }
        } else {
           cell.errorTextFieldView.fieldStyle = .normal
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row != 4 ? defaultCellHeight : errorCellHeight
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

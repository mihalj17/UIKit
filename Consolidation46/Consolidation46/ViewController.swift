//
//  ViewController.swift
//  Consolidation46
//
//  Created by Matko Mihaljl on 11.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCart))
        
        refreshCart()
    }
    @objc func refreshCart(){
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    @objc func addItem (){
        let ac = UIAlertController(title: "Enter Item in shopping cart", message: "What do you want to buy", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {return}
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ item : String){
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        showMessage(Title: "You added item", Message: "Done!")
        return
    }
    
    func showMessage( Title: String,  Message: String){
        let ac = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}







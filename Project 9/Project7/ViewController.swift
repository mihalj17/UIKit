//
//  ViewController.swift
//  Project7
//
//  Created by Matko Mihaljl on 11.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(info))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(filter))
        
        
        performSelector(inBackground: #selector(fetchJson), with: nil )
        
    }
    
    
    @objc func fetchJson () {
        
        let urlString:String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        }
        else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    
    
    
    @objc func info(){
        let message = UIAlertController(title: "Hellou", message:  "Api come from We The People API of the Whitehouse.", preferredStyle:.alert)
        message.addAction(UIAlertAction(title: "OK", style: .default))
        present(message,animated: true)
    }
    
    @objc func showError(){
        
        
        let ac = UIAlertController(title: "Loading errr", message: "There was a problem loading the feed,pleasae check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        
        
        
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            
            
            
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
    }
    
    @objc func filter(){
        let ac = UIAlertController(title: "Enter Title", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let dataFilter = ac?.textFields?[0].text else {return}
            self?.submit(dataFilter)
            self?.tableView.reloadData()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ dataFilter : String){
        
        if(dataFilter != "") {
            for petition in petitions {
                if(petition.title.contains(dataFilter) || petition.body.contains(dataFilter)){
                    filteredPetitions.append(petition)
                }
            }
            petitions = filteredPetitions
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        ovisnost jel radimo s filtriranim ili obicnim
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        napraviti uvjete da pazi jel vadimo podoatke iz obicnih ili filtered
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        obicni ili filtrirani
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController( vc , animated: true)
    }
    
    
}


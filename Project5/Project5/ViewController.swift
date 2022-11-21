//
//  ViewController.swift
//  Project5
//
//  Created by Matko Mihaljl on 09.08.2022..
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        startGame()
        
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc  func promptForAnswer(){
        
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func submit(_ answer : String){
        
        let lowerAnswer = answer.lowercased()
        
        if lowerThanThree(word: lowerAnswer){
            if isPossible(word: lowerAnswer){
                if isOriginal(word: lowerAnswer){
                    if isReal(word: lowerAnswer){
                        usedWords.insert(answer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    }
                    else {
                        showErrorMessage(errorTitle: "Word not recognized", errorMessage: "You cant juts make them up, you know!")
                        
                    }
                } else {
                    showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original!")
                    
                    
                }
            }
            else {
                
                showErrorMessage(errorTitle: "Word not possible", errorMessage:"You cant spell that word from")
                
            }
            
            
        } else {
            showErrorMessage(errorTitle:"Watch Out!!", errorMessage:"Your word is shorter than 3 letters or is the same as title")
            
        }
        
    }
    func isPossible (word : String) -> Bool{
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    func isReal(word: String) -> Bool{
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange =  checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return mispelledRange.location == NSNotFound
        
    }
    func lowerThanThree(word :String) -> Bool{
        if (word.count < 3) || word == title {
            return false
        } else {
            return true
        }
    }
    
    func showErrorMessage( errorTitle: String,  errorMessage: String){
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
}

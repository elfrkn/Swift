//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Calis Family on 6.01.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var landmarkNames=[String]()
    var landmarkImages=[UIImage]()
    var chosenLandmarkName=""
    var chosenLandmarkImage=UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
     
        landmarkNames.append("Buckingham Sarayı")
        landmarkNames.append("Kız Kulesi")
        landmarkNames.append("Mescidi Aksa")
        landmarkNames.append("Taj Mahal")
        
      
        landmarkImages.append(UIImage(named: "buckinghamsarayı.jpg")!)
        landmarkImages.append(UIImage(named: "kızkulesi.jpg")!)
        landmarkImages.append(UIImage(named: "mescidiaksa")!)
        landmarkImages.append(UIImage(named: "tajmahal.jpg")!)

        
    }

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        //cell.textLabel?.text="test"
        
        var content=cell.defaultContentConfiguration()
        content.text=landmarkNames[indexPath.row]
        cell.contentConfiguration=content
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandmarkName=landmarkNames[indexPath.row]
        chosenLandmarkImage=landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! Details
            destinationVC.selectedLandmarkName=chosenLandmarkName
            destinationVC.selectedLandmarkImage=chosenLandmarkImage
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.landmarkImages.remove(at: indexPath.row)
            self.landmarkNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:.fade)
        }
    }
   
}


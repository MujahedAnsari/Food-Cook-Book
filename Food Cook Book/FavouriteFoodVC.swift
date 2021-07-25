//
//  FavouriteFoodVC.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import UIKit

class FavouriteFoodVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var dietfoodArray = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let array = DBManager.shared.getAllRealMealList()
        for tempRealMeal in array {
             let tempMela = ConvertReamlToMolde().convertRealmMealToMeal(realMeal: tempRealMeal)
            dietfoodArray.append(tempMela)
        }
        tableview.delegate = self
        tableview.dataSource = self
        // Do any additional setup after loading the view.
    }

}


extension FavouriteFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietfoodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
            cell.Name_lbl.text = dietfoodArray[indexPath.row].strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vcArrays = self.navigationController?.viewControllers else {return }
        for vc  in vcArrays {
            if let tempVC = vc as? ViewController {
                tempVC.meal = dietfoodArray[indexPath.row]
                self.navigationController?.popToViewController(tempVC, animated: true)
            }
        }
    }//end fnction body.
}

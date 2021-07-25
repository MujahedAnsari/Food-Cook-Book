//
//  SearchFoodVC.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import UIKit
import Reachability

class SearchFoodVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIV: UIActivityIndicatorView!
    @IBOutlet weak var search_Bar: UISearchBar!
    
    var foodDataArray:[[String: Any]]  = Array()
    var dietFoodArray:[Meal] = Array()
    var dietName : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
        // Do any additional setup after loading the view.
    }
    
    private func searAPI(name: String){
        activityIV.startAnimating()
        SearchByNameAPI(_httpUtility: HttpUtility()).getFoodItems(foodName: name, completion: { [self] tempMealsArray in
            if let mealsArray = tempMealsArray {
                self.dietFoodArray = mealsArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    activityIV.stopAnimating()
                }
            }
        })
    }//end function body.
}

extension SearchFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietFoodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        if foodDataArray.count == 0 {
            cell.Name_lbl.text = dietFoodArray[indexPath.row].strMeal
        }else{
    
        } // End if else block
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vcArrays = self.navigationController?.viewControllers else {return }
        for vc  in vcArrays {
            if let tempVC = vc as? ViewController {
                tempVC.meal = dietFoodArray[indexPath.row]
                self.navigationController?.popToViewController(tempVC, animated: true)
            }
        }
    }//end fnction body.
}

extension SearchFoodVC: UISearchBarDelegate {
     // Get food data from the API
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if  let temptext = searchBar.text {
            self.searAPI(name: temptext)
        }
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            foodDataArray.removeAll()
            tableView.reloadData()
        }else {
            self.searAPI(name: searchText)
        }
    }
}

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var Name_lbl: UILabel!
}

//
//  ViewController.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var mealName_lbl: UILabel!
    @IBOutlet weak var mealCategory_lbl: UILabel!
    @IBOutlet weak var mealArea_lbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var instruction_textView: UITextView!
    @IBOutlet weak var mealThumbnail_imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var addFavourteButton: UIButton!
    
    var ingrientsArray = [String]()
    var measuresArray = [String]()
    var meal: Meal? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonToNavigationBar()
        callingRandomAPI()
    }

    private func callingRandomAPI() {
        spinner.startAnimating()
        RandomFoodAPI(_httpUtility: HttpUtility()).getRandomFoodItem { meal in
            DispatchQueue.main.async {
                if let tempMela = meal {
                    self.meal = tempMela
                    self.setUpView(meal: tempMela)
                }
                self.spinner.stopAnimating()
            }
        }
    }//end function body.
    
    override func viewWillAppear(_ animated: Bool) {
        if let tempMeal = meal {
            setUpView(meal: tempMeal)
        }
    }
    
    private func setUpView(meal: Meal){
        mealName_lbl.text = meal.strMeal
        mealCategory_lbl.text = meal.strCategory ?? "__"
        mealArea_lbl.text = meal.strArea ?? "__"
        instruction_textView.text = meal.strInstructions ?? ""
        mealThumbnail_imageView.sd_setImage(with: URL(string: meal.strMealThumb!), placeholderImage: UIImage(named: "defaultMeal"), options: .waitStoreCache, context: nil, progress: nil, completed: nil)
        let tempInst = MakeIngrientMeasureArray()
        ingrientsArray = tempInst.getIngrientArray(meal: meal)
        measuresArray =  tempInst.getMeasureArray(meal: meal)
        if DBManager.shared.isRealMealInDB(id: meal.idMeal){
            addFavourteButton.setImage(UIImage(named: "favourit"), for: .normal)
        }else {
            addFavourteButton.setImage(UIImage(named: "unfavourit"), for: .normal)
        }
        collectionView.reloadData()
    }//end function body.
    
    private func addButtonToNavigationBar() {
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        searchButton.setImage(UIImage(named: "foodsearch"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchFoodButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        let favroutesButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        favroutesButton.setTitle("Favourites", for: .normal)
        favroutesButton.addTarget(self, action: #selector(FavouritesFoodButtonTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: favroutesButton)
    }//end function body.
    
    @objc func searchFoodButtonTapped(sender: UIButton){
        if let vc = self.storyboard?.instantiateViewController(identifier: "SearchFoodVC") as? SearchFoodVC {
          self.navigationController?.pushViewController(vc, animated: true)
      }
    }//end function body.
    
    @objc func FavouritesFoodButtonTapped(sender: UIButton){
        if let vc = self.storyboard?.instantiateViewController(identifier: "FavouriteFoodVC") as? FavouriteFoodVC {
          self.navigationController?.pushViewController(vc, animated: true)
      }
    }//end function body.

    @IBAction func favouriteUnFavButtonTapped(_ sender: UIButton) {
        guard let tempMeal = meal else { return }
       let realMeal = ConvertReamlToMolde().convertMealToRealmMeal(meal: tempMeal)
        if !DBManager.shared.isRealMealInDB(id: realMeal.idMeal) {
            DBManager.shared.saveIntoDB(rmeal: realMeal)
        }
        sender.setImage(UIImage(named: "favourit"), for: .normal)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingrientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngrientCVCell", for: indexPath) as! IngrientCVCell
        cell.ingrient_lbl.text = ingrientsArray[indexPath.row]
        cell.measure_lbl.text = measuresArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}


class IngrientCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ingrient_lbl: UILabel!
    @IBOutlet weak var measure_lbl: UILabel!
}

//
//  RandomFoodAPI.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import Foundation

/*
 {
     "meals": [
         {
             "idMeal": "52822",
             "strMeal": "Toad In The Hole",
             "strDrinkAlternate": null,
             "strCategory": "Pork",
             "strArea": "British",
             "strInstructions": "Preheat the oven to 200°C/fan180°C/gas 6. fry sausages in a non-stick pan until browned.\r\nDrizzle vegetable oil in a 30cm x 25cm x 6cm deep roasting tray and heat in the oven for 5 minutes.\r\nPut the plain flour in a bowl, crack in the medium free-range eggs, then stir in the grated horseradish. Gradually beat in the semi-skimmed milk. Season.\r\nPut the sausages into the hot roasting tray and pour over the batter. Top with cherry tomatoes on the vine and cook for 30 minutes until puffed and golden.",
             "strMealThumb": "https://www.themealdb.com/images/media/meals/ytuvwr1503070420.jpg",
             "strTags": null,
             "strYoutube": "https://www.youtube.com/watch?v=t1dWkDrC330",
             "strIngredient1": "sausages",
             "strIngredient2": "vegetable oil",
             "strIngredient3": "plain flour",
             "strIngredient4": "eggs",
             "strIngredient5": "horseradish",
             "strIngredient6": "milk",
             "strIngredient7": "cherry tomatoes",
             "strIngredient8": "",
             "strIngredient9": "",
             "strIngredient10": "",
             "strIngredient11": "",
             "strIngredient12": "",
             "strIngredient13": "",
             "strIngredient14": "",
             "strIngredient15": "",
             "strIngredient16": "",
             "strIngredient17": "",
             "strIngredient18": "",
             "strIngredient19": "",
             "strIngredient20": "",
             "strMeasure1": "8",
             "strMeasure2": "3 tbsp",
             "strMeasure3": "100g",
             "strMeasure4": "2 medium",
             "strMeasure5": "1 tbsp grated",
             "strMeasure6": "225ml",
             "strMeasure7": "200g",
             "strMeasure8": "",
             "strMeasure9": "",
             "strMeasure10": "",
             "strMeasure11": "",
             "strMeasure12": "",
             "strMeasure13": "",
             "strMeasure14": "",
             "strMeasure15": "",
             "strMeasure16": "",
             "strMeasure17": "",
             "strMeasure18": "",
             "strMeasure19": "",
             "strMeasure20": "",
             "strSource": "http://www.deliciousmagazine.co.uk/recipes/georgina-fuggles-horseradish-and-vine-tomato-toad-in-the-hole/",
             "strImageSource": null,
             "strCreativeCommonsConfirmed": null,
             "dateModified": null
         }
     ]
 }
 */

struct Meal : Codable {
    
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified : String?
    
}

struct RandomFoodAPIResponse: Codable {
   let  meals: [Meal]
}

struct RandomFoodAPI  {
    var httpUtility: HttpUtility!
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
    }
    func getRandomFoodItem( completion: @escaping (Meal?)->Void) {
        print(StringUrl.randomAPI)
        guard let url = URL(string: StringUrl.randomAPI) else {   return }
        do {
            httpUtility.getApiData(requestUrl: url, resultType: RandomFoodAPIResponse.self) { response in
                print(response)
                completion(response.meals.first)
            }
        }catch let catchError {
            debugPrint(catchError.localizedDescription)
        }
    }
    
}//end struct

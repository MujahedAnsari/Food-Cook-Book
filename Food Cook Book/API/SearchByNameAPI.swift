//
//  SearchByNameAPI.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import Foundation

struct SearchByNameAPIAPIResponse: Codable {
   let  meals: [Meal]?
}
struct SearchByNameAPI {
    
    var httpUtility: HttpUtility!
    init(_httpUtility: HttpUtility) {
        httpUtility = _httpUtility
    }
    
    func getFoodItems(foodName: String, completion: @escaping ([Meal]?)-> Void) {
        print(StringUrl.randomAPI)
        var stringUrl = String()
        if foodName.count == 1{
            stringUrl = StringUrl.searchByFirstLetter
        }else {
            stringUrl = StringUrl.searchByName
        }
        stringUrl.append(foodName)
        guard let url = URL(string: stringUrl) else {   return }
        do {
            httpUtility.getApiData(requestUrl: url, resultType: SearchByNameAPIAPIResponse.self) { response in
                print(response)
                completion(response.meals)
            }
        }catch let catchError {
            debugPrint(catchError.localizedDescription)
        }
    }// end function body.
    
}//end struct body.

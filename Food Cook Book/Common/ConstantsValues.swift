//
//  Constants.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import Foundation

struct ConstantsValues  {
    
    static let baseUrl = "https://www.themealdb.com/api/json/v1/" //https://www.themealdb.com/api/json/v1/1/random.php
    static let apiKey = "1"
    
}

struct StringUrl {
    static let randomAPI = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/random.php"
    static let searchByName = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/search.php?s="
    static let searchByFirstLetter = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/search.php?f="
    static let searchById = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/lookup.php?i="
    static let randomselection = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/randomselection.php"
    static let searchBycategory = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/categories.php"
    static let searchByCategoryList = ConstantsValues.baseUrl + ConstantsValues.apiKey + "/list.php?c=list"
    //www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
    /*
     www.themealdb.com/api/json/v1/1/list.php?c=list
     www.themealdb.com/api/json/v1/1/list.php?a=list
     www.themealdb.com/api/json/v1/1/list.php?i=list
     */
}

//
//  DBManager.swift
//  Food Cook Book
//
//  Created by Mujahed Ansari on 25/07/21.
//

import Foundation
import RealmSwift

struct DBManager {
   static let shared = DBManager()
    private init() { }
    
    func saveIntoDB(rmeal: RealMeal) {
        var realm:Realm!
        let isUpdate = isRealMealInDB(id: rmeal.idMeal)
        do {
            realm = try Realm()
            realm.refresh()
        }catch {
            print("Error while opening database \(error)")
           // CommonUtils.showDatabaseErrorAlert()
        }
        print("saveIntoDB")
        print(rmeal)
        do {
            try realm.write {
                if isUpdate {
                    realm.add(rmeal, update: .modified)
                }else {
                    realm.add(rmeal)
                }
            }
        }catch {
            print("Error while opening database \(error)")
           // CommonUtils.showDatabaseErrorAlert()
        }
    } //emd function body.
    
     func isRealMealInDB(id: String) -> Bool {
        var realm:Realm!
        do {
            realm = try Realm()
            realm.refresh()
        }catch {
            print("Error while opening database \(error)")
            //CommonUtils.showDatabaseErrorAlert()
        }
        let sumList = realm.objects(RealMeal.self).filter("idMeal = '\(id)'")
        print(sumList)
        if sumList.count != 0 {
            return true
        }
        return false
    }//end function boduy.
    
    func getAllRealMealList() -> [RealMeal] {
        var array = [RealMeal]()
       var realm:Realm!
       do {
           realm = try Realm()
           realm.refresh()
       }catch {
           print("Error while opening database \(error)")
           //CommonUtils.showDatabaseErrorAlert()
       }
       let sumList = realm.objects(RealMeal.self)
       print(sumList)
        for item in sumList {
            array.append(item)
        }
       return array
   }//end function body.
}

//
//  HttpUtility.swift
//  Reading Right
//
//  Created by Mujahed Ansari on 25/07/21.
//
//

import Foundation

struct HttpUtility {
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        urlRequest.timeoutInterval = 60.0
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                      print(json)
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error)")
                }
            }
        }.resume()
    }

    func postApiData<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.timeoutInterval = 60.0
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            print(httpUrlResponse)
            if(data != nil && data?.count != 0)
            {
                do {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
    
    func postApiData<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, header: [String: String],completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.timeoutInterval = 60.0
        for key in header.keys {
            urlRequest.addValue(header[key]!, forHTTPHeaderField: key)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            print(httpUrlResponse)
            if(data != nil && data?.count != 0)
            {
                do {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
    
    func putApiData<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.timeoutInterval = 60.0
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
    
    func deleteApiData<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "DELETE"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.timeoutInterval = 60.0
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                do {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(json)
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
    
}

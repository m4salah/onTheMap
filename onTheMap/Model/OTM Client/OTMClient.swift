//
//  OTMClient.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import Foundation

class OTMClient {
    
    struct Auth {
        static var firstName = ""
        static var lastName = ""
        static var key = ""
        static var sessionId = ""
        static var createdAtDate = ""
        static var objectId = ""
    }
    
    enum Endpoints {
        case login
        case logout
        case getStudent
        case postStudent
        case putStudent(String)
        case getUsername(String)
        
        var stringValue: String {
            switch self {
            case .login:
                return "https://onthemap-api.udacity.com/v1/session"
            case .logout:
                return "https://onthemap-api.udacity.com/v1/session"
            case .getStudent:
                return "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt&limit=100"
            case .postStudent:
                return "https://onthemap-api.udacity.com/v1/StudentLocation"
            case let .putStudent(id):
                return "https://onthemap-api.udacity.com/v1/StudentLocation/\(id)"
            case let .getUsername(key):
                return "https://onthemap-api.udacity.com/v1/users/\(key)"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> () ) {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(LoginRequest(udacity: Udacity(username: username, password: password)))
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            do {
                let responseObj = try JSONDecoder().decode(LoginResponse.self, from: data.subdata(in: 5..<data.count))
                Auth.sessionId = responseObj.session.id
                Auth.key = responseObj.account.key
                Auth.createdAtDate = getCurrentDate()
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    // 5767440107S1dac285a1e337df4360e6518a83bc3a5 3550916051 Monday, May 4, 2020 at 11:07:26 AM Eastern European Standard Time
    
    class func logout(completion: @escaping () -> () ) {
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            Auth.sessionId = ""
            Auth.key = ""
            completion()
        }
        task.resume()
    }
    
    class func getStudent(competion: @escaping ([Student], Error?) -> () ) {
        let task = URLSession.shared.dataTask(with: Endpoints.getStudent.url) { (data, response, error) in
            guard let data = data else {
                competion([], error)
                return
            }
            do {
                let responseObj = try JSONDecoder().decode(StudentRequest.self, from: data)
                DispatchQueue.main.async {
                    competion(responseObj.results, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    competion([], error)
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    class func postStudent(mapString: String, mediaURL:String, longitude: Double, latitude: Double,completion: @escaping (Student?, Error?) -> () ) {
        var request = URLRequest(url: Endpoints.postStudent.url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = Student(firstName: Auth.firstName, lastName: Auth.lastName, longitude: longitude, latitude: latitude, mapString: mapString, mediaURL: mediaURL, uniqueKey: Auth.key, objectId: Auth.sessionId, createdAt: Auth.createdAtDate, updatedAt: getCurrentDate())
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let responseObj = try JSONDecoder().decode(PostStudentResponse.self, from: data)
                Auth.objectId = responseObj.objectId
                print(Auth.objectId)
                DispatchQueue.main.async {
                    print(Auth.objectId)
                    completion(body, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                print("Faild to post student", error.localizedDescription)
            }

        }
        task.resume()
        
    }
    
    class func getUsername(completion: @escaping (Bool, Error?) -> () ) {
    
        let task = URLSession.shared.dataTask(with: Endpoints.getUsername(Auth.key).url) { data, response, error in
            guard let data = data else {
                completion(false, error)
                return
            }
            let newData = data.subdata(in: 5..<data.count) /* subset response data! */
            do {
                let responseObj = try JSONDecoder().decode(StudentPublicData.self, from: newData)
                Auth.firstName = responseObj.firstName
                Auth.lastName = responseObj.lastName
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                print("cannot get student name", error.localizedDescription)
                DispatchQueue.main.async {
                    completion(false, nil)
                }
            }
          
        }
        task.resume()
    }
    
    class func getCurrentDate()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        return dateFormatter.string(from: Date())
    }
}

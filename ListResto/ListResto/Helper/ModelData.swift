//
//  Auth.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 29/05/22.
//  Credit: Ipung DEV Academy @ YT

import Foundation
import Combine
import SystemConfiguration

class ModelData: ObservableObject {
    
    let API = "https://tugaskuliahku.xyz/api/"
    
    var stateChange = PassthroughSubject<ModelData, Never>()
    
    @Published var userData: UserData = UserData.default
    var respRece: RespRece = RespRece.default
    @Published var allResto = [AllRestoData]()
    @Published var restoData: RestoData = RestoData.default
    @Published var correct: Bool = true
    @Published var received: Bool = false
    @Published var loggedIn: Bool = false {
        didSet {
            stateChange.send(self)
        }
    }
    
    func checkLogin(email: String, password: String){
        self.correct = true
        self.received = false
        self.loggedIn = false
        guard let url = URL(string: "\(API)login.php") else { return }
        
        let bodyReq : [String : String] = ["email" : email, "password" : password]
        
        guard let finaldata = try? JSONEncoder().encode(bodyReq) else {return}
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finaldata
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {return}
            
            let result = try? JSONDecoder().decode(UserData.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    if(!result.err){
                        self.loggedIn = true
                        self.userData.id = result.id
                        self.userData.user = result.user
                        self.userData.err = result.err
                        self.userData.message = result.message
                    }else{
                        self.correct = false
                        self.userData.message = result.message
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.correct = false
                }
            }
        }.resume()
    }
    
    func register(nama: String, email: String, password: String){
        self.correct = true
        self.received = false
        guard let url = URL(string: "\(API)register.php") else { return }
        
        let bodyReq : [String : String] = ["nama" : nama, "email" : email, "password" : password]
        
        guard let finaldata = try? JSONEncoder().encode(bodyReq) else {return}
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finaldata
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, response == response, error == nil else {return}
            
            let result = try? JSONDecoder().decode(RespRece.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    if(!result.err){
                        self.correct = true
                        self.received = true
                        self.userData.message = result.message
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.correct = false
                }
            }
        }.resume()
    }
    
    func readAllResto(id: Int){
        self.correct = true
        self.received = false
        guard let url = URL(string: "\(API)read-allresto.php") else { return }
        
        let bodyReq : [String : Int] = ["id" : id]
        
        guard let finaldata = try? JSONEncoder().encode(bodyReq) else {return}
        
        var request = URLRequest(url: url)
        
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finaldata
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let RestosData = data {
                    let decodedData = try JSONDecoder().decode(AllResto.self, from: RestosData)
                    DispatchQueue.main.async {
                        self.received = true
                        self.allResto = decodedData.resto
                    }
                } else {
                    self.received = false
                    print("No data")
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func readResto(id: Int){
        self.correct = true
        self.received = false
        guard let url = URL(string: "\(API)readbyid-resto.php") else { return }
        
        let bodyReq : [String : Int] = ["id" : id]
        
        guard let finaldata = try? JSONEncoder().encode(bodyReq) else {return}
        
        var request = URLRequest(url: url)
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finaldata
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let DataResto = data {
                    let decodedData = try JSONDecoder().decode(RestoData.self, from: DataResto)
                    DispatchQueue.main.async {
                        self.received = true
                        self.restoData.nama_resto = decodedData.nama_resto
                        self.restoData.img = decodedData.img
                        self.restoData.rating = decodedData.rating
                        self.restoData.detail = decodedData.detail
                        self.restoData.latitude = decodedData.latitude
                        self.restoData.longitude = decodedData.longitude
                        self.restoData.fav = decodedData.fav
                    }
                } else {
                    self.received = false
                    print("No data")
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func addResto(id: String, nama_resto: String, img: String, rating: String, detail: String, latitude: String, longitude: String, favorite: String){
        self.received = false
        guard let url = URL(string: "\(API)add-resto.php") else { return }
        
        let bodyReq : [String : String] = ["id_user" : id, "nama_resto" : nama_resto, "rating": rating, "detail":detail, "latitude":latitude,"longitude":longitude, "img":img, "favorite":favorite]
        
        guard let finaldata = try? JSONEncoder().encode(bodyReq) else {return}
        
        var request = URLRequest(url: url)
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finaldata
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let DataResto = data {
                    let decodedData = try JSONDecoder().decode(RespRece.self, from: DataResto)
                    DispatchQueue.main.async {
                        self.respRece.err = decodedData.err
                        self.respRece.message = decodedData.message
                    }
                } else {
                    self.received = false
                    print("No data")
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

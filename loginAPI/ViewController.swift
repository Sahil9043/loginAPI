//
//  ViewController.swift
//  loginAPI
//
//  Created by Lalaiya Sahil on 28/02/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailtextFilde: UITextField!
    @IBOutlet weak var passwordtextFilde: UITextField!
    var arrUser: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        getUsers()
    }
    
    @IBAction func loginButtonclicked(_ sender: Any) {
        let loginUserViewController = storyboard?.instantiateViewController(withIdentifier: "LoginUserViewController") as! LoginUserViewController
        navigationController?.pushViewController(loginUserViewController, animated: true)
    }
    private func getUsers(){
        let perameter: Parameters = ["email" : "\(emailtextFilde.text)", "password" : "\(passwordtextFilde.text)"]
        AF.request("https://reqres.in/api/login", method: .post,parameters: perameter).responseData {  response in
            debugPrint("response \(response)")
            if response.response?.statusCode == 200{
                guard let apiData = response.data else {return}
                do{
                    self.arrUser = try JSONDecoder().decode([User].self, from: apiData)
                }
                catch{
                    print(error.localizedDescription)
                }
            }else{
                print("Something went wrong")
            }
        }
    }

}
struct User: Decodable{
    var email: String
    var password: String
}


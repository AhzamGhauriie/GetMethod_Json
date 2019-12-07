//
//  ViewController.swift
//  GetPost
//
//  Created by HigherVisibility on 06/12/2019.
//  Copyright © 2019 ahmedHigherVisibility. All rights reserved.
//

import UIKit
struct jsonstruct:Decodable{
    let name:String
    let capital:String
    let alpha2Code:String
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
  

    @IBOutlet weak var tableview: UITableView!
    var arrData = [jsonstruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    getData()
    }
    
    func getData(){
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error)in
            
            do{if error == nil
            {
                self.arrData = try JSONDecoder().decode([jsonstruct].self, from: data!)
             
                for mainarr in self.arrData{
                    print(mainarr.name,":",mainarr.capital,":",mainarr.alpha2Code)
                    
          
                DispatchQueue.main.async {
                      self.tableview.reloadData()
                }
                }
            }
            }
            catch{
                print("Error in getting json data")}
        }.resume()
    }
  //TABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblname.text = "Name :\(arrData[indexPath.row].name)"
        
        cell.lblcapital.text = "Capital :\(arrData[indexPath.row].capital)"
        
        return cell
    }
    
    
}

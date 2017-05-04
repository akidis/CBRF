//
//  MoneyTableViewController.swift
//  CBRF
//
//  Created by Andrey Kiselev on 01.05.17.
//  Copyright © 2017 Andrey Kiselev. All rights reserved.
//

import UIKit
import StoreKit
import SystemConfiguration

class MoneyTableViewController: UITableViewController {

    final let urlMoney = "http://www.cbr-xml-daily.ru/daily_json.js"
    
    var moneyArray: [String?] = []
    var differenceArray: [String?] = []
    var charCodeArray: [String?] = []
    var imageRateArray: [UIImage?] = []
    var valuteTranscription: [String?] = []
    var dateUpArray: [String?] = []
    
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        
        if isInternetAvailable() {
        
        UIView.animate(withDuration: 0.9, animations: {
            
            self.tableView.alpha = 0
            
            if self.tableView.alpha == 0 {
                
                UIView.animate(withDuration: 0.9, animations: {
                    
                    
                    self.tableView.alpha = 1
                    
                    let ac = UIAlertController(title: "Информация", message: "Данные успешно обновлены. Как правило, официальные курсы устанавливаются Банком России до 15:00 по московскому времени.", preferredStyle: .alert)
                    
                    let acAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                    
                    ac.addAction(acAction)
                    
                    self.present(ac, animated: true, completion: nil)
                    
                    
                })
                
            }
            
        })
        
        self.tableView.reloadData()
        
        } else {
            
            UIView.animate(withDuration: 0.9, animations: {
                
                self.tableView.alpha = 0
                
                if self.tableView.alpha == 0 {
                    
                    UIView.animate(withDuration: 0.9, animations: {
                        
                        
                        self.tableView.alpha = 1
                        
                        let ac = UIAlertController(title: "Информация", message: "Невозможно обновить данные. Проверьте подключение к сети или wi-fi соединению!", preferredStyle: .alert)
                        
                        let acAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                        
                        ac.addAction(acAction)
                        
                        self.present(ac, animated: true, completion: nil)
                        
                        
                    })
                    
                }
                
            })
            
            self.tableView.reloadData()
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
        
        self.downloadJsonFromUrl()
        
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    func downloadJsonFromUrl () {
        
        let url = NSURL(string: urlMoney)
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                if let dateVal = jsonObj?["Date"] {
                
                    self.dateUpArray.append("\(dateVal)")
                    
                    if let typeValute = jsonObj?["Valute"] as? NSDictionary  {
                        
                        
                            if let currencyUsd = typeValute["USD"] as? NSDictionary {
                                
                                if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                    
                                    
                                    let differenc = valueUsd - diff
                                    
                                    if Double(differenc) > 0 {
                                        
                                        let difFormat = String(format:"%.4f", differenc)
                                        self.differenceArray.append("+\(difFormat)")
                                        self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                        
                                    } else {
                                        
                                        let difFormat = String(format:"%.4f", differenc)
                                        self.differenceArray.append("\(difFormat)")
                                        self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                        
                                    }
                                    
                                    let valueFormat = String(format: "%.4f", valueUsd)
                                    
                                    
                                    
                                                                
                                    self.moneyArray.append("\(valueFormat)")
                                    self.charCodeArray.append("\(charC)")
                                    self.valuteTranscription.append("$ Доллар США")
                                    
                            }
                        }
                        
                        if let currencyUsd = typeValute["EUR"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                
                                let differenc = valueUsd - diff
                                let valueFormat = String(format: "%.4f", valueUsd)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("€ Евро")
                                
                            }
                        }
                        
                        if let currencyUsd = typeValute["GBP"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                
                                let differenc = valueUsd - diff
                                let valueFormat = String(format: "%.4f", valueUsd)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("£ Фунт стерлингов")
                                
                            }
                        }
                        
                        if let currencyUsd = typeValute["CNY"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                let nominalOne = Double(valueUsd) / 10.0
                                let nominalTwo = Double(diff) / 10.0
                                let differenc = nominalOne - nominalTwo
                                let valueFormat = String(format: "%.4f", nominalOne)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("¥ Китайский юань")
                                
                            }
                        }
                        
                        if let currencyUsd = typeValute["BYN"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                
                                let differenc = valueUsd - diff
                                let valueFormat = String(format: "%.4f", valueUsd)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("₽ Белорусский рубль")
                                
                            }
                        }
                        if let currencyUsd = typeValute["KZT"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                
                                let differenc = valueUsd - diff
                                let valueFormat = String(format: "%.4f", valueUsd)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("₸ Казахстанский тенге")
                                
                            }
                        }
                        if let currencyUsd = typeValute["UZS"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                
                                let differenc = valueUsd - diff
                                let valueFormat = String(format: "%.4f", valueUsd)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("Узбекский сум")
                                
                            }
                        }
                        if let currencyUsd = typeValute["UAH"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                let nominalOne = Double(valueUsd) / 10.0
                                let nominalTwo = Double(diff) / 10.0
                                let differenc = nominalOne - nominalTwo
                                let valueFormat = String(format: "%.4f", nominalOne)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("₴ Украинская гривна")
                                
                            }
                        }
                        if let currencyUsd = typeValute["JPY"] as? NSDictionary {
                            
                            if let valueUsd = currencyUsd["Value"] as? Double, let diff = currencyUsd["Previous"] as? Double, let charC = currencyUsd["CharCode"] {
                                
                                let nominalOne = Double(valueUsd) / 100.0
                                let nominalTwo = Double(diff) / 100.0
                                let differenc = nominalOne - nominalTwo
                                let valueFormat = String(format: "%.4f", nominalOne)
                                
                                if Double(differenc) > 0 {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("+\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle_green.png"))
                                    
                                } else {
                                    
                                    let difFormat = String(format:"%.4f", differenc)
                                    self.differenceArray.append("\(difFormat)")
                                    self.imageRateArray.append(#imageLiteral(resourceName: "triangle-red.png"))
                                    
                                }
                                
                                
                                self.moneyArray.append("\(valueFormat)")
                                self.charCodeArray.append("\(charC)")
                                self.valuteTranscription.append("¥ Японская иена")
                                
                            }
                        }

                    }
                }
                
                
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        }).resume()
    }

    func downloadJsonWithTask() {
        
        let url = NSURL(string: urlMoney)
        
        var downloadTask = URLRequest(url: (url as URL?)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData!)
            
        }).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
                
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moneyArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoneyTableViewCell
        
        
        cell.nameMoney.text = moneyArray[indexPath.row]
        cell.idLabel.text = differenceArray[indexPath.row]
        cell.valueLabel.text = charCodeArray[indexPath.row]
        cell.imageRate.image = imageRateArray[indexPath.row]
        cell.translateValute.text = valuteTranscription[indexPath.row]
        cell.dateLabel.text = dateUpArray[0]
        
        
        
        if let number = Double(cell.idLabel.text!), number > 0 {
            
            cell.idLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
        } else {
            
            cell.idLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            
        }
        
        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
 
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let share = UITableViewRowAction(style: .destructive, title: "Поделиться", handler: { (action, indexPath) in
            
            let defaultText = "Курс \(String(describing: self.charCodeArray[indexPath.row]!)) равен \(self.moneyArray[indexPath.row]!)\nОтправлено из приложения 'Курс Валют'!"
            
                let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            
            
        })
        
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    return [share]
    
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let dvc = segue.destination as! DetailViewController
                dvc.valuteValue = self.moneyArray[indexPath.row]!
                dvc.nameValute = self.charCodeArray[indexPath.row]!
                
            }
            
        }
        
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}

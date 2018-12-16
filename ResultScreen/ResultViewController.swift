//
//  ResultViewController.swift
//  Surya-test
//
//  Created by Arinjay on 09/12/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//



import UIKit
import AlamofireImage

class ResultViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    let postRequest = PostRequest()
    var items:[JsonStructure]?
    var searchKey:String?
    var cachedImages = [String: UIImage]()

    @IBOutlet weak var resultTableView: UITableView!{
        didSet{
            resultTableView.delegate = self
            resultTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            postRequest.getResult(searchKeyword: searchKey!) { (response, error) in
                if response != nil{
                    self.items = (response!.items)
                    self.resultTableView.reloadData()
                }
            }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items != nil {
            return items!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        if items != nil {
            if (items![indexPath.row].firstName) != nil && (items![indexPath.row].lastName) != nil{
                cell.userName.text = "\(items![indexPath.row].firstName!) \(items![indexPath.row].lastName!)"
            }else if (items![indexPath.row].firstName) != nil{
                cell.userName.text = "\(items![indexPath.row].firstName!)"
            }

            if (items![indexPath.row].emailId) != nil{
                cell.userEmail.text = (items![indexPath.row].emailId!)
            }
            
            if (items![indexPath.row].imageUrl) != nil{
                let imageURL = URL(string: (items![indexPath.row].imageUrl!))
                let request = URLRequest(url: imageURL!)

                cell.userImage.af_setImage(withURLRequest:request, placeholderImage: nil, filter: nil, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: nil)
            }
            
//            if (items![indexPath.row].imageUrl) != nil{
//                //let imageURL = URL(string: (items![indexPath.row].imageUrl!))
//                cell.userImage.imageFromServerURL(urlString: items![indexPath.row].imageUrl!, PlaceHolderImage: UIImage.init(named: "imagename")!)
//            }
            
            
        }
        
        return cell
    }
}


extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

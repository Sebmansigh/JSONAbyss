//
//  DetailViewController.swift
//  JSONAbyss
//
//  Created by Sebastian Snyder on 4/24/18.
//  Copyright © 2018 Sebastian Snyder. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var DetailImage: UIImageView!
    @IBOutlet weak var DetailTitle: UILabel!
    @IBOutlet weak var DetailYear: UILabel!
    @IBOutlet weak var DetailFormat: UILabel!
    @IBOutlet weak var DetailEpisodes: UILabel!
    @IBOutlet weak var DetailStudioNetwork: UILabel!
    @IBOutlet weak var DetailDescription: UILabel!
    @IBOutlet weak var DetailSummary: UITextView!
    
    var detailItem: [String: Any]?
    {
        didSet
        {
            // Update the view.
            configureView();
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = DetailImage {
                let url = URL(string: detail["imageURL"] as! String)!
                do
                {
                    imageView.image = try UIImage(data: Data(contentsOf: url))
                }
                catch
                {
                    print("Image not found at: "+url.absoluteString);
                }
            }
            if let label = DetailTitle {
                label.text = (detail["name"] as! String);
            }
            if let label = DetailYear {
                var detailStr = (detail["yearStart"] as! String)
                if let Yend = detail["yearEnd"] as? String
                {
                    if(Yend != detailStr)
                    {
                        detailStr += " -";
                        if(Int(Yend) != nil)
                        {
                            detailStr += " " + Yend;
                        }
                    }
                }
                label.text = detailStr;
            }
            if let label = DetailFormat {
                label.text = (detail["format"] as! String);
            }
            if let label = DetailEpisodes
            {
                if let epStr = detail["episodes"]
                {
                    let epN = epStr as! Int;
                    label.text = String(epN) + " Episode" + (epN > 1 ? "s" : "");
                }
                else
                {
                    label.text = "";
                }
            }
            if let label = DetailStudioNetwork
            {
                if let studio = detail["studio"]
                {
                    label.text = (studio as! String);
                }
                else if let network = detail["network"]
                {
                    label.text = (network as! String);
                }
            }
            if let label = DetailDescription {
                label.text = (detail["description"] as! String);
            }
            if let label = DetailSummary {
                label.text = (detail["summary"] as! String);
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}


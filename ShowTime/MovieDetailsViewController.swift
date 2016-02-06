//
//  MovieDetailsViewController.swift
//  ShowTime
//
//  Created by Kanch on 2/5/16.
//  Copyright © 2016 Kanch. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var detailsTitleLabel: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailsOverviewLabel: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var infoView: UIView!
    var movie : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height )
        
        print(movie)
        
        let title = movie["title"] as? String
        detailsTitleLabel.text = title
        
        let overview = movie["overview"] as? String
        detailsOverviewLabel.text = overview
        
        detailsOverviewLabel.sizeToFit()
        
        
        if let posterpath = movie["poster_path"] as? String
        {
        let baseUrl = "https://image.tmdb.org/t/p/w342"
        let imageUrl = NSURL(string: baseUrl + posterpath)
        detailsImageView.setImageWithURL(imageUrl!, placeholderImage: nil)
        }
        else
        {
            detailsImageView.image = nil
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   // override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
    

}

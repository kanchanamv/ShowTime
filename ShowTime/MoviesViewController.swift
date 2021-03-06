//
//  ViewController.swift
//  ShowTime
//
//  Created by Kanch on 2/4/16.
//  Copyright © 2016 Kanch. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    var movies = [NSDictionary]()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   print(movie)
        
        //  self.tableView.rowHeight = 320
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "didRefresh", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        networkRequest()
        
    }
    
    func networkRequest(){
        
        let clientId = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"http://api.themoviedb.org/3/movie/now_playing?api_key=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                if let data = dataOrNil {
                    self.networkErrorLabel.hidden = true
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            
                            self.movies = (responseDictionary["results"] as? [NSDictionary])!
                            
                            
                            //  print(self.movies.count)
                            self.tableView.reloadData()
                            
                            self.refreshControl.endRefreshing()
                    }
                }
                else{
                    self.networkErrorLabel.hidden = false
                }
        });
        task.resume()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didRefresh()
    {
        networkRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // self.movies.count
        return self.movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.movietableviewcell", forIndexPath: indexPath) as! MovieTableViewCell
        
        cell.myLabel.text = self.movies[indexPath.row]["title"] as? String
        cell.overviewLabel.text = self.movies[indexPath.row]["overview"] as? String
        cell.backgroundColor = UIColor.grayColor()
        
        if let posterpath = self.movies[indexPath.row]["poster_path"] as? String
        {
            let baseUrl = "https://image.tmdb.org/t/p/w342"
            let imageUrl = NSURL(string: baseUrl + posterpath)
            cell.moviesImageView.setImageWithURL(imageUrl!, placeholderImage:nil)
        }
        else
        {
            cell.moviesImageView.image = nil
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies[indexPath!.row]
        
        
        let movieDetailViewController = segue.destinationViewController as! MovieDetailsViewController
        movieDetailViewController.movie = movie
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}


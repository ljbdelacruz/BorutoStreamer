//
//  ViewController.swift
//  BorutoStream
//
//  Created by Lainel John Dela Cruz on 30/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import SVProgressHUD;
import Toast_Swift

class ViewController: UIViewController {
    @IBOutlet weak var UIAnimeSB: UISearchBar!
    @IBOutlet weak var UIAnimeTV: UITableView!
    var animes:[AnimeInfo]=[]
    var origList:[AnimeInfo]=[]
    var selectedAnime:AnimeInfo?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.UIAnimeSB.delegate=self;
        self.UIAnimeTV.delegate=self;
        self.UIAnimeTV.dataSource=self;
        self.LoadData(search: "")        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listToAnimeInfo" {
            let destVC=segue.destination as! AnimeInfoViewController
            destVC.animeInfo=self.selectedAnime;
            destVC.viewCompleteDelegate=self;
        }
    }
}
//MARK: -Searchbar func
extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText);
        self.LoadData(search: searchText);
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

//MARK: UITableView Func
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.animes[indexPath.row].Title
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedAnime=self.animes[indexPath.row];
        self.view.makeToast("Please wait loading resources")
        self.view.isUserInteractionEnabled=false;
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "listToAnimeInfo", sender: nil);
        }
    }
}
//MARK: -Firebase func
extension ViewController{
    func LoadData(search:String){
        if self.origList.count <= 0 && search.count <= 0 {
            AnimeInfo.all(completionHandler: {(data, err) in
                self.animes.append(data!);
                self.origList=self.animes;
                self.UIAnimeTV.reloadData()
            })
        }else if search.count <= 0{
            self.animes=origList;
            self.UIAnimeTV.reloadData();
            print(origList.count)
        }else{
            self.animes=AnimeInfo.likeName(title: search, animes: self.animes);
            self.UIAnimeTV.reloadData()
            print(self.animes.count)
        }
    }
}
//MARK: -Delegates
extension ViewController : ViewCompleteDelegate{
    func completeViewLoad() {
        self.view.isUserInteractionEnabled=true;
        self.view.hideToast()
    }
    
    
}


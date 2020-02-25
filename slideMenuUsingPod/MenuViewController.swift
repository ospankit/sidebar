//
//  MenuViewController.swift
//  slideMenuUsingPod
//
//  Created by Ankit on 24/02/20.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

enum MenuType:Int {
    case home
    case camera
    case photo
}

class MenuViewController: UIViewController {

    let menuList = ["Home","Camera","Photo"]
    
    var didTapMenuType :((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class MenuCellDetail: UITableViewCell {
    @IBOutlet weak var menuName: UILabel!
}

extension MenuViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellDetail") as! MenuCellDetail
        cell.menuName.text = menuList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuCase = MenuType(rawValue: indexPath.row) else {return}
        self.didTapMenuType?(menuCase)
        dismiss(animated: true, completion: nil)
    }
    
}

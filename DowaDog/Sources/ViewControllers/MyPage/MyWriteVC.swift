//
//  MyWriteVC.swift
//  DowaDog
//
//  Created by 조윤영 on 05/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MyWriteVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    var myScrapList = [MyScrap]()
    
    var reuseIdentifier = "myWriteCell"


    var myWriteList = [Community<CommunityImgList>]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn()


       tableView.dataSource = self
        tableView.delegate = self
        
        self.title = "내가 쓴 글"

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
     
        
    }


    func getData(){
        MyCommunityService.shared.getMyCommunity() { [weak self]
            (data) in
            guard let `self` = self else {return}
            
            self.myWriteList = data
            
            print("data ===================")
            print(data)
            print(data.count)
            print(self.myWriteList.count)
            print("data ===================")
            
            self.myWriteList = data
            
            self.tableView.reloadData()
            
        }
    }
}


extension MyWriteVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWriteList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as!MyWriteCell

        let write = myWriteList[indexPath.row]

        let date: String = gsno(write.createdAt)

        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy.MM.dd"

        let showDate: Date = fmt.date(from:date) ?? Date()

        let afterDate: String = fmt.string(from: showDate)

        cell.titleLabel.text = gsno(write.title)
        cell.dateLabel.text = afterDate

        return cell


    }
}

extension MyWriteVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! MyWriteCell

        let scrap = myWriteList[indexPath.row]

        let dvc = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityDetailVC") as! CommunityDetailVC

        dvc.id = gino(scrap.id)

        //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
        navigationController?.pushViewController(dvc, animated: true)

    }
}





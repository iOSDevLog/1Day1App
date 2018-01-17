//
//  TableViewController.swift
//  IDGMoveable
//
//  Created by iOS Dev Log on 2018/1/17.
//  Copyright © 2018年 iOSDevLog. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let titles = ["第一套 胜战计 ", "第二套 敌战计", "第三套 攻战计", "第四套 混战计", "第四套 并战计", "第六套 败战计"]
    
    var dataSource = [
        [
            "第一计 瞒天过海",
            "第二计 围魏救赵",
            "第三计 借刀杀人",
            "第四计 以逸待劳",
            "第五计 趁火打劫",
            "第六计 声东击西 ",
            ],
        [
            "第七计 无中生有",
            "第八计 暗渡陈仓",
            "第九计 隔岸观火 ",
            "第十计 笑里藏刀",
            "第十一计 李代桃僵",
            "第十二计 顺手牵羊",
            ],
        [
            "第十三计 打草惊蛇",
            "第十四计 借尸还魂",
            "第十五计 调虎离山",
            "第十六计 欲擒故纵",
            "第十七计 抛砖引玉",
            "第十八计 擒贼擒王 ",
            ],
        [
            "第十九计 釜底抽薪",
            "第二十计 混水摸鱼",
            "第二十一计 金蝉脱壳",
            "第二十二计 关门捉贼",
            "第二十三计 远交近攻",
            "第二十四计 假途伐虢 ",
            ],
        [
            "第二十五计 偷梁换柱",
            "第二十六计 指桑骂槐",
            "第二十七计 假痴不颠",
            "第二十八计 上屋抽梯",
            "第二十九计 树上开花",
            "第三十计 反客为主",
            ],
        [
            "第三十一计 美人计",
            "第三十二计 空城计",
            "第三十三计 反间计",
            "第三十四计 苦肉计",
            "第三十五计 连环计",
            "第三十六计 走为上",
            ],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.moveableDataSource = self
        tableView.moveableDelegate = self
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.section][indexPath.row].description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
}

extension TableViewController: IDLMoveableCellTableViewDataSource {
    func dataSourceArray(in tableView: UITableView) -> [Any] {
        return self.dataSource
    }
    
    func tableView(_ tableView: UITableView, newDataSourceArrayAfterMove newDataSourceArray: [Any]) {
        self.dataSource = newDataSourceArray as! [[String]]
    }
}

extension TableViewController: IDLMoveableCellTableViewDelegate {
    
    func tableView(_ tableView: UITableView, willMoveCellAt indexPath: IndexPath) {
        print(#function + " indexPath: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, didMoveCellFrom fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        print(#function + " fromIndexPath: \(fromIndexPath) toIndexPath \(toIndexPath)")
    }
    
    func tableView(_ tableView: UITableView, endMoveCellAt indexPath: IndexPath) {
        print(#function + " indexPath: \(indexPath)")
    }
    
    func tableView(_ tableView: UITableView, drawMovealbeCell: UIView) {
        drawMovealbeCell.layer.shadowColor = UIColor.green.cgColor
        drawMovealbeCell.layer.masksToBounds = false
        drawMovealbeCell.layer.cornerRadius = 0
        drawMovealbeCell.layer.shadowOffset = CGSize(width: -5, height: 0)
        drawMovealbeCell.layer.shadowOpacity = 0.4
        drawMovealbeCell.layer.shadowRadius = 5
    }
}

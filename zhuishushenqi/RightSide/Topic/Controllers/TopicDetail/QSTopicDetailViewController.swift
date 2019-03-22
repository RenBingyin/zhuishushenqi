//
//  QSTopicDetailViewController.swift
//  zhuishushenqi
//
//  Created caonongyun on 2017/4/20.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class QSTopicDetailViewController: BaseViewController ,UITableViewDataSource,UITableViewDelegate, QSTopicDetailViewProtocol {

	var presenter: QSTopicDetailPresenterProtocol?
    
    private var booksModel:[TopicDetailModel] = []
    
    private var headerModel:TopicDetailHeader?
    
    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        tableView.sectionFooterHeight = 10
        tableView.rowHeight = 93
        tableView.qs_registerCellNib(TopicDetailCell.self)
        tableView.qs_registerCellNib(TopicDetailHeaderCell.self)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        presenter?.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return TopicDetailHeaderCell.height(model: headerModel)
        }
        return TopicDetailCell.height(models: booksModel, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return booksModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell:TopicDetailHeaderCell? = tableView.qs_dequeueReusableCell(TopicDetailHeaderCell.self)
            headerCell?.backgroundColor = UIColor.white
            headerCell?.selectionStyle = .none
            headerCell?.model = headerModel
            return headerCell!
        }
        let cell:TopicDetailCell? = tableView.qs_dequeueReusableCell(TopicDetailCell.self)
        cell?.backgroundColor = UIColor.white
        cell?.selectionStyle = .none
        cell!.model = booksModel.count > (indexPath.section - 1) ? booksModel[indexPath.section - 1]:nil
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectAt(indexPath: indexPath, models: booksModel)
    }
    
    func showList(list: [TopicDetailModel], header: TopicDetailHeader) {
        self.booksModel = list
        self.headerModel = header
        self.tableView.reloadData()
    }
    
    func showEmpty() {
        
    }
    
    func showTitle(title: String) {
        self.title = title
    }

}

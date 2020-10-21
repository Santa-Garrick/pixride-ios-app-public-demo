//
//  QueryViewController+TableViewDelegate&DataSource.swift
//  Pix
//
//  Created by Николай Красиков on 20.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import UIKit


extension QueryViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView,
                  heightForRowAt indexPath: IndexPath) -> CGFloat {
      dynamicLayout.heightForRow(atIndexPath: indexPath)
   }
   
   func tableView(_ tableView: UITableView,
                  heightForHeaderInSection section: Int) -> CGFloat {
      return dynamicLayout.heightForHeader
   }
   
   func tableView(_ tableView: UITableView,
                  viewForHeaderInSection section: Int) -> UIView? {
      return headerView
   }
   
   func tableView(_ tableView: UITableView,
                  numberOfRowsInSection section: Int) -> Int {
      return categories.count
   }
   
   func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                     for: indexPath) as? CategoryCell else {
         print("Wrong cell id: \(cellID)")
         return UITableViewCell()
      }
      
      cell.backgroundColor = tableView.backgroundColor
      cell.titleLabel.text = categories[indexPath.row]
      cell.dynamicLayout = dynamicLayout
      
      if indexPath.row == 0 {
         cell.separatorEnabled = true
      }
      return cell
   }
   
   func tableView(_ tableView: UITableView,
                  heightForFooterInSection section: Int) -> CGFloat {
      return dynamicLayout.heightForSearchFieldFooter
   }
   
   func tableView(_ tableView: UITableView,
                  viewForFooterInSection section: Int) -> UIView? {
      return textFieldView
   }
   
   func tableView(_ tableView: UITableView,
                  willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      presenter.select(atIndex: indexPath.row)
      return nil
   }
   func tableView(_ tableView: UITableView,
                  willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
      presenter.deselect(atIndex: indexPath.row)
      return nil
   }
   
}

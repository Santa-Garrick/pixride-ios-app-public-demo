//
//  QueryPresenter.swift
//  Pix
//
//  Created by Николай Красиков on 09.10.2020.
//  Copyright © 2020 Pro13. All rights reserved.
//

import Foundation

protocol CategoriesListProvider {
   func fetch(completion: @escaping ([String]) -> Void)
}

class QueryPresenter: QueryPresenting {
   
   weak var view: QueryDisplaying?
   
   var categories: [RideCategory] = []
   
   let fetcher: CategoriesFetching!
   
   var categoriesToDisplay: [String] {
      ["Everything"] + categories.map { $0.title }
   }
   var customCategoryTitle: String = ""
   var customCategory: RideCategory {
      RideCategory(fromCustomTitle: customCategoryTitle)
   }
   var selected: [RideCategory] = []
   
   var query: RideQuery {
      
      let selected = customCategoryTitle.isEmpty ?
         self.selected :
         self.selected + [customCategory]
      
      return selected.isEmpty ?
         RideQuery(fromCategories: categories) :
         RideQuery(fromCategories: selected)
   }
   
   
   init(withFetcher fetcher: CategoriesFetching) {
      self.fetcher = fetcher
   }
   
   func getCategories() {
      fetcher.fetch { [weak self] (result) in
         DispatchQueue.main.async {
            guard let self = self else { return }
            switch result {
            case .success(let categories):
               self.categories = categories
            case .failure(let error):
               print(error)
               self.categories = []
            }
            self.view?.setCategories(self.categoriesToDisplay)
            self.view?.setSelected(atIndex: 0)
         }
      }
   }
   
   func select(atIndex index: Int) {
      if index == 0 {
         view?.setSelected(atIndex: 0)
         selected = []
         customCategoryTitle = ""
         view?.resetCustomQuery()
         _ = (1..<categoriesToDisplay.count).map{self.view?.setDeselected(atIndex: $0)}
      } else {
         
         selected.append(categories[index - 1])
         view?.setSelected(atIndex: index)
         view?.setDeselected(atIndex: 0)
      }
   }
   
   func deselect(atIndex index: Int) {
      guard index != 0 else { return }
      let categoryToDeselect = categories[index - 1]
      
      guard let indexToRemove = selected.firstIndex(where: { $0.title == categoryToDeselect.title }) else { return }
      
      selected.remove(at: indexToRemove)
      view?.setDeselected(atIndex: index)
      if selected.isEmpty && customCategoryTitle.isEmpty {
         view?.setSelected(atIndex: 0)
      }
   }
   
   func setCustomQuery(_ query: String) {
      customCategoryTitle = query
      if selected.isEmpty && customCategoryTitle.isEmpty {
         view?.setSelected(atIndex: 0)
      } else {
         view?.setDeselected(atIndex: 0)
      }
   }
}

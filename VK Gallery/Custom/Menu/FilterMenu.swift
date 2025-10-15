//
//  FilterMenu.swift
//  VK Gallery
//
//  Created by Иван Коновалов on 15.10.2025.
//

import UIKit

final class FilterMenu {
    
    enum MenuState: String {
        case recent = "Recent"
        case likes = "Likes"
        case comments = "Comments"
        case datePublished = "Date published"
    }
    
    enum SortBy: String {
        case ascending = "Ascending"
        case descending = "Descending"
    }
    
    private var currentMenuState: MenuState = .recent
    private var currentSortOption: SortBy = .descending
    
    private var delegate: FilterMenuDelegate!
    private var menu: UIMenu!
    
    init(title: String, delegate: FilterMenuDelegate) {
        configureMenu(menuTitle: title)
        
        self.delegate = delegate
        delegate.didUpdateMenu(menu: menu)
    }
    
    private func configureMenu(menuTitle: String){
        let children = configureChildren()
        
        menu = UIMenu(title: menuTitle, options: .displayInline, children: children)
    }
    
    private func configureChildren() -> [UIMenuElement] {
        var children: [UIMenuElement] = []
        children.append(contentsOf: configureCategoriesActions())
        children.append(UIMenu(title: "", options: .displayInline, children: configureSortActions()))
        
        return children
    }
    
    private func configureCategoriesActions() -> [UIAction] {
        return [
            createAction(stateInfo: .recent, symbol: SFSymbols.FilterMenuSymbols.mock),
            createAction(stateInfo: .datePublished, symbol: SFSymbols.FilterMenuSymbols.mock),
            createAction(stateInfo: .likes, symbol: SFSymbols.FilterMenuSymbols.mock),
            createAction(stateInfo: .comments, symbol: SFSymbols.FilterMenuSymbols.mock)
        ]
    }
    
    private func configureSortActions() -> [UIAction] {
        return [
            createAction(sortInfo: .ascending, symbol: SFSymbols.FilterMenuSymbols.mock),
            createAction(sortInfo: .descending, symbol: SFSymbols.FilterMenuSymbols.mock),
        ]
    }
    
    private func createAction(stateInfo: MenuState, symbol: String) -> UIAction {
        let action = UIAction(title: stateInfo.rawValue, image: UIImage(systemName: symbol)!, state: stateInfo.rawValue == currentMenuState.rawValue ? .on : .off){ [weak self] action in
            guard let self = self else { return }
            
            if action.state == .on { return }
            
            changeMenuState(with: stateInfo)
        }
        
        return action
    }
    
    private func createAction(sortInfo: SortBy, symbol: String) -> UIAction {
        let action = UIAction(title: sortInfo.rawValue, image: UIImage(systemName: symbol)!, state: sortInfo.rawValue == currentSortOption.rawValue ? .on : .off){ [weak self] action in
            guard let self = self else { return }
            
            if action.state == .on { return }
            
            changeSortOption(with: sortInfo)
        }
        
        return action
    }
    
    private func updateMenu() {
        let children = configureChildren()
        
        menu = menu.replacingChildren(children)
        
        delegate.didUpdateMenu(menu: menu)
    }
    
    private func changeMenuState(with state: MenuState) {
        currentMenuState = state
        updateMenu()
        delegate.didChangeMenuState(with: state)
    }
    
    private func changeSortOption(with option: SortBy) {
        currentSortOption = option
        updateMenu()
        delegate.didChangeSortOption(with: option)
    }
    
}

protocol FilterMenuDelegate {
    func didChangeMenuState(with state: FilterMenu.MenuState)
    
    func didUpdateMenu(menu: UIMenu)
    
    func didChangeSortOption(with option: FilterMenu.SortBy)
}


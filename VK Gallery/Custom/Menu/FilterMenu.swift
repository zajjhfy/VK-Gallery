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
    
    // TODO: Утечка памяти + форс анрап. Мы с тобой не обсуждали это, не знаю читал ли ты что-то про утечки памяти. Но как ты думаешь,
    // есть ли здесб проблема? (почитай про утечки памяти)
    private var delegate: FilterMenuDelegate!
    private var menu: UIMenu!
    
    init(title: String, delegate: FilterMenuDelegate) {
        self.delegate = delegate
        
        configureMenu(menuTitle: title)
        
        delegate.didInitDefaultStates(menuState: currentMenuState, sortOption: currentSortOption)
        delegate.didUpdateMenu(menu: menu)
    }
    
    // TODO: Все приватные функции можешь выносить в отдельный extension, либо сделать отдельную структурку/класс
    // которая будет делать что нужно. У тебя тут методы прямо связаны друг с другом (конфигурация и создание меню).
    // Соответственно либо можно сделать extension, либо MenuConfigurator
    
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
            createAction(stateInfo: .recent, symbol: SFSymbols.FilterMenuSymbols.recent),
            createAction(stateInfo: .datePublished, symbol: SFSymbols.FilterMenuSymbols.datePublished),
            createAction(stateInfo: .likes, symbol: SFSymbols.like),
            createAction(stateInfo: .comments, symbol: SFSymbols.comment)
        ]
    }
    
    private func configureSortActions() -> [UIAction] {
        return [
            createAction(sortInfo: .ascending, symbol: SFSymbols.FilterMenuSymbols.ascending),
            createAction(sortInfo: .descending, symbol: SFSymbols.FilterMenuSymbols.descending),
        ]
    }
    
    private func createAction(stateInfo: MenuState, symbol: String) -> UIAction {
        let action = UIAction(title: stateInfo.rawValue,
                              image: UIImage(systemName: symbol)!,
                              state: stateInfo.rawValue == currentMenuState.rawValue ? .on : .off) { [weak self] action in
            
            // TODO: Не помню с какой версии swift, но можно не писать self = self, можно просто
            // guard let self else { return }
            
            guard let self = self else { return }
            
            if action.state == .on { return }
            
            currentMenuState = stateInfo
            changeState()
        }
        
        return action
    }
    
    private func createAction(sortInfo: SortBy, symbol: String) -> UIAction {
        let action = UIAction(title: sortInfo.rawValue,
                              image: UIImage(systemName: symbol)!,
                              state: sortInfo.rawValue == currentSortOption.rawValue ? .on : .off) { [weak self] action in
            
            // TODO: Не помню с какой версии swift, но можно не писать self = self, можно просто
            // guard let self else { return }
            
            guard let self = self else { return }
            
            if action.state == .on { return }
            
            currentSortOption = sortInfo
            changeState()
        }
        
        return action
    }
    
    private func updateMenu() {
        let children = configureChildren()
        
        menu = menu.replacingChildren(children)
        
        delegate.didUpdateMenu(menu: menu)
    }
    
    private func changeState() {
        updateMenu()
        delegate.didChangeState(with: currentMenuState, sortOption: currentSortOption)
    }
    
}

// TODO: Протоколы убирай в отдельные файлы или наверх, чтобы они не валялись где-то не видно где

protocol FilterMenuDelegate {
    func didChangeState(with state: FilterMenu.MenuState, sortOption: FilterMenu.SortBy)
    
    func didUpdateMenu(menu: UIMenu)
    
    func didInitDefaultStates(menuState: FilterMenu.MenuState, sortOption: FilterMenu.SortBy)
}


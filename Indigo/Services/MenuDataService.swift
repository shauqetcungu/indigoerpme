//
//  MenuDataService.swift
//  Indigo
//
//  Created by Saša Vujanovic on 09/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import Foundation

struct Menu: Codable{
    let image: String
    let name: String
    
    public init(image: String, name: String) {
        self.image = image
        self.name = name
    }
    
}



class MenuDataService{
    static let instance = MenuDataService();
    
    private let menuItems = [
        Menu(image: "group63", name: "Dashbooard"),
        Menu(image: "group47", name: "Pretraga Faktura"),
        Menu(image: "group56", name: "Pretraga Ugovora"),
        Menu(image: "group57", name: "Pretraga Firmi"),
        Menu(image: "group59s", name: "Alarmi"),
        Menu(image: "settings5", name: "Podešavanja")
    ]
    
    func getMenuItems() -> [Menu] {
        return menuItems
    }
}

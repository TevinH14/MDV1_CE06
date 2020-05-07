//
//  ShoppingLisgt.swift
//  HamiltonTevin_CE06
//
//  Created by Tevin Hamilton on 9/18/19.
//  Copyright © 2019 Tevin Hamilton. All rights reserved.
//

import Foundation

class ShoppingList
{
    let store:String
    var list:[String]
    var completeList = [String]()
    
    init(store:String, list:[String])
    {
    self.store = store
    self.list = list
    }
}

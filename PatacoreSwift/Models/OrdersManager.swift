//
//  OrdersMagner.swift
//  PatacoreSwift
//
//  Created by Telematica on 3/03/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation
import UIKit

class OrdersManager {
    var table:Int
    var db:DBHelper = DBHelper ()
    private lazy var orders: [Order] = db.readOrders ()
    
    init (table: Int){
        self.table = table
    }
    
    var orderCount: Int{
          return orders.count
      }

      func getOrder(at index: Int)->Product{
          return orders[index]
      }
      
      func updateOrder(at index: Int, with order : Order ){
          
          orders[index] = order
                  
      }
  
      private func loadOrders()->[Order]{
          return db.readOrders()
      }
    
    func issetOrder (id : Int) ->Bool{
        if (db.readOrder(table: table, state: 1, product: id) != nil){
            return true
        }else{
            return false
        }
    }
      

      func addOrder(_ order: Order){
          db.insertOrder(order: order)
      }
      
    func removeOrder(id : Int){
        db.deleteOrder(table: table, state: 1, product: id)
    }
      
      
    func SQLInsertOrder(order: Order){
        db.insertOrder(order: order)
      }
      
    func findProductInOrder (orders: [Order], id: Int)->Int{
        var pos:Int = -1
        if orders.count>0{
        for i in 0...orders.count-1{
            if orders[i].id == id{
                pos = i
            }
            }
            
        }
        return pos
    }
      
    func detectChanges (table: Int)->String{
        let pastOrders = db.readOrdersByState_Table(table: table, state: 2)
        let presentOrders = db.readOrdersByState_Table(table: table, state: 1)
        var changes: String = ""
        if (presentOrders.count > 0){
        for present in presentOrders{
            let pos:Int = findProductInOrder(orders: pastOrders, id: present.id)
            if (pos > -1){
                let dif:Int = present.quantity - pastOrders[pos].quantity
                if (dif > 0){
                    changes += "Añadir \(abs(dif)) \(pastOrders[pos].name) \n"
                }else if (dif < 0 ){
                    changes += "Quitar \(abs(dif)) \(pastOrders[pos].name) \n"
                }
            }else{
                changes += "Añadir \(present.quantity) \(present.name) \n"
            }
        }
        }
        
        if (pastOrders.count>0){
        for past in pastOrders{
            let pos:Int = findProductInOrder(orders: presentOrders, id: past.id)
            if (pos == -1){
                changes += "Quitar \(abs(past.quantity)) \(past.name) \n"
            }
        }
        if (changes.count == 0){
            changes = "Sin cambios"
        }
    
        }
        return changes
    }
    
    func actOrders (){
        db.deleteOrdersByState_Table(table: self.table, state: 2)
        let presentOrders:[Order] = db.readOrdersByState_Table(table: table, state: 1)
        if (presentOrders.count>0){
        for present in presentOrders{
            present.state = 2
            db.insertOrder(order: present)
        }
        }
    }
    
    
    
    
    

}

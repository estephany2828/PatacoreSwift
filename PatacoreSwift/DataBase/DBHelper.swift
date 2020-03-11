//
//  DBHelper.swift
//  PatacoreSwift
//
//  Created by Enfasis on 2/27/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper
{
    var DBDec:DBDeclarations
    
    init()
    {
        DBDec = DBDeclarations ()
        db = openDatabase()
        createTableProduct()
        createTableOrder()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func dropTableProduct (){
        let dropTableString = DBDec.DROP_TABLE_PRODUCT
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE
            {
                print(DBDec.TABLE_PRODUCT + " table drop.")
            } else {
                print(DBDec.TABLE_PRODUCT + " table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(dropTableStatement)
    }
    
    func createTableProduct() {
        let createTableString = DBDec.CREATE_TABLE_PRODUCT
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print(DBDec.TABLE_PRODUCT + " table created.")
            } else {
                print(DBDec.TABLE_PRODUCT + " table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insertProduct(product:Product)
    {
        let products = readProducts()
        for p in products
        {
            if p.id == product.id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO  \(DBDec.TABLE_PRODUCT) ( \(DBDec.COLUMN_PRODUCT_NAME), \(DBDec.COLUMN_PRODUCT_PRICE), \(DBDec.COLUMN_PRODUCT_DESCRIPTION), \(DBDec.COLUMN_PRODUCT_IMAGE) ) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (product.name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(product.price))
            sqlite3_bind_text(insertStatement, 3, (product.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (product.imag as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readProducts() -> [Product] {
        let queryStatementString = "SELECT * FROM \(DBDec.TABLE_PRODUCT);"
        var queryStatement: OpaquePointer? = nil
        var prods : [Product] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let price = sqlite3_column_int(queryStatement, 2)
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let image = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                
                prods.append(Product(id: Int(id), name: name, price: Int(price),description:description,   imag: image))
                print("Query Result:")
                print("\(id) | \(name) | \(price) | \(image)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return prods
    }
    
    func readProduct(id: Int)->Product? {
        let queryStatementString = "SELECT * FROM \(DBDec.TABLE_PRODUCT) WHERE \(DBDec.COLUMN_PRODUCT_ID) == \(id);"
        var queryStatement: OpaquePointer? = nil
        var prod : Product
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let price = sqlite3_column_int(queryStatement, 2)
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let image = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                
                prod = Product(id: Int(id), name: name, price: Int(price),description:description, imag: image)
                
                print("Query Result:")
                print("\(id) | \(name) | \(price) | \(image)")
                sqlite3_finalize(queryStatement)
                return prod
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return nil
    }
    
    
    func deleteProductByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM \(DBDec.TABLE_PRODUCT) WHERE \(DBDec.COLUMN_PRODUCT_ID) = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func updateProduct(product: Product)
    {
        //let products = readProducts()
        //for p in products
        //{
          //  if p.id == product.id
            //{
             //   return
            //}
        //}
        
        let updateStatementString = "UPDATE \(DBDec.TABLE_PRODUCT) SET  \(DBDec.COLUMN_PRODUCT_NAME) = ?, \(DBDec.COLUMN_PRODUCT_PRICE) = ?, \(DBDec.COLUMN_PRODUCT_DESCRIPTION) = ?, \(DBDec.COLUMN_PRODUCT_IMAGE)= ? WHERE \(DBDec.COLUMN_PRODUCT_ID) = ? ";
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (product.name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(product.price))
            sqlite3_bind_text(insertStatement, 3, (product.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (product.imag as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, Int32(product.id))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully update row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("update statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    
// ------------------------- TABLE ORDER    --------------------------
    
    func createTableOrder() {
        let createTableString = DBDec.CREATE_TABLE_ORDER
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print(DBDec.TABLE_ORDER + " table created.")
            } else {
                print(DBDec.TABLE_ORDER + " table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func dropTableOrder (){
        let dropTableString = DBDec.DELETE_TABLE_ORDER
        var dropTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(dropTableStatement) == SQLITE_DONE
            {
                print(DBDec.TABLE_ORDER + " table drop.")
            } else {
                print(DBDec.TABLE_ORDER + " table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(dropTableStatement)
    }
    
    func insertOrder(order: Order)
    {
        
        let insertStatementString = "INSERT INTO  \(DBDec.TABLE_ORDER) (\(DBDec.COLUMN_ORDER_TABLE), \(DBDec.COLUMN_ORDER_PRODUCT), \(DBDec.COLUMN_ORDER_STATE), \(DBDec.COLUMN_ORDER_ANNOTATION), \(DBDec.COLUMN_ORDER_QUANTITY), \(DBDec.COLUMN_ORDER_DATE), \(DBDec.COLUMN_ORDER_HOUR) ) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(order.table))
            sqlite3_bind_int(insertStatement, 2, Int32(order.id))
            sqlite3_bind_int(insertStatement, 3, Int32(order.state))
            sqlite3_bind_text(insertStatement, 4, (order.annotation as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement,5, Int32(order.quantity))
            sqlite3_bind_text(insertStatement, 6, (order.date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (order.hour as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readOrders ()->[Order]{
        let queryStatementString = "SELECT * FROM \(DBDec.TABLE_ORDER);"
        var queryStatement: OpaquePointer? = nil
        var orders : [Order] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let table = sqlite3_column_int(queryStatement, 0)
                let id = sqlite3_column_int(queryStatement, 1)
                let product: Product
                if (readProduct(id: Int(id)) != nil){
                    product = readProduct(id: Int(id))!
                }else{
                    product = Product(name: "", price: 0, description: "", imag: "")
                }
                
                let state = sqlite3_column_int(queryStatement, 2)
                let annotation = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let quantity = sqlite3_column_int(queryStatement, 4)
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let hour = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                orders.append(Order(product: product, table: Int(table), state: Int(state), annotation: annotation, quantity: Int(quantity), date: date, hour: hour) )
                print("Query Result:")
                print("\(table) | \(id) | \(state) | \(annotation)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return orders
    }
    //todos lospedidos
    func readOrde ()->[Order] {
        let queryStatementString = "SELECT * FROM \(DBDec.TABLE_ORDER) WHERE  \(DBDec.COLUMN_ORDER_STATE) = 2;"
        var queryStatement: OpaquePointer? = nil
        var orders : [Order] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let table = sqlite3_column_int(queryStatement, 0)
                let id = sqlite3_column_int(queryStatement, 1)
                let product: Product
                if (readProduct(id: Int(id)) != nil){
                    product = readProduct(id: Int(id))!
                }else{
                    product = Product(name: "", price: 0, description: "", imag: "")
                }
                
                let state = sqlite3_column_int(queryStatement, 2)
                let annotation = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let quantity = sqlite3_column_int(queryStatement, 4)
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let hour = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                orders.append(Order(product: product, table: Int(table), state: Int(state), annotation: annotation, quantity: Int(quantity), date: date, hour: hour))
                print("Query Result orden todos los productos(ROBST):")
                print("\(table) | \(id) | \(state) | \(annotation)")
            }
        }
        return orders
    }
    
    func readOrdersByState_Table (table: Int, state: Int)->[Order] {
        let queryStatementString = "SELECT * FROM \(DBDec.TABLE_ORDER) WHERE (\(DBDec.COLUMN_ORDER_TABLE) = \(table)) AND (\(DBDec.COLUMN_ORDER_STATE) = \(state));"
        var queryStatement: OpaquePointer? = nil
        var orders : [Order] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let table = sqlite3_column_int(queryStatement, 0)
                let id = sqlite3_column_int(queryStatement, 1)
                let product: Product
                if (readProduct(id: Int(id)) != nil){
                    product = readProduct(id: Int(id))!
                }else{
                    product = Product(name: "", price: 0, description: "", imag: "")
                }
                
                let state = sqlite3_column_int(queryStatement, 2)
                let annotation = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let quantity = sqlite3_column_int(queryStatement, 4)
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let hour = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                orders.append(Order(product: product, table: Int(table), state: Int(state), annotation: annotation, quantity: Int(quantity), date: date, hour: hour))
                print("Query Result (ROBST):")
                print("\(table) | \(id) | \(state) | \(annotation)")
            }
        }
        return orders
    }
    
    func updateOrderQuantity (order: Order) {
        let queryStatementString = "UPDATE \(DBDec.TABLE_ORDER) SET \(DBDec.COLUMN_ORDER_QUANTITY) = \(order.quantity) WHERE (\(DBDec.COLUMN_ORDER_TABLE) = \(order.table)) AND (\(DBDec.COLUMN_ORDER_STATE) = \(order.state)) AND (\(DBDec.COLUMN_ORDER_PRODUCT) = \(order.id));"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            }
        } else {
           print("Could not updated row.")
        }
        sqlite3_finalize(updateStatement)
    }
    
    func updateOrderAnnotation (order: Order) {
        let queryStatementString = "UPDATE \(DBDec.TABLE_ORDER) SET \(DBDec.COLUMN_ORDER_ANNOTATION) = \'\(order.annotation)\' WHERE (\(DBDec.COLUMN_ORDER_TABLE) = \(order.table)) AND (\(DBDec.COLUMN_ORDER_STATE) = \(order.state)) AND (\(DBDec.COLUMN_ORDER_PRODUCT) = \(order.id));"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            }
        } else {
           print("Could not updated row.")
        }
        sqlite3_finalize(updateStatement)
    }
    
    
    
    func readOrder (table: Int, state: Int, product: Int)->Order? {
        let queryStatementString = "SELECT * FROM \(DBDec.TABLE_ORDER) WHERE (\(DBDec.COLUMN_ORDER_TABLE) = \(table)) AND (\(DBDec.COLUMN_ORDER_STATE) = \(state)) AND (\(DBDec.COLUMN_ORDER_PRODUCT) = \(product));"
        var queryStatement: OpaquePointer? = nil
        var order : Order
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let table = sqlite3_column_int(queryStatement, 0)
                let id = sqlite3_column_int(queryStatement, 1)
                let product: Product
                if (readProduct(id: Int(id)) != nil){
                    product = readProduct(id: Int(id))!
                }else{
                    product = Product(name: "", price: 0, description: "", imag: "")
                }
                
                let state = sqlite3_column_int(queryStatement, 2)
                let annotation = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let quantity = sqlite3_column_int(queryStatement, 4)
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let hour = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                order = Order(product: product, table: Int(table), state: Int(state), annotation: annotation, quantity: Int(quantity), date: date, hour: hour)
                print("Query Result:")
                print("\(table) | \(id) | \(state) | \(annotation)")
                return order
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return nil
    }
    
    func deleteOrdersByState_Table(table: Int, state: Int) {
        let deleteStatementStirng = "DELETE FROM \(DBDec.TABLE_ORDER) WHERE (\(DBDec.COLUMN_ORDER_TABLE) = \(table)) AND (\(DBDec.COLUMN_ORDER_STATE) = \(state));"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            while sqlite3_step(deleteStatement) == SQLITE_ROW {
                print (deleteStatementStirng)
                print("Successfully deleted row.")
            }
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func deleteOrder(table: Int, state: Int, product: Int) {
        let deleteStatementStirng = "DELETE FROM \(DBDec.TABLE_ORDER) WHERE (\(DBDec.COLUMN_ORDER_TABLE) = \(table)) AND (\(DBDec.COLUMN_ORDER_STATE) = \(state)) AND (\(DBDec.COLUMN_ORDER_PRODUCT) = \(product));"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            //sqlite3_bind_int(deleteStatement, 1, Int32(table))
            //sqlite3_bind_int(deleteStatement, 2, Int32(state))
            //sqlite3_bind_int(deleteStatement, 2, Int32(product))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print (deleteStatementStirng)
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}

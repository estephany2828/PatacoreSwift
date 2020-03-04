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
    
    func readProduct (id: Int)->Product? {
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
        let orders = readOrders()
        for o in orders
        {
            if o.name == order.name
            {
                return
            }
        }
        
        let insertStatementString = "INSERT INTO  \(DBDec.TABLE_PRODUCT) ( \(DBDec.COLUMN_ORDER_TABLE), \(DBDec.COLUMN_ORDER_PRODUCT), \(DBDec.COLUMN_ORDER_STATE), \(DBDec.COLUMN_ORDER_ANNOTATION), \(DBDec.COLUMN_ORDER_QUANTITY), \(DBDec.COLUMN_ORDER_DATE), \(DBDec.COLUMN_ORDER_HOUR) ) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(order.table))
            sqlite3_bind_text(insertStatement, 2, (order.name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(order.state))
            sqlite3_bind_text(insertStatement, 4, (order.annotation as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(order.quantity))
            sqlite3_bind_text(insertStatement, 4, (order.date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (order.hour as NSString).utf8String, -1, nil)
            
            
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
    
    func deleteOrder(table: Int, state: Int, product: String) {
        let deleteStatementStirng = "DELETE FROM \(DBDec.TABLE_ORDER) WHERE \(DBDec.COLUMN_ORDER_TABLE) = ? AND \(DBDec.COLUMN_ORDER_STATE) = ? AND \(DBDec.COLUMN_ORDER_PRODUCT) = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(table))
            sqlite3_bind_int(deleteStatement, 2, Int32(state))
            sqlite3_bind_text(deleteStatement, 3, (product as NSString).utf8String, -1, nil)
            
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
    
}

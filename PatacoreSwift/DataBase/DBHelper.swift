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
    
    func insertOrder(id:Int, name:String, price:Int, image:String)
    {
        let products = readProducts()
        for p in products
        {
            if p.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO  \(DBDec.TABLE_PRODUCT) ( \(DBDec.COLUMN_PRODUCT_ID), \(DBDec.COLUMN_PRODUCT_NAME), \(DBDec.COLUMN_PRODUCT_PRICE), \(DBDec.COLUMN_PRODUCT_IMAGE) ) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(price))
            sqlite3_bind_text(insertStatement, 4, (image as NSString).utf8String, -1, nil)
            
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
    
    
}

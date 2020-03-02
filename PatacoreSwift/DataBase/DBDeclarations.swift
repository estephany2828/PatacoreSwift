//
//  DBDeclarations.swift
//  PatacoreSwift
//
//  Created by Enfasis on 2/27/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation


struct DBDeclarations{
    var TABLE_PRODUCT: String
    var COLUMN_PRODUCT_ID: String
    var COLUMN_PRODUCT_NAME: String
    var COLUMN_PRODUCT_PRICE: String
    var COLUMN_PRODUCT_IMAGE: String
    var COLUMN_PRODUCT_DESCRIPTION: String
    var CREATE_TABLE_PRODUCT:String
    var DELETE_TABLE_PRODUCT:String
    var DROP_TABLE_PRODUCT:String
    
    var TABLE_ORDER: String
    var COLUMN_ORDER_PRODUCT:String
    var COLUMN_ORDER_ANNOTATION:String
    var COLUMN_ORDER_QUANTITY:String
    var COLUMN_ORDER_TABLE:String
    var COLUMN_ORDER_DATE:String
    var COLUMN_ORDER_HOUR:String
    var COLUMN_ORDER_STATE:String
    var CREATE_TABLE_ORDER:String
    var DELETE_TABLE_ORDER:String
    
    
    init (){
        TABLE_PRODUCT = "product"
        COLUMN_PRODUCT_ID = "id_food"
        COLUMN_PRODUCT_NAME = "name"
        COLUMN_PRODUCT_PRICE = "price"
        COLUMN_PRODUCT_IMAGE = "image"
        COLUMN_PRODUCT_DESCRIPTION = "description"
        
        CREATE_TABLE_PRODUCT = "CREATE TABLE IF NOT EXISTS " + TABLE_PRODUCT +
        "(\(COLUMN_PRODUCT_ID) INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_PRODUCT_NAME) VARCHAR, \(COLUMN_PRODUCT_PRICE) INTEGER, \(COLUMN_PRODUCT_DESCRIPTION) VARCHAR), \(COLUMN_PRODUCT_IMAGE) VARCHAR;"
        
        DELETE_TABLE_PRODUCT = "DROP TABLE IF EXISTS " + TABLE_PRODUCT
        
        DROP_TABLE_PRODUCT = "DROP TABLE IF EXISTS " + TABLE_PRODUCT
        
        TABLE_ORDER = "pedido"
        COLUMN_ORDER_PRODUCT = "product"
       
        COLUMN_ORDER_TABLE = "table"
        COLUMN_ORDER_STATE = "state"
        COLUMN_ORDER_ANNOTATION = "annotation"
        COLUMN_ORDER_QUANTITY = "quantity"
        COLUMN_ORDER_DATE = "date"
        COLUMN_ORDER_HOUR = "hour"
        
        
        CREATE_TABLE_ORDER = "CREATE TABLE IF NOT EXISTS \(TABLE_ORDER) ( \(COLUMN_ORDER_TABLE) INTEGER, \(COLUMN_ORDER_PRODUCT) TEXT,  \(COLUMN_ORDER_ANNOTATION) TEXT, \(COLUMN_ORDER_QUANTITY) INTEGER, \(COLUMN_ORDER_DATE) TEXT, \(COLUMN_ORDER_HOUR) TEXT)"
        
        DELETE_TABLE_ORDER = "DROP TABLE IF EXITS " + TABLE_ORDER
        
    }
    
}

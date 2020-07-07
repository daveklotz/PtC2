//
//  IAPManager.swift
//  iOS
//
//  Created by David Klotz on 7/6/20.
//

import Foundation
import StoreKit
import Combine

class IAPManager: NSObject {
  static let shared = IAPManager()
    private override init() {
        super.init()
    }
    
    func returnProductIDs() -> Set<String> {
        let productSet:Set<String> = ["com.mobileotis.punchclown.testclown1"]
        return productSet
    }
    
    func getProductsV5() {
        let productIDs = returnProductIDs()
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }

}


extension IAPManager: SKProductsRequestDelegate, SKRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let badProducts = response.invalidProductIdentifiers
        let goodProducts = response.products
        if goodProducts.count > 0 {
            productsDB.shared.items = response.products
            print("bon ",productsDB.shared.items)
        }
        print("badProducts ",badProducts)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
      print("didFailWithError ",error)
      //purchasePublisher.send(("Purchase request failed ",true))
    }
    
    func requestDidFinish(_ request: SKRequest) {
      print("request did finish")
    }
    
    func getPriceFormatted(for product: SKProduct) -> String? {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.locale = product.priceLocale
      return formatter.string(from: product.price)
    }


}


final class productsDB: ObservableObject, Identifiable {
  static let shared = productsDB()
  var items:[SKProduct] = []
  {
    willSet {
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
  }
}

//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
	func didUpdateBitcoinPrice(_ coinManager: CoinManager, coin: CoinModel)
	func didFailedWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
	
	//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKey=345AD12B-F1CF-4C56-9DBB-64D2873FA52E
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "345AD12B-F1CF-4C56-9DBB-64D2873FA52E"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
	
	var delegate: CoinManagerDelegate?
	

	func getCoinPrice(for currency: String) {
		DispatchQueue.global(qos: .userInitiated).async {
			let urlString = "\(self.baseURL)/\(currency)?apiKey=\(self.apiKey)"
			self.performRequest(with: urlString)
		}
	}
	
	func performRequest(with urlString: String) {
		if let url = URL(string: urlString) {
			let urlSession = URLSession.init(configuration: .default)
			let task = urlSession.dataTask(with: url) { data, response, error in
				if let error = error {
					print(error)
					self.delegate?.didFailedWithError(self, error: error)
					return
				}
				if let data = data {
					if let string = String(data: data, encoding: .utf8) {
						print(string)
					}
					if let coin = self.parseJSON(data) {
						print("One bitcoin is worth \(coin.bitcoin) \(coin.name)")
						self.delegate?.didUpdateBitcoinPrice(self, coin: coin)
					}
				}
			}
			task.resume()
		}
	}
	
	func parseJSON(_ coinData: Data) -> CoinModel? {
		let decoder = JSONDecoder()
		do {
			let decodedData = try decoder.decode(CoinData.self, from: coinData)
			let rate = decodedData.rate
			let name = decodedData.asset_id_quote
			print(rate, name)

			return CoinModel(name: name, bitcoin: rate)
		} catch {
//			self.delegate?.didFailedWithError(self, error: error)
			return nil
		}
	}
    
}

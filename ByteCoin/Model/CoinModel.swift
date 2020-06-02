//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Arthur Duver on 02/06/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
	let name: String
	let bitcoin: Double
	
	var stringBitcoin: String {
		return String(format: "%.2f",bitcoin)
	}
}

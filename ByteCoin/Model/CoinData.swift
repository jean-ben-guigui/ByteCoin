//
//  CoinData.swift
//  ByteCoin
//
//  Created by Arthur Duver on 02/06/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
	let asset_id_quote: String
	let rate: Double
}

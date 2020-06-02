//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var bitcoinLabel: UILabel!
	@IBOutlet weak var currencyLabel: UILabel!
	@IBOutlet weak var currencyPicker: UIPickerView!
	
	var coinManager = CoinManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		currencyPicker.dataSource = self
		currencyPicker.delegate = self
		coinManager.delegate = self
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return coinManager.currencyArray.count
	}
	
	
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		coinManager.currencyArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		coinManager.getCoinPrice(for: coinManager.currencyArray[row])
	}
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
	func didUpdateBitcoinPrice(_ coinManager: CoinManager, coin: CoinModel) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else {
				return
			}
			self.bitcoinLabel.text = coin.stringBitcoin
			self.currencyLabel.text = coin.name
		}
	}
	
	func didFailedWithError(_ coinManager: CoinManager, error: Error) {
		print("error \(error)")
	}
	
	
}

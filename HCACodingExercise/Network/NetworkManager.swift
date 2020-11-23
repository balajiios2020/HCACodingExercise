//
//  NetworkManager.swift
//  HCACodingExercise
//
//  Created by Balaji Peddaiahgari on 11/22/20.
//  Copyright © 2020 Balaji Peddaiahgari. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
	static let shared = NetworkManager()

	private init() {}

	func fetchQuestions(completionHandler:  @escaping (Result<[Question], Error>) -> Void) {
		let urlString = Constants.api + Constants.apiKey
		let request = AF.request(urlString)
		request.responseData { response in
			switch response.result {
			case .success(let data):
				let decoder = JSONDecoder()
				do {
					let items = try decoder.decode(Items.self, from: data)
					completionHandler(.success(items.items))
				} catch(let error) {
					completionHandler(.failure(error))
				}
			case .failure(let error):
				completionHandler(.failure(error))
			}
		}
	}
}

//
//  NetworkManager.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import Foundation

enum ErrorType: String, Error {
    case internetConnection = "Please Check Your Internet Connection!"
    case decodeError = "Something went wrong!"
    case dataError = "Data cannot found!"
}

final class NetworkManager {

    static let shared = NetworkManager()

    public var baseUrl: String = "https://dummy-api-jtg6bessta-ey.a.run.app/"
    public var responseCode: Int = 0

    func sendRequest<T: Codable>(request: RequestModel,
                                 header: [String: String]? = nil,
                                 httpMethod: RequestHTTPMethod? = nil,
                                 type: T.Type,
                                 completion: @escaping(Swift.Result<T, ErrorType>) -> Void) {

        Task {
            let internetConnected = await ConnectionService.isConnected()
            //This line won't run until the result is available
            if internetConnected {
                URLSession.shared.dataTask(with: request.urlRequest(header: header,
                                                                    httpMethod: httpMethod)) { data, response, error in
                    guard let data = data else {
                        print("\n*** URL SESSION data could not be received\n")
                        completion(.failure(.dataError))
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse {
                        self.responseCode = httpResponse.statusCode
                        print("response code: \(self.responseCode)")
                    }

                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                }.resume()
            } else {
                completion(.failure(.internetConnection))
            }
        }
    }
}

//
//  NetworkService.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 14.04.2023.
//

import Foundation


class NetworkService {
    
    func fetchData(offset: Int) async -> Result<[Item], NetworkError> {
        guard let url = URL(string: "http://dev.bonusmoney.pro/mobileapp/getAllCompanies") else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("123", forHTTPHeaderField: "TOKEN")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = ["offset": offset]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonData
        } catch {
            return .failure(.encodingError)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return .failure(.emptyResponse) }
            
            switch httpResponse.statusCode {
            case 200:
                let result = try JSONDecoder().decode([Item].self, from: data)
                return .success(result)
            case 400:
                return .failure(.invalidRequest)
            case 401:
                return .failure(.unauthorized)
            case 500:
                return .failure(.serverError)
            default:
                return .failure(.emptyResponse)
            }
        } catch {
            print(error.localizedDescription)
            return .failure(.emptyResponse)
        }
    }
}

enum NetworkError:String, Error, Identifiable {
    case encodingError
    case invalidURL = "Неверный URL"
    case emptyResponse
    case serverError = "Все упало"
    case unauthorized = "Ошибка авторизации"
    case invalidRequest  = "Bad request"
    
    var id: NetworkError {
          self
      }
    
}

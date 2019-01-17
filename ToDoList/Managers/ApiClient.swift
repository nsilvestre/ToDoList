//
//  ApiClient.swift
//  ToDoList
//
//  Created by Luis Eduardo Talavera Rios on 1/16/19.
//  Copyright © 2019 Luis Eduardo Talavera Rios. All rights reserved.
//

import os
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ApiClient {
    static let shared = ApiClient()
    
    fileprivate let baseUrl: String = "http://169.254.51.163:3000/api/v1"
    
    func fetchTasks(completion: @escaping (_ result: ApiResult<[TaskDto]>) -> Void) {
        let url = "\(baseUrl)/tasks"
        
        Alamofire.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseArray { (response: DataResponse<[TaskDto]>) in
                switch response.result {
                    case .success:
                        if let items = response.result.value {
                            completion(ApiResult.success(result: items))
                        } else {
                            completion(ApiResult.failure(error: .parsingError))
                        }
                        break
                    case .failure(let error):
                        completion(ApiResult.failure(error: self.apiError(from: error)))
                        break
                }
            }
    }
    
    func addTask(taskDto: TaskDto, completion: @escaping (_ result: ApiResult<Void>) -> Void) {
        let url = "\(baseUrl)/tasks"
        
        var parameters = [String:String]()
        parameters["title"] = taskDto.title
        parameters["detail"] = taskDto.detail
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .response { response in
                let error = response.error
                if error == nil {
                    completion(ApiResult.success(result: ()))
                } else {
                    completion(ApiResult.failure(error: self.apiError(from: error)))
                }
        }
    }
    
    func updateTask(taskDto: TaskDto, completion: @escaping (_ result: ApiResult<Void>) -> Void) {
        let url = "\(baseUrl)/tasks/\(taskDto.id!)"
        
        var parameters = [String:String]()
        parameters["title"] = taskDto.title
        parameters["detail"] = taskDto.detail
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                let error = response.error
                if error == nil {
                    completion(ApiResult.success(result: ()))
                } else {
                    completion(ApiResult.failure(error: self.apiError(from: error)))
                }
        }
    }
    
    func deleteTask(id: Int32, completion: @escaping (_ result: ApiResult<Void>) -> Void) {
        let url = "\(baseUrl)/tasks/\(id)"
        
        Alamofire.request(url, method: .delete)
            .validate(statusCode: 200..<300)
            .response { response in
                let error = response.error
                if error == nil {
                    completion(ApiResult.success(result: ()))
                } else {
                    completion(ApiResult.failure(error: self.apiError(from: error)))
                }
            }
    }
    
    private func apiError(from error: Error?) -> ApiError {
        if let error = error as? ApiError {
            return error
        } else if let error = error as? URLError, error.code == .notConnectedToInternet {
            return .noInternetConnection
        } else if let error = error as? AFError, let responseCode = error.responseCode {
            switch responseCode {
            case 400, 404, 500..<600:
                return .internalServerError
            default:
                return .serverUnreachable
            }
        } else {
            return .internalServerError
        }
    }
}

enum ApiResult<U> {
    case success(result: U)
    case failure(error: ApiError)
}

public enum ApiError: Error {
    case internalServerError
    case serverUnreachable
    case noInternetConnection
    case parsingError
    
    func userMessage() -> String {
        switch self {
        case .internalServerError:
            return "El servidor respondió de forma inesperada. Por favor intente nuevamente más tarde"
        case .serverUnreachable:
            return "El servidor esta tomando mucho tiempo en responder. Por favor intente nuevamente más tarde"
        case .noInternetConnection:
            return "Su conexión a internet no se encuentra activa y es necesaria para procesar su orden"
        case .parsingError:
            return "Hubo un problema al procesar la respuesta"
        }
    }
}

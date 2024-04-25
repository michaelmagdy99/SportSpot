//
//  Network.swift
//  SportSpot
//
//  Created by Michael Magdy on 22/04/2024.
//
import Foundation
import Alamofire

class Network {
    
    let API_KEY = "31d6e2944895bbe12498bb819026f4ecd80edf3aac244c5309602110338e61a1"
    
    static let shared : Network = Network()

    private init() {
        
    }
    
    
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void) {
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=Leagues&APIkey=\(API_KEY)")
        AF.request(url!).validate().response{
            respon in
            switch respon.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(LeagueResponse.self, from: data!)
                    print(jsonData.result?[0].country_name ?? "")
                    completion(.success(jsonData))
                  
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))

                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))

            }
            
        }
    }

    
    func fetchFixtures(sportType: String, from fromDate: Date?, to toDate: Date?, completion: @escaping(Result<FixturesResponse, Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let formattedFromDate = dateFormatter.string(from: fromDate ?? currentDate)
        let formattedToDate = dateFormatter.string(from: toDate ?? currentDate)
        
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&APIkey=\(API_KEY)&from=\(formattedFromDate)&to=\(formattedToDate)")
        
        AF.request(url!).validate().response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(FixturesResponse.self, from: data!)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }



}

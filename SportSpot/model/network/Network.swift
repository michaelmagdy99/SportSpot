//
//  Network.swift
//  SportSpot
//
//  Created by Michael Magdy on 22/04/2024.
//
import Foundation
import Alamofire


class Network : NetworkProtocol {
    
    let API_KEY = "31d6e2944895bbe12498bb819026f4ecd80edf3aac244c5309602110338e61a1"
    
    static let shared : Network = Network()

    private init() {
        
    }
    
    
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void) {
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=Leagues&APIkey=\(API_KEY)")
        AF.request(url!).validate().response{
            response in
            switch response.result{
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

    
    func fetchFixtures(sportType:String,from dateFrom:Date?,completion: @escaping(Result<FixturesResponse,Error>) -> Void) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = Date()
            
            let formattedDate = dateFormatter.string(from: currentDate)
            let fromDate = dateFormatter.string(from: dateFrom ?? currentDate)
            let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&APIkey=\(API_KEY)&from=\(fromDate)&to=\(formattedDate)")
            
        AF.request(url!).validate().response{
                response in
                switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(FixturesResponse.self, from: data!)
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


}

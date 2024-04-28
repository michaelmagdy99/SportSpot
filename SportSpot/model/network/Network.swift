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
    
    
    func fetchFixtures(sportType: String, leagueId : Int, completion: @escaping(Result<FixturesResponse, Error>) -> Void) {
        
        
        let nowDate = Date()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dataFormatter.string(from: nowDate)
        
        let calender = Calendar.current
        let dateComponents = DateComponents(day : -3)
        guard let threeDaysAgo = calender.date(byAdding: dateComponents, to: nowDate) else { return  }
        let threeDaysAgoString = dataFormatter.string(from: threeDaysAgo)
        print(" network id \(leagueId)")
        
        //  let url =  "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&APIkey=\(API_KEY)&from=\(threeDaysAgoString)&to=\(currentDateString)&leagueId=\(leagueId)"
        
        let url =  "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&APIkey=\(API_KEY)&from=2024-04-16&to=2024-04-30&leagueId=\(leagueId)"
        
        
        
        
        AF.request(url).validate().response { response in
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
    
    
    func fetchTeams(sportType: String, leagueId : Int, completion: @escaping(Result<TeamsResponse, Error>) -> Void){
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?&met=Teams&leagueId=\(leagueId)&APIkey=\(API_KEY)")
        
        AF.request(url!).validate().response{
            respon in
            switch respon.result{
            case .success(let data):
                do{
                    let jsonData = try JSONDecoder().decode(TeamsResponse.self, from: data!)
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
    
    
    /*
     func fetchTeamDetails(sportType:String ,teamId: Int, completion: @escaping (Result<TeamDetailsResponse, Error>) -> Void) {
     let url = URL(string: "https://apiv2.allsportsapi.com/\(sportType)/?&met=Teams&teamId=\(teamId)&APIkey=\(API_KEY)")
     
     AF.request(url!).validate().response{
     respon in
     switch respon.result{
     case .success(let data):
     do{
     let jsonData = try JSONDecoder().decode(TeamDetailsResponse.self, from: data!)
     completion(.success(jsonData))
     
     } catch {
     print(error.localizedDescription)
     completion(.failure(error))
     
     }
     case .failure(let error):
     print(error)
     completion(.failure(error))
     
     }
     
     }
     }
     
     */
    
    
}




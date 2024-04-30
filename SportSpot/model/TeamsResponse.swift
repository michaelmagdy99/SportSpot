
import Foundation

struct TeamsResponse: Codable {
    let success: Int?
    let result: [TeamsModel]?
}

struct TeamsModel: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    let coaches: [Coach]?
}
    
    
struct Coach: Codable {
    let coach_name: String
}

struct Player: Codable {
    let player_key: Int?
    let player_image: String?
    let player_name: String?
    let player_number: String?
    let player_type: String?
}



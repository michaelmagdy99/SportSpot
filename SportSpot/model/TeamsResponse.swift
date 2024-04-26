//MARK: - Teams
struct TeamsResponse: Codable {
    let success: Int?
    let result: [TeamsModel]?
}

// MARK: - Team
struct TeamsModel: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?


    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}

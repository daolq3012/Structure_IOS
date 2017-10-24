//
//  User.swift
//  Structure_IOS
//
//  Created by DaoLQ on 10/22/17.
//  Copyright © 2017 DaoLQ. All rights reserved.
//

import Foundation
import ObjectMapper

class User: BaseModel {

    var id: Int?
    var login: String?
    var avatarUrl: String?
    var gravatarId: String?
    var url: String?
    var htmlUrl: String?
    var followersUrl: String?
    var followingUrl: String?
    var gistsUrl: String?
    var starredUrl: String?
    var subscriptionsUrl: String?
    var organizationsUrl: String?
    var reposUrl: String?
    var eventsUrl: String?
    var receivedEventsUrl: String?
    var type: String?
    var siteAdmin: Bool?
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: String?
    var bio: String?
    var publicRepos: Int?
    var publicGists: Int?
    var followers: Int?
    var following: Int?
    var createdAt: String?
    var updatedAt: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
        avatarUrl <- map["avatar_url"]
        gravatarId <- map["gravatar_id"]
        url <- map["url"]
        htmlUrl <- map["html_url"]
        followersUrl <- map["followers_url"]
        followingUrl <- map["following_url"]
        gistsUrl <- map["gists_url"]
        starredUrl <- map["starred_url"]
        subscriptionsUrl <- map["subscriptions_url"]
        organizationsUrl <- map["organizations_url"]
        reposUrl <- map["repos_url"]
        eventsUrl <- map["events_url"]
        receivedEventsUrl <- map["received_events_url"]
        type <- map["type"]
        siteAdmin <- map["site_admin"]
        name <- map["name"]
        company <- map["company"]
        blog <- map["blog"]
        location <- map["location"]
        email <- map["email"]
        hireable <- map["hireable"]
        bio <- map["bio"]
        publicRepos <- map["public_repos"]
        publicGists <- map["public_gists"]
        followers <- map["followers"]
        following <- map["following"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}

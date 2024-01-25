//
//  DataTest.swift
//  myMangas
//
//  Created by epena on 2/1/24.
//

import Foundation

extension Manga {
    static let testMonter = Manga(id: 1,
                            titleJapanese: "MONSTER",
                            authors: [Author(id: "54BE174C-2FE9-42C8-A842-85D291A6AEDD", Name: "Urasawa Naoki")],
                            themes: ["Psychological",
                                     "Adult Cast"],
                            title: "Monster",
                            endDate: "1994-04-25T00:00:00Z",
                            score: 9.15,
                            status: "finished",
                                  demographics: [.seinen],
                                  genres: ["awardWinning", "drama", "mystery"],
                            startDate: "1994-04-25T00:00:00Z",
                            titleEnglish: "Monster",
                            chapters: 162,
                            sypnosis: "Kenzou Tenma, a renowned Japanese neurosurgeon working in post-war Germany, faces a difficult choice: to operate on Johan Liebert, an orphan boy on the verge of death, or on the mayor of Düsseldorf. In the end, Tenma decides to gamble his reputation by saving Johan, effectively leaving the mayor for dead.\n\nAs a consequence of his actions, hospital director Heinemann strips Tenma of his position, and Heinemann's daughter Eva breaks off their engagement. Disgraced and shunned by his colleagues, Tenma loses all hope of a successful career—that is, until the mysterious killing of Heinemann gives him another chance.\n\nNine years later, Tenma is the head of the surgical department and close to becoming the director himself. Although all seems well for him at first, he soon becomes entangled in a chain of gruesome murders that have taken place throughout Germany. The culprit is a monster—the same one that Tenma saved on that fateful day nine years ago.\n\n[Written by MAL Rewrite]",
                            background: "Monster won the Grand Prize at the 3rd annual Tezuka Osamu Cultural Prize in 1999, as well as the 46th Shogakukan Manga Award in the General category in 2000. The series was published in English by VIZ Media under the VIZ Signature imprint from February 21, 2006 to December 16, 2008, and again in 2-in-1 omnibuses (subtitled The Perfect Edition) from July 15, 2014 to July 19, 2016. The manga was also published in Brazilian Portuguese by Panini Comics/Planet Manga from June 2012 to April 2015, in Polish by Hanami from March 2014 to February 2017, in Spain by Planeta Cómic from June 16, 2009 to September 21, 2010, and in Argentina by LARP Editores.",
                            url: "https://myanimelist.net/manga/1/Monster",
                            mainPicture: URL(string: "https://cdn.myanimelist.net/images/manga/3/258224l.jpg"),
                            volumes: 18)
    
    static let testBerserk = Manga(id: 2,
                            titleJapanese: "ベルセルク",
                            authors: [Author(id: "4394C98F-615B-494A-929E-123A342A95B8", Name: "Kentarou Miura"),
                                      Author(id: "4394C89F-615B-494A-929E-321A342A95B8", Name: "Studio Gaga")],
                            themes: ["Gore", "Military"],
                            title: "Berserk",
                            endDate: nil,
                            score: 9.15,
                            status: "currently_publishing",
                            demographics: [.seinen],
                            genres: ["action",
                                     "adventure",
                                     "awardWinning"],
                            startDate: "1994-04-25T00:00:00Z",
                            titleEnglish: "Monster",
                            chapters: nil,
                            sypnosis: "Guts, a former mercenary now known as the \"Black Swordsman,\" is out for revenge. After a tumultuous childhood, he finally finds someone he respects and believes he can trust, only to have everything fall apart when this person takes away everything important to Guts for the purpose of fulfilling his own desires. Now marked for death, Guts becomes condemned to a fate in which he is relentlessly pursued by demonic beings.\n\nSetting out on a dreadful quest riddled with misfortune, Guts, armed with a massive sword and monstrous strength, will let nothing stop him, not even death itself, until he is finally able to take the head of the one who stripped him—and his loved one—of their humanity.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 14: Berserk: The Prototype Guts, a former mercenary now known as the \"Black Swordsman,\" is out for revenge. After a tumultuous childhood, he finally finds someone he respects and believes he can trust, only to have everything fall apart when this person takes away everything important to Guts for the purpose of fulfilling his own desires. Now marked for death, Guts becomes condemned to a fate in which he is relentlessly pursued by demonic beings.\n\nSetting out on a dreadful quest riddled with misfortune, Guts, armed with a massive sword and monstrous strength, will let nothing stop him, not even death itself, until he is finally able to take the head of the one who stripped him—and his loved one—of their humanity.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 14: Berserk: The Prototype Guts, a former mercenary now known as the \"Black Swordsman,\" is out for revenge. After a tumultuous childhood, he finally finds someone he respects and believes he can trust, only to have everything fall apart when this person takes away everything important to Guts for the purpose of fulfilling his own desires. Now marked for death, Guts becomes condemned to a fate in which he is relentlessly pursued by demonic beings.\n\nSetting out on a dreadful quest riddled with misfortune, Guts, armed with a massive sword and monstrous strength, will let nothing stop him, not even death itself, until he is finally able to take the head of the one who stripped him—and his loved one—of their humanity.\n\n[Written by MAL Rewrite]\n\nIncluded one-shot:\nVolume 14: Berserk: The Prototype",
                            background: "Berserk won the Award for Excellence at the sixth installment of Tezuka Osamu Cultural Prize in 2002. The series has over 50 million copies in print worldwide and has been published in English by Dark Horse since November 4, 2003. It is also published in Italy, Germany, Spain, France, Brazil, South Korea, Hong Kong, Taiwan, Thailand, Poland, México and Turkey. In May 2021, the author Kentaro Miura suddenly died at the age of 54. Chapter 364 of Berserk was published posthumously on September 10, 2021. Miura would often share details about the series' story with his childhood friend and fellow mangaka Kouji Mori. Berserk resumed on June 24, 2022, with Studio Gaga handling the art and Kouji Mori's supervision.",
                            url: "https://myanimelist.net/manga/2/Berserk",
                            mainPicture: URL(string: "https://cdn.myanimelist.net/images/manga/1/157897l.jpg"),
                            volumes: 14)
}

extension MangaListViewModel {
    static let test = MangaListViewModel(network: DataTest())
}

extension AccountViewModel {
    static let test = AccountViewModel(network: DataTest())
}

extension MangaEditViewModel {
    static let test = MangaEditViewModel(manga: .testBerserk)
}

extension MyListViewModel {
    static let test = MyListViewModel()
}

struct DataTest: DataInteractor {
    let url = Bundle.main.url(forResource: "testMangas", withExtension: "json")!
    let urlBest = Bundle.main.url(forResource: "testBestMangas", withExtension: "json")!
    
    func getMangas(page: Int) async throws -> [Manga] {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(MangasDTO.self, from: data).items?.map(\.toPresentation) ?? []
    }
    
    func getManga(id: Int) async throws -> Manga {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(MangasDTO.self, from: data).items!.map(\.toPresentation).first!
    }
    
    func getBestMangas() async throws -> [Manga] {
        let data = try Data(contentsOf: urlBest)
        return try JSONDecoder().decode(MangasDTO.self, from: data).items?.map(\.toPresentation) ?? []
    }
    
    func getGenres() async throws -> [String] {
        return ["Action", "Adventure"]
    }
    
    func getThemes() async throws -> [String] {
        return ["Gore", "Military"]
    }
    
    func searchMangas(page: Int, bodyItems: CustomSearch) async throws -> [Manga] {
        let data = try Data(contentsOf: urlBest)
        return try JSONDecoder().decode(MangasDTO.self, from: data).items?.map(\.toPresentation) ?? []
    }
    
    func register(credentials: UserCredentials) async throws { }
    
    mutating func login(credentials: UserCredentials) async throws { }
    
    mutating func renew() async throws { }
    
    mutating func logout() { }
    
    mutating func isLogin() -> Bool {
        true
    }
    
    mutating func getCollection() async throws -> [Manga] {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(MangasDTO.self, from: data).items?.map(\.toPresentation) ?? []
    }
}

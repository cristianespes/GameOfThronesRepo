//
//  Repository.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 12/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    
    func house(named: String) -> House?
    func houses(filteredBy: Filter) -> [House]
}

protocol SeasonFactory {
    typealias FilterBySeason = (Season) -> Bool
    
    var seasons: [Season] { get }
    
    func seasons(filteredBy: FilterBySeason) -> [Season]
}

final class LocalFactory: HouseFactory {
    
    var houses : [House] {
        
        // Houses creation here
        let starkSigil = Sigil(description: "Lobo Huargo", image: UIImage(named: "codeIsComing")!)
        let lannisterSigil = Sigil(description: "Leon Rampante", image: UIImage(named: "lannister.jpg")!)
        let targaryenSigil = Sigil(description: "Dragon Tricefalo", image: UIImage(named: "targaryenSmall.jpg")!)
        
        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: targaryenUrl)
        
        // Characters creation
        let robb = Person(name: "Robb", alias: "El joven lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matareyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(persons: dani)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        //return houses.filter { $0.name.lowercased() == name.lowercased() }.first
        //return houses.first(where: { $0.name.lowercased() == name.lowercased() })
        return houses.first{ $0.name.lowercased() == name.lowercased() }
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
}


extension LocalFactory: SeasonFactory {
    
    var seasons: [Season] {
        
        // Season creation here
        var dateString = "04/17/2011"
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "MM/dd/yyyy"
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        var dateFromString = dateStringFormatter.date(from: dateString)
        let date1s1 = dateFromString!
        
        let season1 = Season(number: 1, releaseDate: date1s1, image: UIImage(named: "GoT_Season_1")!)
        
        
        dateString = "04/01/2012"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date1s2 = dateFromString!
        
        let season2 = Season(number: 2, releaseDate: date1s2, image: UIImage(named: "GoT_Season_2")!)
        
        
        dateString = "03/31/2013"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date1s3 = dateFromString!
        
        let season3 = Season(number: 3, releaseDate: date1s3, image: UIImage(named: "GoT_Season_3")!)
        
        
        dateString = "04/06/2014"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date1s4 = dateFromString!
        
        let season4 = Season(number: 4, releaseDate: date1s4, image: UIImage(named: "GoT_Season_4")!)
        
        
        dateString = "04/12/2015"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date1s5 = dateFromString!
        
        let season5 = Season(number: 5, releaseDate: date1s5, image: UIImage(named: "GoT_Season_5")!)
        
        
        dateString = "04/24/2016"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date1s6 = dateFromString!
        
        let season6 = Season(number: 6, releaseDate: date1s6, image: UIImage(named: "GoT_Season_6")!)
        
        
        dateString = "07/16/2016"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date1s7 = dateFromString!
        
        let season7 = Season(number: 7, releaseDate: date1s7, image: UIImage(named: "GoT_Season_7")!)
        
        
        // Episodes creation here
        dateString = "04/24/2011"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s1 = dateFromString!
        
        dateString = "05/01/2011"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s1 = dateFromString!
        
        let episode1s1 = Episode(number: 1, title: "Winter Is Coming", issueDate: date1s1, summary: "In the Seven Kingdoms of Westeros, a soldier of the ancient Night's Watch order survives an attack by supernatural creatures known as the White Walkers, thought until now to be myth. He rushes to Castle Winterfell, which is ruled by Eddard 'Ned' Stark, Warden of the North, who decapitates the soldier for deserting his post. In King's Landing, the capital, Jon Arryn, the 'Hand of the King', dies under mysterious circumstances. King Robert Baratheon, Ned's longtime friend, travels to Winterfell, offering the position to him and also proposing marriage between his firstborn son Joffrey and Ned's older daughter Sansa. Ned's wife Catelyn receives a letter from her sister Lysa, Jon Arryn's widow, saying that she has escaped King's Landing and that Jon was murdered by the Lannisters, Queen Cersei's family. Catelyn burns the letter and tells Ned about it, believing that the Lannisters are plotting against Robert. Ned's 10-year-old son, Brandon, climbs a tower, where he witnesses Cersei having sex with her twin brother, Jaime, who then pushes him out the window from a presumably fatal height. Meanwhile across the narrow sea in Essos, the exiled Prince Viserys Targaryen makes a deal with the Dothraki warlord Khal Drogo, who marries Viserys' younger sister, Daenerys, in exchange for an army to conquer Westeros and reclaim the Iron Throne.", season: season1)
        let episode2s1 = Episode(number: 2, title: "The Kingsroad", issueDate: date2s1, summary: "Having accepted his new role as the Hand of the King, Ned leaves Winterfell with his daughters Sansa and Arya, while Catelyn stays behind to tend to Bran. The unconscious Bran is attacked by an assassin, but his direwolf saves him. Catelyn decides to go to King's Landing to tell Ned about the attempt and suspected Lannister involvement. Jon Snow, Ned's illegitimate son, heads north to join the brotherhood of the Night's Watch, protectors of the Wall that keeps the White Walkers and the wildlings from entering civilized Westeros. Tyrion, Cersei's brother, decides to forgo the trip south with his family and instead accompanies Snow's entourage to the Wall. When Joffrey threatens Arya and her friend, Arya's direwolf defends her and escapes, provoking a conflict between the Starks and the Lannisters. To resolve the insult, Cersei demands that Robert order Ned to execute Sansa's direwolf. In Winterfell, Brandon awakens from unconsciousness. Meanwhile, Daenerys focuses her attention on learning how to please Drogo.", season: season1)
        let episode3s1 = Episode(number: 3, title: "Lord Snow", issueDate: date3s1, summary: "Ned joins the King's Small Council at King's Landing, capital of the Seven Kingdoms, and learns just how poorly Westeros is being managed. Catelyn tries to covertly warn her husband, but is intercepted by an old friend, Councillor Petyr 'Littlefinger' Baelish. Bran learns he will never walk again. He does not remember the events leading to his fall. Jon struggles to adapt to life on the Wall, as he trains with a number of low-born recruits who are not impressed by his bloodline. Lord Commander Mormont asks Tyrion to plead with the King to send more men to the Night's Watch. Daenerys learns that she is pregnant, and begins to stand up to Viserys.", season: season1)
        
        
        dateString = "04/08/2012"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s2 = dateFromString!
        
        dateString = "05/15/2012"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s2 = dateFromString!
        
        let episode1s2 = Episode(number: 1, title: "The North Remembers", issueDate: date1s2, summary: "To Cersei's dismay, Tyrion takes up his post as acting Hand at King's Landing. At Dragonstone, Stannis proclaims allegiance to Melisandre's new god and lays public claim to the Iron Throne, revealing Joffrey's bastardy. The latter orders the soldiers to slaughter Robert's bastards, one of whom, named Gendry, manages to escape King's Landing along with Arya. Having won three victories, Robb offers the Lannisters peace in exchange for the North's independence and Sansa's return, sending Theon to gain the support of Balon, his father, and Catelyn to seek alliance with Renly, who also claims the throne. Beyond the Wall, the Night's Watch finds shelter with Craster and his daughters/wives. In Essos, as her people slowly die in the Red Waste, Daenerys sends out riders for reconnaissance.", season: season2)
        let episode2s2 = Episode(number: 2, title: "The Night Lands", issueDate: date2s2, summary: "Returning to his home of Pyke after nine years as the Starks' ward, Theon is reunited with his sister, Yara, and Balon, who despises Theon for his Northern ways and intends to win back his crown by force. Cersei rejects Robb's terms and Tyrion exiles Slynt, head of the Gold Cloaks, to the Wall, promoting Bronn to commander of the watch. On the road to the Wall, Arya reveals her true identity to Gendry. North of the Wall, Tarly is approached by one of Craster's daughters, Gilly, who is pregnant and fears for her unborn son; Snow is reluctant to help her despite Tarly's pleas. In the Red Waste, one of the horses returns to Daenerys with the severed head of its rider in a pouch, a message from one of her enemies. In Dragonstone, Davos, Stannis's henchman, recruits the pirate Salladhor Saan to Stannis' side, and the latter has sex with Melisandre to obtain the son his wife cannot give him. Snow discovers that Craster sacrifices his sons to the White Walkers; in response, Craster knocks Snow unconscious.", season: season2)
        let episode3s2 = Episode(number: 3, title: "What Is Dead May Never Die", issueDate: date3s2, summary: "Catelyn arrives at Renly's camp to negotiate an alliance, watching the female warrior Brienne of Tarth winning the right to join Renly's guard. Renly has recently married Margaery, Loras's sister, but refuses to have sex with her due to having feelings for Loras. In the Iron Islands, Balon makes a plan to attack the North, led by Yara. After burning a letter warning Robb of Balon's impending attack, Theon re-joins the Greyjoys in a water-based ceremony. In King's Landing, Tyrion crafts a plan to find who is in Cersei's confidence; finding it to be Pycelle, whom the former imprisons. Tyrion assigns his prostitute, Shae, as handmaiden to Sansa. Beyond the Wall, Craster demands the Night's Watchmen leave. Snow finds out that Jeor already knew about Craster's felonies. On the road to the wall, the band of Night's Watch recruits are attacked by Lannister soldiers. Yoren is killed and Arya is taken prisoner. The latter states that Gendry was a boy already killed.", season: season2)
        
        
        dateString = "04/07/2013"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s3 = dateFromString!
        
        dateString = "04/14/2013"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s3 = dateFromString!
        
        let episode1s3 = Episode(number: 1, title: "Valar Dohaeris", issueDate: date1s3, summary: "Some of the Night's Watchmen, including Tarly and Mormont, survive the White Walkers' attack and pledge to return to the Wall to warn the Seven Kingdoms. Snow is brought before Rayder, the 'King beyond the Wall', and pledges his loyalty to the Wildlings. A scarred Tyrion tries to get Casterly Rock from Tywin, who promises other things instead. Margaery engages in charity work with the orphans of King's Landing. Baelish offers to help Sansa escape King's Landing. Ros advises Shae not to trust him. Davos is rescued by Saan, who does not want any more connections with Stannis, and returns to Dragonstone, where he unsuccessfully tries to kill Melisandre, who blames him for convincing Stannis not to let her join the battle, and is imprisoned. In Essos, Daenerys arrives in the city of Astapor to buy an army of brutally-trained slave soldiers, the 'Unsullied'. The warlocks of Qarth attempt to assassinate her, but she is saved by Selmy, the former Kingsguard commander, who pledges his loyalty.", season: season3)
        let episode2s3 = Episode(number: 2, title: "Dark Wings, Dark Words", issueDate: date2s3, summary: "Brienne continues escorting Jaime across the Riverlands to King's Landing. He engages her in a fight, which is interrupted by Bolton soldiers. After receiving the news of the sack of Winterfell and the disappearance of Bran and Rickon, Robb diverts his attentions from the war against the Lannisters to attend Catelyn's father's funeral in Riverrun, angering Karstark, who seeks vengeance for his sons who were killed by the Lannisters. Arya, Gendry and Hot Pie also make for Riverrun, but are waylaid by a rebel group, the 'Brotherhood without Banners', and are taken to an inn, where the captured Clegane reveals Arya's identity. Margaery and her grandmother Olenna, the 'Queen of Thorns', convince Sansa to tell them about Joffrey's flawed character. Theon is tortured by unknown captors. Bran, Rickon, Osha and Hodor encounter the siblings Jojen and Meera, children of the Stark bannerman Howland. Jojen, who has been sharing Bran's strange dreams, tells him that he is a warg, able to enter the minds of animals.", season: season3)
        let episode3s3 = Episode(number: 3, title: "Walk of Punishment", issueDate: date3s3, summary: "Robb and Catelyn attend the funeral in Riverrun. Tywin decides to send Baelish to Lysa intending to have them married in order to secure her alliance, making Tyrion the new Master of Coin. While Hot Pie decides to stay at the inn, Arya and Gendry follow the Brotherhood. Learning of the massacre at the Fist of the First Men, Rayder sends Snow with a band of Wildlings to scale the Wall and attack the Watch while it is weakened. The surviving men of the Night's Watch arrive back at Craster's Keep, where Tarly witnesses Gilly give birth to a son. Theon is freed from torture and captivity by an unknown man, who later rescues him again. Melisandre leaves Dragonstone for an unknown mission, stating that the blood of a King is required for victory. Daenerys agrees to buy all the 8,000 Unsullied and the translator Missandei for one of her dragons, against Selmy's and Jorah's advice. Jaime persuades his captor Locke not to let Brienne be raped, but Locke cuts off the former's sword hand.", season: season3)
        
        
        dateString = "04/13/2014"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s4 = dateFromString!
        
        dateString = "04/20/2014"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s4 = dateFromString!
        
        let episode1s4 = Episode(number: 1, title: "Two Swords", issueDate: date1s4, summary: "Tywin oversees the reforging of Ice, the Stark ancestral sword, into two new swords, one for Jaime, who tries to deal with the loss of his sword hand and Cersei's love, and one for King Joffrey as a wedding present. Prince Oberyn Martell, on behalf of his brother, Prince Doran of Dorne, arrives in King's Landing with his paramour, Ellaria Sand, to attend the royal wedding and is welcomed by Tyrion. Oberyn openly reveals to Tyrion his motive for his visit: revenge against the Lannisters for the rape and murder of his sister, Elia, wife of Prince Rhaegar. In the North, while Styr and his group of cannibal Thenns reinforce Tormund, Ygritte, and the other wildlings, Jon is released by Maester Aemon after confessing what he did during his time with the wildlings to gain information. In the Riverlands, Arya and the Hound reclaim her sword, Needle, from Polliver, killing him and his men. In Essos, Daenerys leads her army on a march towards Meereen, the last of the three great slave cities, though she is troubled by how her dragons are becoming less tame as they grow.", season: season4)
        let episode2s4 = Episode(number: 2, title: "The Lion and the Rose", issueDate: date2s4, summary: "Roose Bolton returns to the Dreadfort, where he criticizes Ramsay for mistreating Theon, who has been brutalized into a subservient persona called 'Reek'. The former decides to find and kill the remaining Stark children, Bran and Rickon, who threaten the legitimacy of his new title, while tasking Ramsay to reclaim the territories under Ironborn occupation. In Dragonstone, Melisandre orders several people to be burned as a tribute to the Lord of Light, to the delight of Queen Selyse and the disgust of Davos and Shireen. In King's Landing, Tyrion ends his relationship with Shae to protect her from his family and has her shipped off to Pentos. Jaime begins training his left-handed swordplay with the help of Bronn. King Joffrey and Margaery Tyrell are wed. Later, at the Royal Wedding feast, tensions between Joffrey and Tyrion grow—just before the former succumbs to poisoned wine and dies. A grief-stricken Cersei accuses Tyrion of the murder and has him arrested, while Ser Dontos, a former knight, advises Sansa to leave with him in order to survive.", season: season4)
        let episode3s4 = Episode(number: 3, title: "Breaker of Chains", issueDate: date3s4, summary: "Tywin begins grooming Tommen to be the next king and enlists Oberyn and Mace Tyrell as his fellow judges for the impending trial of Tyrion, who decides to pick Jaime as his witness. Littlefinger, who hired Ser Dontos, kills him and smuggles Sansa out of King's Landing. In the Riverlands, Arya and Sandor encounter a benevolent farmer and his daughter, whom Sandor robs, to Arya's disgust. In Dragonstone, Davos tries to figure out how to replenish Stannis' depleted forces and requests a loan from the Iron Bank of Braavos to pay for a group of mercenaries called the 'Golden Company'. In the North, Sam, fearing for Gilly's safety, has her and the baby moved out of Castle Black to nearby Mole's Town. Meanwhile, the wildlings continue to raid northern villages. The Night's Watch receive word that the band of Night's Watch mutineers have set up camp at Craster's Keep. Jon tells the Watch to organize a party to attack the mutineers, as they cannot risk having any information about the weakness of Castle Black's defenses leak to Mance Rayder's approaching army. Daenerys lays siege to Meereen.", season: season4)
        
        
        dateString = "04/19/2015"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s5 = dateFromString!
        
        dateString = "04/26/2015"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s5 = dateFromString!
        
        let episode1s5 = Episode(number: 1, title: "The Wars to Come", issueDate: date1s5, summary: "In a flashback, a witch tells a teenage Cersei that someone younger and more beautiful than herself will one day steal her accomplishments. In the present, Tywin is buried and Lancel returns, now a devoutly religious man and a member of the 'Sparrows'. In Pentos, a despondent Tyrion agrees to accompany Varys to Meereen to support Daenerys's claim on the Iron Throne. In Meereen, the insurgent 'Sons of the Harpy' murder an Unsullied, forcing Daenerys to launch more restrictive measures without respecting the old traditions. Missandei gets suspicious when she realizes that the Unsullied visit brothels. Daenerys's locked-away dragons attack her when she checks on them. In the Vale, Baelish puts Robin in the care of House Royce and leaves with Sansa. At the Wall, Stannis seeks to enlist the Wildlings in his war against Roose. Jon Snow is unable to convince Rayder to accept Stannis's authority. The latter has Mance burned alive, but Jon Snow mercifully shoots him with an arrow to kill him quickly.", season: season5)
        let episode2s5 = Episode(number: 2, title: "The House of Black and White", issueDate: date2s5, summary: "Arya arrives in Braavos and is accepted into the 'House of Black and White' by H'ghar, who calls himself and his colleagues 'no one'. Jaime tells Cersei he is going to Dorne to sneak out Myrcella, who is promised to Prince Doran's son, and recruits Bronn to assist him; Podrick recognises Baelish and Sansa in a tavern; Brienne offers Sansa her protection, but is rebuffed. Baelish demands her to stay with them, but she refuses and escapes with Podrick. However, she decides to follow Sansa secretly. Stannis offers Snow legitimacy and lordship of Winterfell if he leaves the Night's Watch to help him, but Snow declines; Tarly nominates him as a candidate for Lord Commander, and he is elected by the casting vote of Aemon. Daenerys faces a riot after she decides to execute a former slave who murdered a captured member of the Sons of the Harpy before he could be tried. Drogon reappears to her, but leaves again.", season: season5)
        let episode3s5 = Episode(number: 3, title: "High Sparrow", issueDate: date3s5, summary: "Margaery, newly wed to Tommen, manipulates him into planning to send Cersei to Casterly Rock. Baelish conducts Sansa to Winterfell to cement an alliance with Roose through her marriage to Ramsay, behind the Lannisters' back. Brienne decides to train Podrick. To adapt in the House of Black and White, Arya throws all her personal effects into the river except for Needle, which she hides in a pile of rocks. At Castle Black, Snow names Thorne First Ranger, but Slynt refuses to follow Snow's orders that he leave to rebuild the Greygard ruin. Snow executes Slynt himself. Lancel finds the High Septon in a compromising situation in a brothel, punishing him by forcing him to walk the streets completely nude. The High Septon complains to Cersei, who imprisons him instead. She meets the High Sparrow, approving the Sparrows' actions. Tyrion and Varys arrive in Volantis and visit a brothel, where the former is abducted by Mormont, intending to take him 'to the queen'.", season: season5)
        
        
        dateString = "05/01/2016"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s6 = dateFromString!
        
        dateString = "05/08/2016"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s6 = dateFromString!
        
        let episode1s6 = Episode(number: 1, title: "The Red Woman", issueDate: date1s6, summary: "Jon Snow's corpse is found by Ser Davos, Edd and a few other loyalists; Davos and the others take him inside and lock themselves behind a door with him, while Edd goes to get help. Thorne assumes command of the Watch. At Winterfell, Ramsay mourns for Myranda, while Sansa and Theon escape through the woods. Ramsay's men catch up with them, and are about to take them captive, when Brienne and Pod arrive, kill the men, and the former is accepted into Sansa's service. In King's Landing, Cersei receives Jaime, who arrives with Myrcella's body. Jaime promises Cersei they will take their revenge. Obara and Nymeria murder Trystane, on his way home from King's Landing, while in Sunspear, Doran and Areo Hotah are killed by Ellaria and Tyene, after the former learns of Myrcella's death. In Meereen, Tyrion and Varys find all the ships burning in the harbor. Jorah and Daario continue to track Daenerys, who is taken by the Dothraki to Khal Moro. In Braavos, Arya lives on the streets as a beggar, where she is beaten by the Waif. In her chamber, Melisandre removes her bejeweled necklace as she reveals her true appearance as an old crone.", season: season6)
        let episode2s6 = Episode(number: 2, title: "Home", issueDate: date2s6, summary: "Brandon visits Winterfell in a vision of the past, and sees Eddard, Benjen, and their sister Lyanna, as well as a young Hodor. Edd arrives with Tormund and a group of Wildlings, imprisoning Thorne and the other mutineers. Tommen asks Cersei to teach him to be strong. Tyrion learns that Astapor and Yunkai have reverted to slavery, and releases Rhaegal and Viserion from their chains. In Braavos, Arya is attacked by the Waif before H'ghar appears and recruits her again. Walda, Roose's wife, gives birth to a boy, prompting Ramsay to murder Roose, her, and the baby. Brienne reveals to Sansa that Arya is still alive. Sansa permits Theon's return to the Iron Islands, where his uncle Euron reappears and murders King Balon. Davos persuades Melisandre to attempt to resurrect Jon. At first, her attempts seem to fail. However, once everyone leaves the room, he awakens.", season: season6)
        let episode3s6 = Episode(number: 3, title: "Oathbreaker", issueDate: date3s6, summary: "On a boat on their way to Oldtown, Tarly reveals his intent to leave Gilly and her baby with the former's family at Horn Hill while he trains to be a Maester. In a vision of the past, Brandon sees Eddard and Howland, Meera's father, defeat a group of Kingsguard loyal to the Targaryens at the Tower of Joy in Dorne. Varys discovers that the masters of Astapor, Yunkai, and Volantis have been financing the Sons of the Harpy. In King's Landing, Tommen converses with the High Sparrow while Jaime and Cersei interrupt a small council meeting, only to be shunned by Kevan and the Tyrells. Cersei's bodyguard is revealed to be Gregor. Arya trains rigorously with the Waif and her sight is returned to her once she has accepted herself as 'no-one'. In Winterfell, Lord Umber asks Ramsay for help in protecting the North from the Wildlings, bringing Rickon and Osha as a gift, along with the head of Shaggydog, Rickon's direwolf. Jon executes Thorne, Olly and the other officers involved in his assassination. He renounces his oath and puts Tollett in charge of the Night's Watch.", season: season6)
        
        
        dateString = "07/23/2017"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date2s7 = dateFromString!
        
        dateString = "07/30/2017"
        dateFromString = dateStringFormatter.date(from: dateString)
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT:0)
        let date3s7 = dateFromString!
        
        let episode1s7 = Episode(number: 1, title: "Dragonstone", issueDate: date1s7, summary: "At the Twins, Arya fatally poisons the remaining lords of House Frey. The White Walkers march toward the Wall, where Tollett allows Bran and Meera inside. At Winterfell, despite Sansa's disapproval, Jon secures the loyalties of Houses Umber and Karstark, who fought alongside Ramsay in the Battle of the Bastards. At the Citadel, Samwell steals books that reveal a large reservoir of dragonglass in Dragonstone, and sends word to Jon. He later finds Jorah in a cell. In the Riverlands, Arya meets a group of friendly Lannister soldiers, who take her intention to kill Cersei as a joke. Thoros shows Sandor a vision in the fire. The revelation leads him to believe in the Lord of Light. In King's Landing, Jaime tells Cersei of the crucial need for allies. She welcomes Euron, who proposes marriage to her in exchange for his Iron Fleet and a chance to kill Theon and Yara. Cersei declines, citing trust as a concern, so Euron promises to return with a 'gift' to prove his loyalty. Daenerys arrives at Dragonstone, the home of House Targaryen once occupied by Stannis, with her army and dragons.", season: season7)
        let episode2s7 = Episode(number: 2, title: "Stormborn", issueDate: date2s7, summary: "Daenerys sends the Dornishmen with Yara's fleet to Sunspear and the Unsullied to Casterly Rock, deciding to place King's Landing under siege. She questions Varys' loyalty and threatens to burn him alive if he ever betrays her. Melisandre arrives and encourages her to invite Jon Snow to Dragonstone. Grey Worm and Missandei consummate their relationship. Cersei gathers several lords, asking for their fealties and elevating Randyll Tarly as Warden of the South. Qyburn shows Cersei a prototype ballista capable of harming dragons. Arya meets with Hot Pie and learns of Jon's ascension to King in the North, halting plans to travel to King's Landing and instead setting course for Winterfell. After receiving Samwell's letter, Jon leaves for Dragonstone in hopes of convincing Daenerys to support the fight against the White Walkers. He leaves Sansa in charge and aggressively warns Littlefinger to keep his distance. Samwell applies a forbidden treatment on Jorah's greyscale infection. Euron's fleet attacks Yara's. Obara and Nymeria are killed, while Ellaria, Tyene, and Yara are captured. Theon shows flashes of his time as Reek, hesitating to challenge Euron before fleeing the carnage by jumping into the sea.", season: season7)
        let episode3s7 = Episode(number: 3, title: "The Queen's Justice", issueDate: date3s7, summary: "Jon arrives at Dragonstone. Daenerys demands his fealty. He refuses and focuses instead on convincing her to fight the Army of the Dead. Following Tyrion's advice, Daenerys grants Jon access to the island's dragonglass. Melisandre hides her presence from Jon and leaves for Volantis. Bran arrives at Winterfell and reveals his newfound role as the Three-Eyed Raven to Sansa. In King's Landing, Euron returns with Ellaria and Tyene as a gift for Cersei, who promises to marry him after the war is won. She also awards him co-control of her military alongside Jaime. Cersei administers to Tyene the same poison used to kill Myrcella, forcing Ellaria to watch her daughter's impending death. In Oldtown, a healed Jorah leaves to find Daenerys. Ebrose forgives Samwell. Grey Worm and the Unsullied attack Casterly Rock, only to find it mostly abandoned. Jaime led most of the Lannister forces in an attack on Highgarden, while Euron's fleet ambushes and destroys the Unsullied's ships. The Lannister forces overwhelm Olenna's army. Jaime induces Olenna to drink poison, offering her a quick and painless death. After drinking it, she confesses to poisoning Joffrey.", season: season7)
        
        
        // Add episodes to seasons
        season1.add(episodes: episode1s1, episode2s1, episode3s1)
        season2.add(episodes: episode1s2, episode2s2, episode3s2)
        season3.add(episodes: episode1s3, episode2s3, episode3s3)
        season4.add(episodes: episode1s4, episode2s4, episode3s4)
        season5.add(episodes: episode1s5, episode2s5, episode3s5)
        season6.add(episodes: episode1s6, episode2s6, episode3s6)
        season7.add(episodes: episode1s7, episode2s7, episode3s7)
        
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
        
    }
    
    func seasons(filteredBy: (Season) -> Bool) -> [Season] {
        return seasons.filter(filteredBy)
    }
    
    
}

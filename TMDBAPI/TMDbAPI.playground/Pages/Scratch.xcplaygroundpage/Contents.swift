import TMDbAPI
import Foundation
let json = """
{
"id": 399174,
"cast": [
{
"cast_id": 2,
"character": "Chief (voice)",
"credit_id": "57458f61925141651b001078",
"gender": 2,
"id": 17419,
"name": "Bryan Cranston",
"order": 0,
"profile_path": "/fnglrIFnI5cK4OAh66AZN86mkFq.jpg"
},
{
"cast_id": 19,
"character": "Atari Kobayashi (voice)",
"credit_id": "585bcd4ac3a3682dfe09091d",
"gender": 0,
"id": 1726151,
"name": "Koyu Rankin",
"order": 1,
"profile_path": "/aBIr0MrAPVNxdxwFzFwMYIjleQi.jpg"
},
{
"cast_id": 5,
"character": "Rex (voice)",
"credit_id": "57458f74c3a36845fb0005f7",
"gender": 2,
"id": 819,
"name": "Edward Norton",
"order": 2,
"profile_path": "/eIkFHNlfretLS1spAcIoihKUS62.jpg"
},
{
"cast_id": 21,
"character": "Spots (voice)",
"credit_id": "585bcdcec3a3683843018044",
"gender": 2,
"id": 23626,
"name": "Liev Schreiber",
"order": 3,
"profile_path": "/qFn3npmqd1qaYOk6yohmi3FbPhc.jpg"
},
{
"cast_id": 15,
"character": "Tracy Walker (voice)",
"credit_id": "585bccb2925141724d061c53",
"gender": 1,
"id": 45400,
"name": "Greta Gerwig",
"order": 4,
"profile_path": "/3H0xzU12GTNJyQTpGysEuI9KyiQ.jpg"
},
{
"cast_id": 3,
"character": "Boss (voice)",
"credit_id": "57458f66c3a368698e00109e",
"gender": 2,
"id": 1532,
"name": "Bill Murray",
"order": 5,
"profile_path": "/7BOoOAIA1CnSzFSVSJP7saniQaB.jpg"
},
{
"cast_id": 6,
"character": "King (voice)",
"credit_id": "57458f799251413e5e002651",
"gender": 2,
"id": 12438,
"name": "Bob Balaban",
"order": 6,
"profile_path": "/3g7IKz8ycv0opDxmpoBxsQkUslU.jpg"
},
{
"cast_id": 4,
"character": "Duke (voice)",
"credit_id": "57458f6b9251416562000557",
"gender": 2,
"id": 4785,
"name": "Jeff Goldblum",
"order": 7,
"profile_path": "/t812WlNdP6F2ksRj21JF68DUiwz.jpg"
},
{
"cast_id": 12,
"character": "Nutmeg (voice)",
"credit_id": "585aae0e9251416f63081926",
"gender": 1,
"id": 1245,
"name": "Scarlett Johansson",
"order": 8,
"profile_path": "/8EueDe6rPF0jQU4LSpsH2Rmrqac.jpg"
},
{
"cast_id": 13,
"character": "Mayor Kobayashi (voice)",
"credit_id": "585bcc8992514175ad081a7f",
"gender": 0,
"id": 1714579,
"name": "Kunichi Nomura",
"order": 9,
"profile_path": null
},
{
"cast_id": 11,
"character": "The Oracle Dog (voice)",
"credit_id": "585aa7c8c3a3682dfe07d144",
"gender": 1,
"id": 3063,
"name": "Tilda Swinton",
"order": 10,
"profile_path": "/eGNo9qwlunvAi4kCVUEFtQFM5X.jpg"
},
{
"cast_id": 17,
"character": "Professor Watanabe (voice)",
"credit_id": "585bcd0cc3a368258c088078",
"gender": 2,
"id": 1643952,
"name": "Akira Ito",
"order": 11,
"profile_path": "/6vJQY2kZmBVrEcTz4FposVh2viZ.jpg"
},
{
"cast_id": 20,
"character": "Interpreter Woman (voice)",
"credit_id": "585bcdb592514122d2028646",
"gender": 1,
"id": 3910,
"name": "Frances McDormand",
"order": 12,
"profile_path": "/jodV4NuQAvxQWIHxqnop1jUX77N.jpg"
},
{
"cast_id": 18,
"character": "Major-Domo (voice)",
"credit_id": "585bcd23c3a3682dfe0908fe",
"gender": 0,
"id": 1333696,
"name": "Akira Takayama",
"order": 13,
"profile_path": "/wxPcSoz4KThwbwE3fnEPJCNBRGj.jpg"
},
{
"cast_id": 16,
"character": "Narrator (voice)",
"credit_id": "585bccc2c3a36806a7080740",
"gender": 2,
"id": 24047,
"name": "Courtney B. Vance",
"order": 14,
"profile_path": "/fscE874yHp4aeLLhMFD66OwYQt0.jpg"
},
{
"cast_id": 9,
"character": "Jupiter (voice)",
"credit_id": "585aa771c3a3682fb808ff0d",
"gender": 2,
"id": 1164,
"name": "F. Murray Abraham",
"order": 15,
"profile_path": "/vXurMA6XOAREPEyW6QRu5xKfGIT.jpg"
},
{
"cast_id": 23,
"character": "Scrap (voice)",
"credit_id": "59006e9bc3a3681036009738",
"gender": 2,
"id": 26473,
"name": "Fisher Stevens",
"order": 16,
"profile_path": "/TutpOyw0A6FF5hEoFDYseI2EVN.jpg"
},
{
"cast_id": 25,
"character": "News Anchor (voice)",
"credit_id": "59006f8b92514161a600a837",
"gender": 2,
"id": 1462260,
"name": "Yojiro Noda",
"order": 17,
"profile_path": null
},
{
"cast_id": 24,
"character": "Auntie (voice)",
"credit_id": "59006f1c92514161c600a0c5",
"gender": 1,
"id": 19589,
"name": "Mari Natsuki",
"order": 18,
"profile_path": "/oPCV2XYAJ4D1tK0OdJ2PPQbug5I.jpg"
},
{
"cast_id": 26,
"character": "Simul-Translate Machine (voice)",
"credit_id": "59006f9a92514161dd00a2d7",
"gender": 2,
"id": 52021,
"name": "Frank Wood",
"order": 19,
"profile_path": "/7g06FytDzIpbRTw7ONlB2ofara5.jpg"
},
{
"cast_id": 14,
"character": "Gondo (voice)",
"credit_id": "585bcca79251416fad08bfc4",
"gender": 2,
"id": 1037,
"name": "Harvey Keitel",
"order": 20,
"profile_path": "/4IcHhp1SCKijRxb7kqnxZNJuKdn.jpg"
},
{
"cast_id": 22,
"character": "Watanabe's Assistant (voice)",
"credit_id": "58ae378b9251412a3b003865",
"gender": 1,
"id": 96082,
"name": "Yoko Ono",
"order": 21,
"profile_path": "/j254dQthJu2rR1DRXqRkvo1oUqN.jpg"
},
{
"cast_id": 45,
"character": "Dr. Ben Watanabe (voice)",
"credit_id": "5a94ca5092514132760018f0",
"gender": 2,
"id": 3899,
"name": "Ken Watanabe",
"order": 22,
"profile_path": "/v8WQ5wCIZsnqVZn7jQveaDqurox.jpg"
},
{
"cast_id": 46,
"character": "(voice)",
"credit_id": "5a94cacd925141326a001a22",
"gender": 1,
"id": 929905,
"name": "Kara Hayward",
"order": 23,
"profile_path": "/zTrPq9HY90EdllC7VspXzkqILHC.jpg"
}
],
"crew": [
{
"credit_id": "57458f48c3a368697e001153",
"department": "Directing",
"gender": 2,
"id": 5655,
"job": "Director",
"name": "Wes Anderson",
"profile_path": "/s03CeUeC5yAXyB1acqP0zGNo2SC.jpg"
},
{
"credit_id": "57458f52c3a36869830012e8",
"department": "Writing",
"gender": 2,
"id": 5655,
"job": "Writer",
"name": "Wes Anderson",
"profile_path": "/s03CeUeC5yAXyB1acqP0zGNo2SC.jpg"
},
{
"credit_id": "57cb9d9992514141db00078d",
"department": "Production",
"gender": 2,
"id": 5655,
"job": "Producer",
"name": "Wes Anderson",
"profile_path": "/s03CeUeC5yAXyB1acqP0zGNo2SC.jpg"
},
{
"credit_id": "5919e2b6925141580d05bc10",
"department": "Visual Effects",
"gender": 2,
"id": 1447370,
"job": "Animation",
"name": "Tim Allen",
"profile_path": null
},
{
"credit_id": "59fdc6be92514146e8017e47",
"department": "Art",
"gender": 0,
"id": 1023711,
"job": "Production Design",
"name": "Adam Stockhausen",
"profile_path": null
},
{
"credit_id": "5a86103d925141759902d7c9",
"department": "Camera",
"gender": 0,
"id": 53331,
"job": "Director of Photography",
"name": "Tristan Oliver",
"profile_path": null
},
{
"credit_id": "5a8610450e0a2653b302ba6d",
"department": "Sound",
"gender": 2,
"id": 2949,
"job": "Original Music Composer",
"name": "Alexandre Desplat",
"profile_path": "/sdGjvOGJqjK1CTbxRedE64Txk0t.jpg"
},
{
"credit_id": "5a8610640e0a2653db02e8ea",
"department": "Art",
"gender": 0,
"id": 1687190,
"job": "Art Direction",
"name": "Curt Enderle",
"profile_path": null
},
{
"credit_id": "5a86106c0e0a2653db02e8f8",
"department": "Art",
"gender": 0,
"id": 1615295,
"job": "Production Design",
"name": "Paul Harrod",
"profile_path": null
},
{
"credit_id": "5a861084925141759302e90a",
"department": "Production",
"gender": 2,
"id": 5669,
"job": "Casting",
"name": "Douglas Aibel",
"profile_path": null
},
{
"credit_id": "5a86108b0e0a26400b02f9ba",
"department": "Production",
"gender": 0,
"id": 1714579,
"job": "Casting",
"name": "Kunichi Nomura",
"profile_path": null
},
{
"credit_id": "5a8610989251410ac402a0fa",
"department": "Editing",
"gender": 0,
"id": 1978890,
"job": "Editor",
"name": "Edward Bursch",
"profile_path": null
},
{
"credit_id": "5a86109fc3a368637c02b3fb",
"department": "Editing",
"gender": 0,
"id": 1559587,
"job": "Editor",
"name": "Ralph Foster",
"profile_path": null
},
{
"credit_id": "5a8610b4c3a368631602d5e2",
"department": "Production",
"gender": 0,
"id": 1004835,
"job": "Producer",
"name": "Jeremy Dawson",
"profile_path": null
},
{
"credit_id": "5a8610c00e0a26535a02b31b",
"department": "Production",
"gender": 0,
"id": 1004836,
"job": "Producer",
"name": "Steven M. Rales",
"profile_path": null
},
{
"credit_id": "5a8610c9c3a368637c02b428",
"department": "Production",
"gender": 2,
"id": 2997,
"job": "Producer",
"name": "Scott Rudin",
"profile_path": "/zR8sdlGblto6dneAr2mckTowwEl.jpg"
},
{
"credit_id": "5a8610d2c3a368620702a74e",
"department": "Production",
"gender": 0,
"id": 10905,
"job": "Executive Producer",
"name": "Charlie Woebcken",
"profile_path": null
},
{
"credit_id": "5a8610dc0e0a2652ab02b4d3",
"department": "Production",
"gender": 0,
"id": 10903,
"job": "Executive Producer",
"name": "Henning Molfenter",
"profile_path": null
},
{
"credit_id": "5a8610e5c3a368631602d62d",
"department": "Production",
"gender": 0,
"id": 1089142,
"job": "Executive Producer",
"name": "Christoph Fisser",
"profile_path": null
},
{
"credit_id": "5a8610ed0e0a2653db02e97d",
"department": "Production",
"gender": 0,
"id": 1332433,
"job": "Executive Producer",
"name": "Molly Cooper",
"profile_path": null
},
{
"credit_id": "5a8611050e0a26400b02fa31",
"department": "Production",
"gender": 0,
"id": 1046160,
"job": "Executive Producer",
"name": "Eli Bush",
"profile_path": null
},
{
"credit_id": "5a94cb180e0a26086f0019dd",
"department": "Production",
"gender": 0,
"id": 1394488,
"job": "Production Director",
"name": "David Greenbaum",
"profile_path": null
},
{
"credit_id": "5a94cb29c3a368120d001b3f",
"department": "Production",
"gender": 0,
"id": 1475367,
"job": "Co-Producer",
"name": "Octavia Peissel",
"profile_path": null
},
{
"credit_id": "5a94cb580e0a26087b001c9a",
"department": "Visual Effects",
"gender": 0,
"id": 1767234,
"job": "Animation Director",
"name": "Simon Quinn",
"profile_path": null
},
{
"credit_id": "5a94cba19251413261001a4f",
"department": "Art",
"gender": 0,
"id": 1986324,
"job": "Set Dresser",
"name": "Cristina Acuña",
"profile_path": null
},
{
"credit_id": "5ab2686bc3a3681cdc0080b7",
"department": "Sound",
"gender": 2,
"id": 1401563,
"job": "Sound Re-Recording Mixer",
"name": "Wayne Lemmer",
"profile_path": null
},
{
"credit_id": "5ab2687a9251413a22008b38",
"department": "Sound",
"gender": 2,
"id": 1400906,
"job": "Sound Re-Recording Mixer",
"name": "Christopher Scarabosio",
"profile_path": null
}
]
}
"""

let data = json.data(using: .utf8)!
let result = try! JSONDecoder().decode(TMDb.Movie.CreditsObject.self, from: data)
print(result)

print(result.director)


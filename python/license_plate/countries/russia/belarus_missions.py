from __future__ import annotations

from plate_core import PlateRestriction, PlateRestrictionError

NOT_FOUND = "COUNTRY NOT FOUND"
REFUSED = ("09",)
RESTRICTION = PlateRestriction("mission", REFUSED, NOT_FOUND)


class BelarusMissions:
    not_found = NOT_FOUND

    @staticmethod
    def is_refused(code):
        return code in REFUSED

    @staticmethod
    def name(code):
        if code in REFUSED:
            raise PlateRestrictionError(RESTRICTION)
        return _MISSIONS.get(code)


_MISSIONS = {
    "01": "Executive Committee of the CIS",
    "02": "Armenia",
    "03": "Brazil",
    "04": "Bulgaria",
    "05": "United Kingdom",
    "06": "Hungary",
    "07": "Germany",
    "08": "Georgia",
    "10": "India",
    "11": "Iraq",
    "12": "Iran",
    "13": "Italy",
    "14": "Kazakhstan",
    "15": "China",
    "16": "North Korea",
    "17": "Cuba",
    "18": "Kyrgyzstan",
    "19": "Latvia",
    "20": "Libya",
    "21": "Lithuania",
    "22": "Moldova",
    "23": "Nepal",
    "24": "Netherlands",
    "25": "South Korea",
    "26": "Poland",
    "27": "Russia",
    "28": "Romania",
    "29": "Vatican",
    "30": "Slovenia",
    "31": "United States",
    "32": "Tajikistan",
    "33": "Turkmenistan",
    "34": "Turkey",
    "35": "Ukraine",
    "36": "France",
    "37": "Czech Republic",
    "38": "Switzerland",
    "39": "Sweden",
    "40": "Estonia",
    "41": "Serbia",
    "42": "Japan",
    "43": "International Science and Technology Center",
    "44": "Economic Court of the CIS",
    "45": "Ministry of Foreign Affairs",
    "46": "Palestine",
    "47": "Azerbaijan",
    "48": "Sweden",
    "49": "Vietnam",
    "50": "Malta",
    "51": "United Nations",
    "52": "World Bank",
    "53": "European Bank for Reconstruction and Development",
    "54": "Organization for Security and Cooperation in Europe",
    "55": "Red Cross",
    "56": "International Organization for Migration",
    "57": "International Monetary and Financial Committee",
    "58": "International Monetary Fund",
    "59": "European Union",
    "60": "Syria",
    "61": "Venezuela",
    "62": "United Arab Emirates",
    "63": "Sri Lanka",
    "64": "Mongolia",
    "65": "Belgium",
    "66": "Executive Committee of the CIS",
    "67": "Germany",
    "68": "Russia",
    "69": "United States",
    "70": "Cyprus",
    "71": "Libya",
    "72": "Iceland",
    "73": "Uruguay",
    "74": "Oman",
    "75": "South Africa",
    "76": "Peru",
    "77": "Bahrain",
    "78": "UNICEF",
    "79": "Dominican Republic",
    "80": "North Macedonia",
    "81": "Austria",
    "82": "Finland",
    "83": "Kazakhstan",
    "84": "Eurasian Development Bank",
    "85": "Croatia",
    "86": "Spain",
}

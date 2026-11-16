"""Every licence plate in one package: `license_plate.load("iran")`, or `license_plate.iran`."""
from importlib import import_module

COUNTRIES = ('albania', 'algeria', 'andorra', 'angola', 'antigua_and_barbuda', 'argentina', 'australia', 'austria', 'bahamas', 'bangladesh', 'barbados', 'belgium', 'belize', 'benin', 'bhutan', 'bolivia', 'bosnia_and_herzegovina', 'botswana', 'brazil', 'brunei', 'bulgaria', 'burkina_faso', 'burundi', 'cambodia', 'cameroon', 'canada', 'canary_islands', 'cape_verde', 'caribbean', 'central_african_republic', 'chad', 'chile', 'china', 'colombia', 'comoros', 'costa_rica', 'croatia', 'cuba', 'cyprus', 'czech_republic', 'democratic_republic_of_the_congo', 'denmark', 'djibouti', 'dominica', 'dominican_republic', 'ecuador', 'egypt', 'el_salvador', 'equatorial_guinea', 'eritrea', 'estonia', 'eswatini', 'ethiopia', 'federated_states_of_micronesia', 'fiji', 'finland', 'france', 'gabon', 'gambia', 'georgia_country', 'germany', 'ghana', 'greece', 'grenada', 'guatemala', 'guinea', 'guyana', 'haiti', 'honduras', 'hungary', 'iceland', 'india', 'indian_ocean', 'indonesia', 'iran', 'iranshahr', 'italy', 'ivory_coast', 'jamaica', 'japan', 'jordan', 'kanak', 'kenya', 'kiribati', 'kyrgyzstan', 'laos', 'latvia', 'lebanon', 'lesotho', 'liberia', 'libya', 'liechtenstein', 'lithuania', 'luxembourg', 'madagascar', 'madeira', 'malawi', 'malaysia', 'maldives', 'mali', 'malta', 'marshall_islands', 'mauritania', 'mauritius', 'mexico', 'moldova', 'monaco', 'mongolia', 'montenegro', 'morocco', 'mozambique', 'myanmar', 'namibia', 'nauru', 'nepal', 'netherlands', 'new_zealand', 'nicaragua', 'niger', 'nigeria', 'north_korea', 'north_macedonia', 'norway', 'pakistan', 'palau', 'palestine', 'panama', 'papua_new_guinea', 'paraguay', 'peru', 'philippines', 'poland', 'polynesia', 'portugal', 'republic_of_ireland', 'republic_of_the_congo', 'romania', 'russia', 'rwanda', 'sahara', 'saint_helena', 'saint_kitts_and_nevis', 'saint_lucia', 'saint_vincent_and_the_grenadines', 'samoa', 'san_marino', 'senegal', 'serbia', 'seychelles', 'singapore', 'slovakia', 'slovenia', 'solomon_islands', 'somalia', 'south_africa', 'south_sudan', 'sovereign_military_order_of_malta', 'spain', 'sri_lanka', 'sudan', 'suriname', 'sweden', 'switzerland', 'syria', 'tanzania', 'thailand', 'timor_leste', 'togo', 'tonga', 'trinidad_and_tobago', 'tunisia', 'tuvalu', 'uganda', 'united_kingdom', 'uruguay', 'vanuatu', 'vatican_city', 'venezuela', 'vietnam', 'yemen', 'zambia', 'zimbabwe')
__all__ = ["COUNTRIES", "load"]


def load(name: str):
    """The `LoadedCountry` for a country folder name such as "iran"."""
    if name not in COUNTRIES:
        raise KeyError(f"unknown country {name!r}")
    return getattr(import_module(f"license_plate.countries.{name}"), name)


def __getattr__(name: str):
    if name in COUNTRIES:
        return load(name)
    raise AttributeError(name)

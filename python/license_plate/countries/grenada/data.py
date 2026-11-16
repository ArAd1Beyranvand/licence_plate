"""Generated from the shared data of grenada_plate; do not edit."""
from plate_core import load_country
from .grenada_validators import GrenadaValidator

grenada = load_country(r'''{"package":"grenada_plate","alphabets":{"latin.digits":["latin.digits",[["0","9"]],"typed",true],"latin.upper":["latin.upper",[["A","Z"]]]},"countries":{"GrenadaCountry.grenada":["gd",4294957056,4278190080,1.75,["WG"]]},"themes":{"GrenadaThemes.current":[4294957056,4278190080,0,0.06]},"specs":[["gd.current","GrenadaCountry.grenada",300,152,[["latin.upper",[0.4,17.9,149.1,117],3,3,0,null,"letters"],["latin.digits",[149.6,17.9,149.1,117],3,3,0,null,"number"]]]],"resolvers":{},"assets":[],"gallery":[["gd.current","Current","gd.current",["GAA","876"],"Grenada","Current",null,"GrenadaThemes.current","GrenadaCountry.grenada","GrenadaValidator"]]}''', {}, {'GrenadaValidator': GrenadaValidator})

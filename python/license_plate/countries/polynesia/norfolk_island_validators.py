
from plate_core import PlateCheck, RuledPlateValidator


class NorfolkIslandValidator(RuledPlateValidator):
    gate_group = "block"
    checks = (
        PlateCheck("block", r"[1-7]", "The block is a digit from 1 to 7."),
        PlateCheck("serial", r"[0-9]{3}", "The number is three digits."),
    )

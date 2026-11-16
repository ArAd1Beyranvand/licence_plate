
from plate_core import PlateCheck, RuledPlateValidator


class GabonValidator(RuledPlateValidator):
    gate_group = "number"
    checks = (
        PlateCheck("series", r"[A-Z]{2}", "The first group is 2 letters."),
        PlateCheck("number", r"[0-9]{3}", "The number is 3 digits."),
        PlateCheck("suffix", r"[A-Z]{2}", "The last group is 2 letters."),
    )

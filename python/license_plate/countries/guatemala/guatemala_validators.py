
from plate_core import PlateCheck, RuledPlateValidator


class GuatemalaValidator(RuledPlateValidator):
    checks = (
        PlateCheck("class", r"[A-Z]", "The class is one letter, such as P or C."),
        PlateCheck("digits", r"[0-9]{3}", "The number is three digits."),
        PlateCheck("letters", r"[A-Z]{3}", "The serial ends in three letters."),
    )

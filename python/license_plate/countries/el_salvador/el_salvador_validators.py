
from plate_core import PlateCheck, RuledPlateValidator


class ElSalvadorValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letter", r"[A-Z]", "The class is one letter."),
        PlateCheck("serial", r"[0-9]{4}", "The number is four digits."),
    )


class ElSalvadorMotorcycleValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letter", r"[A-Z]", "The class is one letter."),
        PlateCheck("series", r"[0-9]{1}", "The series is one digit."),
        PlateCheck("serial", r"[0-9]{3}", "The number is three digits."),
    )

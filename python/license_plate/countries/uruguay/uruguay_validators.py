
from plate_core import PlateCheck, RuledPlateValidator


class UruguayValidator(RuledPlateValidator):
    checks = (
        PlateCheck("first", r"[A-S][A-Z]{2}", "A serial is three letters, the first a department code (A to S)."),
        PlateCheck("number", r"[0-9]{1,4}", "The number is one to four digits."),
    )

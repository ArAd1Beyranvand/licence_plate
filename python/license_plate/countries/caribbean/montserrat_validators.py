
from plate_core import PlateCheck, RuledPlateValidator


class MontserratValidator(RuledPlateValidator):
    checks = (
        PlateCheck("type", r"[A-Z]", "The type is one letter."),
        PlateCheck("serial", r"[0-9]{1,4}", "The number is one to four digits."),
    )


from plate_core import PlateCheck, RuledPlateValidator


class SurinameValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letters", r"P[A-Z]", "The register is two letters, the first one P."),
        PlateCheck("serial", r"[0-9]{4}", "The number is four digits."),
    )

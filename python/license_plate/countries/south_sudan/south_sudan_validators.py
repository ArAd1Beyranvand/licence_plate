
from plate_core import PlateCheck, RuledPlateValidator


class SouthSudanValidator(RuledPlateValidator):
    checks = (
        PlateCheck("serial", r"[0-9]{3}", "The number is three digits."),
        PlateCheck("letters", r"[A-Z]{1,2}", "The register is one or two letters."),
    )

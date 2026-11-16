
from plate_core import PlateCheck, RuledPlateValidator


class ChristmasIslandValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letters", r"[A-Z]{2}", "The register is two letters."),
        PlateCheck("serial", r"[0-9]{4}", "The number is four digits."),
    )

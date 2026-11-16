
from plate_core import PlateCheck, RuledPlateValidator


class WallisAndFutunaValidator(RuledPlateValidator):
    checks = (
        PlateCheck("number", r"[0-9]{4}", "The serial is four digits."),
    )

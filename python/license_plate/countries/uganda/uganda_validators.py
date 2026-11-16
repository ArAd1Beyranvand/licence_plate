
from plate_core import PlateCheck, RuledPlateValidator


class UgandaValidator(RuledPlateValidator):
    checks = (
        PlateCheck("series", r"[A-Z]{2}", "The series is two letters."),
        PlateCheck("number", r"[0-9]{4,5}", "The number is four or five digits."),
    )

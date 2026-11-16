
from plate_core import PlateCheck, RuledPlateValidator


class SeychellesValidator(RuledPlateValidator):
    checks = (
        PlateCheck("letter", r"[A-Z]", "The series is one letter."),
        PlateCheck("serial", r"[0-9]{1,5}", "The number is one to five digits."),
    )

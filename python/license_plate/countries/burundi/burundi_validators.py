
from plate_core import PlateCheck, RuledPlateValidator


class BurundiValidator(RuledPlateValidator):
    gate_group = "number"
    checks = (
        PlateCheck("prefix", r"[A-Z]", "The prefix is 1 letter."),
        PlateCheck("number", r"[0-9]{4}", "The number is 4 digits."),
        PlateCheck("suffix", r"[A-Z]", "The suffix is 1 letter."),
    )

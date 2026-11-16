
from plate_core import PlateCheck, RuledPlateValidator


class ZambiaValidator(RuledPlateValidator):
    gate_group = "serial"
    checks = (
        PlateCheck("prefix", r"[A-Z]{3}", "The prefix is three letters."),
        PlateCheck("serial", r"[0-9]{4}", "The number is four digits."),
        PlateCheck("suffix", r"[A-Z]", "The suffix is one letter."),
    )

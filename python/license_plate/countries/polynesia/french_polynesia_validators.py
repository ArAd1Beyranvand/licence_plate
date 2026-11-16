
from plate_core import PlateCheck, RuledPlateValidator


class FrenchPolynesiaValidator(RuledPlateValidator):
    gate_group = "number"
    checks = (
        PlateCheck("number", r"[0-9]{6}", "The number is six digits."),
        PlateCheck("letter", r"[A-HJ-NP-TV-Z]", "The letter is one of A–Z without I, O, U."),
    )

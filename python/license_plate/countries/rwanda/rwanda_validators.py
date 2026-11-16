
from plate_core import PlateCheck, RuledPlateValidator


class RwandaValidator(RuledPlateValidator):
    checks = (
        PlateCheck("register", r"R[A-Z]{2}", "The register is three letters starting with R."),
        PlateCheck("serial", r"[0-9]{3}[A-Z]", "The number is three digits and a letter."),
    )

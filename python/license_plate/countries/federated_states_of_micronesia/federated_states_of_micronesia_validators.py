
from plate_core import PlateCheck, RuledPlateValidator


class FederatedStatesOfMicronesiaValidator(RuledPlateValidator):
    checks = (
        PlateCheck("serial", r"[0-9]{4}", "The serial is four digits."),
    )

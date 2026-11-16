from __future__ import annotations

from plate_core import GatedPlateValidator, PlateEntry, PlateValidation

_NOT_FOUND = "COUNTRY NOT FOUND"
_REFUSED = ("012",)
_MISSIONS = frozenset((
    "002 003 004 005 006 007 008 009 010 011 013 014 015 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 062 063 064 065 066 067 068 069 070 071 072 073 074 075 076 077 078 079 080 081 082 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 199 206 ").split())


class UkraineValidator(GatedPlateValidator):
    gate_group = "series"

    def validate(self, entry: PlateEntry) -> PlateValidation:
        if entry.group("mission") in _REFUSED:
            return PlateValidation.invalid(_NOT_FOUND)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for g in entry.spec.text_groups:
            if g.key is not None and not entry.group(g.key):
                return PlateValidation.invalid(f"The {g.key} is incomplete.")
        mission = entry.group("mission")
        if mission and mission not in _MISSIONS:
            return PlateValidation.invalid(_NOT_FOUND)
        return PlateValidation.valid()

from __future__ import annotations


class PeruPlates:
    @staticmethod
    def _sticker_text(group):
        register, serial = group("register"), group("serial")
        return f"{register}-{serial}" if register or serial else None

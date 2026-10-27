import json
import sys
from xml.sax.saxutils import quoteattr

MAPS = [
    ("base", ""),
    ("shift", "anyShift caps?"),
    ("caps", "caps"),
    ("option", "anyOption"),
    ("shiftOption", "anyShift anyOption caps?"),
    ("capsOption", "caps anyOption"),
    ("command", "command anyShift? anyOption? caps?"),
    ("control", "anyControl anyShift? anyOption? caps? command?"),
]

SWEDISH = {10: ("å", "Å"), 94: ("ä", "Ä"), 93: ("ö", "Ö")}


def attr(s):
    # macOS's keylayout parser yields empty output for named entities like &lt;
    plain = lambda c: (0x20 <= ord(c) < 0x7F and c not in "&\"<>") or ord(c) > 0xA0
    return '"' + "".join(c if plain(c) else f"&#x{ord(c):04X};" for c in s) + '"'


def main(src, dst):
    us = json.load(open(src))
    keys = {int(k): v for k, v in us["keys"].items()}
    for code, (lower, upper) in SWEDISH.items():
        keys[code] = {"base": lower, "shift": upper, "caps": upper, "option": lower,
                      "shiftOption": upper, "capsOption": upper, "control": ""}
    for k in keys.values():
        k["command"] = k["base"]

    compose = {}
    for dead, info in us["dead"].items():
        for code, by_mod in info["compose"].items():
            for mod, out in by_mod.items():
                compose.setdefault((int(code), mod), {})[dead] = out

    actions = {}
    lines = ['<?xml version="1.1" encoding="UTF-8"?>',
             '<!DOCTYPE keyboard SYSTEM "file://localhost/System/Library/DTDs/KeyboardLayout.dtd">',
             '<keyboard group="126" id="-24871" name="U.S. Svenska" maxout="2">',
             '  <layouts>',
             '    <layout first="0" last="17" mapSet="ANSI" modifiers="Modifiers"/>',
             '  </layouts>',
             '  <modifierMap id="Modifiers" defaultIndex="0">']
    for i, (_, mods) in enumerate(MAPS):
        lines += [f'    <keyMapSelect mapIndex="{i}">', f'      <modifier keys="{mods}"/>', '    </keyMapSelect>']
    lines += ['  </modifierMap>', '  <keyMapSet id="ANSI">']
    for i, (mod, _) in enumerate(MAPS):
        lines.append(f'    <keyMap index="{i}">')
        for code in range(128):
            v = keys[code].get(mod, "")
            if isinstance(v, dict):
                actions.setdefault(v["dead"], [("none", "next", v["dead"])])
                lines.append(f'      <key code="{code}" action={quoteattr(v["dead"])}/>')
            elif mod != "command" and (code, mod) in compose:
                aid = f"k{code}_{mod}"
                actions[aid] = [("none", "output", v)] + [(d, "output", o) for d, o in sorted(compose[(code, mod)].items())]
                lines.append(f'      <key code="{code}" action="{aid}"/>')
            else:
                lines.append(f'      <key code="{code}" output={attr(v)}/>')
        lines.append('    </keyMap>')
    lines += ['  </keyMapSet>', '  <actions>']
    for aid, whens in actions.items():
        lines.append(f'    <action id="{aid}">')
        for state, kind, val in whens:
            lines.append(f'      <when state="{state}" {kind}={attr(val)}/>')
        lines.append('    </action>')
    lines += ['  </actions>', '  <terminators>']
    for dead, info in sorted(us["dead"].items()):
        lines.append(f'    <when state="{dead}" output={attr(info["terminator"])}/>')
    lines += ['  </terminators>', '</keyboard>', '']
    open(dst, "w").write("\n".join(lines))


main(*sys.argv[1:])

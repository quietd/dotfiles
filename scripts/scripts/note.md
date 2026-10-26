# Why I have this kb-pre/kb-post script (and how to use it)

## The problem

My main keyboard layout is **colemak_dh**, set as index 0 in Hyprland:

```
kb_layout  = us,us,ru
kb_variant = colemak_dh,,
```

Some games read keyboard input in a dumb way — they just grab whatever is at
**index 0** of the layout list and use that, forever, no matter what layout
Hyprland is actually switched to. They don't listen for layout-switch events at
all.

So even though I *can* switch to qwerty inside Hyprland, the game doesn't
care — it's frozen on index 0 forever. Since index 0 is colemak_dh, all my
keybinds show up scrambled.

This isn't a bug in the game and it isn't a bug in Hyprland — it's just
games not tracking group switches, and me having colemak_dh at index 0
instead of qwerty.

## The fix

Don't try to "switch" layout at all. Instead, **temporarily swap which
layout sits at index 0** right before launching the game, then swap it
back after the game closes.

- Before game starts → qwerty becomes index 0
- Game runs → sees qwerty, keybinds work normally
- Game closes → colemak_dh becomes index 0 again → my normal daily driver

## Important gotcha (if I ever edit these scripts again)

My Hyprland config is **Lua-based** (`hl.config({...})`), not the old
`.conf` style. That means the normal `hyprctl keyword ...` command
**does not work** — it errors with:

```
keyword can't work with non-legacy parsers. Use eval.
```

So instead I have to use:

```bash
hyprctl eval 'hl.config({ input = { kb_layout = "...", kb_variant = "..." } })'
```

Note the quotes: **single quotes** around the whole Lua expression,
**double quotes** inside for the string values. If I ever tweak this and
things silently stop working, check the quoting first.

## The two scripts

**`kb-pre.sh`** — run before the game starts. Puts qwerty at index 0.
**`kb-post.sh`** — run after the game exits. Puts colemak_dh back at index 0.

```bash
# kb-pre.sh
#!/usr/bin/env bash
hyprctl eval 'hl.config({ input = { kb_layout = "us,us,ru", kb_variant = ",colemak_dh," } })'
```

```bash
# kb-post.sh
#!/usr/bin/env bash
hyprctl eval 'hl.config({ input = { kb_layout = "us,us,ru", kb_variant = "colemak_dh,," } })'
```

Both live in `~/.local/bin/` and are `chmod +x`.

## How to actually use them

### In Lutris
1. Right-click the game → **Configure**
2. **System options** tab → **Game execution** section
3. **Pre-launch script** → `/home/<me>/.local/bin/kb-pre.sh`
4. **Post-exit script** → `/home/<me>/.local/bin/kb-post.sh`
5. Enable "wait for pre-launch script" if that option exists, so the swap
   finishes before the game actually opens.

### In Steam
Launch Options field:
```
~/.local/bin/kb-pre.sh; %command%; ~/.local/bin/kb-post.sh
```
(or wrap it properly in one script if this one-liner ever misbehaves)

### Manually, from anywhere
If a game ever launches weird and the post-script doesn't fire (force-quit,
crash, whatever), and I notice I'm stuck typing qwerty-on-colemak in normal
desktop use:

```bash
~/.local/bin/kb-post.sh
```

Run that and it's instantly back to normal. No need to overthink it or
re-read this whole note — just run kb-post.sh and check:

```bash
hyprctl getoption input:kb_variant
```

should show `colemak_dh,,`.

## tl;dr for future narrow-vision-at-the-screen me

- Games freeze on index 0, colemak_dh is my index 0, that's why keybinds
  look wrong in some games.
- `kb-pre.sh` before game, `kb-post.sh` after game, Lutris does this
  automatically via pre-launch/post-exit script fields.
- If I ever get soft-locked on qwerty: just run `kb-post.sh` manually.
- If I ever touch the scripts again: Lua config → must use
  `hyprctl eval 'hl.config({...})'`, NOT `hyprctl keyword`.

#! /bin/bash

if [ ! "$(which sassc 2> /dev/null)" ]; then
  echo sassc needs to be installed to generate the css.
  exit 1
fi

SASSC_OPT="-M -t expanded"

_COLOR_VARIANTS=('' '-light' '-dark')
if [ ! -z "${COLOR_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

_SOLID_VARIANTS=('' '-solid')
if [ ! -z "${SOLID_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _SOLID_VARIANTS <<< "${SOLID_VARIANTS:-}"
fi

for solid in "${_SOLID_VARIANTS[@]}"; do
for color in "${_COLOR_VARIANTS[@]}"; do
  sassc $SASSC_OPT src/gtk-3.0/gtk${solid}${color}.{scss,css}
  echo "==> Generating the gtk${color}.css..."
  sassc $SASSC_OPT src/gnome-shell/gnome-shell${color}.{scss,css}
  echo "==> Generating the gnome-shell${color}.css..."
done
done

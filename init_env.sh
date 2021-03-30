#!/usr/bin/env bash

op get item "box" | jq -j '.details.sections[1].fields[] | @sh "export ", .t, "=\"", .v, "\"\n"'

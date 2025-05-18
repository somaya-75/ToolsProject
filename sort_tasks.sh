#!/bin/bash
awk '
{
  for (i = 1; i <= NF; i++) {
    if ($i == "PRIORITY:") {
      if ($(i+1) == "HIGH") p=1;
      else if ($(i+1) == "MEDIUM") p=2;
      else if ($(i+1) == "LOW") p=3;
      print p, $0;
      break;
    }
  }
}' tasks.txt | sort -n| cut -d' ' -f2-



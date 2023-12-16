# event-calendar-convert

## Problem

Our local scout group's programme leader likes to plan event calendar with excel.

Our wordpress site likes to eat html tables.

## Solution

```
ghc convert.hs
cat input-excel.tsv | ./convert > output.html

# Or, to see results
cat input-excel.tsv | ./convert | lynx -stdin  ## Ooh
```


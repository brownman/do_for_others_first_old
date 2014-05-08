LISTS
=
### GOAL:
- write an interpreter ! create your own language ! take a .txt file and use it as an application!
- don't code ! instide - tell the robot how to read the list.txt ! let the robot code instide of you !!!

### Motivation:

- write less code and achive more
- use a text file for couple of purposes: lines of date/lines which read by the bash interpreter and consume the data 

### Terminology:
- List: a text file which consist of: lines

## Line type:
- Comment:      ignored lines of tags
- Line of text: which defines items and saperate them with the char: '|'
- Empty line:   ignore
- Tag:          a commented text - that the parser is using for creating variables
- Parser:  
---- is also defined as a tag
---- it tries to execute each line of data
---- it consist of items - just  like any line of data

### Execution type:
- conditional(between a line's items)
- all 
- single

### Random type:
- random
- random-by-weight


### Available lists:
--
## croning:
- type:     conditional
- details:  inspect the time -> try to run each line -> execute if minutes/X 
- why?      use a list which triggered every minute - instide of editing the crontab file

## testing:
- type:     all
- details:  progress indication: count tests
- why ?     prompt or recent failed test: encourage updating the list of priorities: which next feature is the most important?


## screen_prompt:
- type:    single
- details: random prompt is a nice way to refresh the memory about 1 thing every time we run the command: bash 
- why?     increase the motivation/awareness  + pay attention - even for a second - for something - you tend to let go

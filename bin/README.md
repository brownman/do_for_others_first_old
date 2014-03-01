The Selfish language 
## version: 0.0.1
==

Intro:
--
- The Selfish interpreter considered to be a wrapper around the GNU Bourne-Again SHell (Aka: bash)

- It considred to be the language of choice for a Bash scripter who cares about tagging his scripts for future use.

### 
Features:
1. The readiness tag:
- Assume: the wrapper set to run scripts on readiness level of 1(the strictest)
- scripts which are tagged as higher - will halt the execution.
2. Inline tests:
- writing short tests just inside a function - encourages writing tests for your scripts.
3. Using the interpreter is Encouraging the scripter to:
- add comments to his scripts
- updating the parser accordingly and teach it how to handle your invented syntax!
4. The programmer is setting his own standards:
- for example:
- I decide that a ready selfish script with the readiness level of 1 -  must contain the tags:#name,#version:
- calculate.slf:
```
#!/bin/selfish
#name: example01
#version: 0.0.1
#tests: step1,step3
#depend_package: bash,perl
#depand_process: cron

step1(){
#name:        sum
#description: add 2 numbers
#test:        assertEquals `step1 1 2` 3
let "res=$1 + $2"
echo "$res"
}
step2(){
#name:  
}

steps(){
step1
step2
}
```
```
#running the selfish script:
./selfish calculate.slf
#result:
Error: readiness level 4 is insufficient! 
info: The selfish interpreter is set to run script with readiness level of 1,2
Please update your script or edit the interpreter's rules to run a higher level of un-readiness.

```


#!/bin/bash
trap trap_err ERR


trap_err(){
assertEquals $1 666
}

return 666



#!/bin/bash -e
use public.menu
deep=2

show_tree(){
tree -L $deep
}
report_readiness(){
grep readiness -r .
}


coverage_testing(){
cover .
}

steps(){
show_tree
report_readiness
coverage_testing
}
steps

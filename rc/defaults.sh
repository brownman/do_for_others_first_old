#!/bin/bash -e
echo "LOADING: defaults.cfg"
export DEBUG=true



#use private.basic.basics

use public.proxy.proxy1
load_many(){


#echo "LOAD: public .cfg"


use public.grep.replace
use public.prompt.history_sync


#echo "LOAD: private .cfg"

use private.alias.scripts
use private.alias.cd



}
if [ "$DEBUG" = true ];then
load_many 1> .history
else
    load_many
fi

use private.alias.alias

use private.vars.vars



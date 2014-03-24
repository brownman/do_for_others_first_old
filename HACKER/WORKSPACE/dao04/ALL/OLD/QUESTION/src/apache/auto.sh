install_php_modules(){
        # get jail name
	local n="${_chrootbase}/${d##/}"
	local p=""
	local ini=""
        # enable only ${_php_modules_enabled} php modules and delete other .ini files if exists in jail
	for i in $_php_modules/*
	do
		p="${i##*/}"
		ini="$n/etc/php.d/${p/so/ini}"
                # find out if module is enabled or not
		if [[ ${_php_modules_enabled} = *${p}*   ]]
		then
			[ "$VERBOSE" == "1" ] && echo " [+] Enabling php module $p"
			$_cp -f "$i" "$n/${_php_modules##/}"      ## install it
			copy_shared_libs "$i"                     ## get shared libs in jail too
		else
			[ -f "${ini}" ] && $_rm -f "${ini}"	  ## if old .ini exists in jail, just delete it
		fi
	done
}
#http://www.cyberciti.biz/tips/bash-shell-parameter-substitution-2.html

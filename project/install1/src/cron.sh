test_if_service_cron_is_running(){
    #crontab $dir_workspace/cron/crontab.txt
    if [ "$SUDO" = true ];then
        result=$( sudo service cron status )

        assertEqual "$result" 2
    else
        print_info "skip checking sudo commands"
    fi

}
test_crontab_uses_the_user_s_settings(){
    result=$( crontab -l | grep croning.sh )
    if [ "$result" = '' ];then

        if [  "$OVERRIDE_CRONTAB" = true ];then
            cmd="crontab $dir_workspace_guest/crontab/crontab.txt" 
            confirm "$cmd"
        else
            print_info "skip overriding crontab"
        fi
    fi
    assertNotEqual "$result" ""

}





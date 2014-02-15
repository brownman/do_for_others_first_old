
export wrapper_sh=$0
export file_logger=/tmp/logger.txt

export dir_project=$dir_root/project
export dir_project_rc=$dir_root/projectrc
        export dir_env=$dir_project_rc/env
        export dir_cfg=$dir_project_rc/cfg


    export dir_vendor=$dir_root/VENDOR

    export dir_workspace_guest=$dir_root/WORKSPACE/GUEST
    export dir_workspace=$dir_root/WORKSPACE/$LOGNAME
        export file_shortcut=$dir_workspace
            export dir_rooms=$dir_workspace/rooms
            
        export dir_install=$dir_project/install1
        export dir_bin=$dir_project/bin
            export single_sh=$dir_bin/single.sh
        export dir_plugins=$dir_project/plugins
        export dir_faq=$dir_project/faq

        #            export dir_ext=$dir_answer/ext



source $dir_env/user.cfg #load username , password, etc
source $dir_env/env.cfg #load configuration for running the project: +-SOUND +-EDITOR +-TRANSLATION_ON
source $dir_env/source.cfg #load global functions



echo "LOADING: projectrc"

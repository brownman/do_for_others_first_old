remote_repo=https://github.com/hackerU-Advance-Linux-Group/dropbox-voices.git 
my_branch="LOGNAME"

help(){
echo http://gitref.org/creating/#init
}

install(){
sudo apt-get install git
}

step1_get_the_code(){
git clone $remote_repo -b develop
}

step2_begin_your_own_branch(){
git checkout -b "$my_branch"
}

step3_edit_the_code(){
echo "for example"
echo "echo '$LOGNAME >> README.md'"
}

step4_commit_changes(){
git add .
}

step5_rename_commit(){
str='just added my name to the file README.md'
git commit -am "$str" 
}

step6_push_changes_to_github(){
git push origin $my_branch 
}

show_funcs

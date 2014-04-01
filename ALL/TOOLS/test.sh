echo https://github.com/0k/shyaml
start(){
print_color 32  '1. present yaml'
print_color 33  '2. test'
}

search_dir_tests(){
ls -R | grep 'tests/'
}
present_readme(){
ls -R | grep README.md | xargs cat 
}


steps(){
    start
search_dir_tests
echo present_readme
echo present_yaml
}

steps

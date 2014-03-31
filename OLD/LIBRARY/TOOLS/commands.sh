search_dir_tests(){
ls -R | grep 'tests/'
}
present_readme(){
ls -R | grep README.md | xargs cat 
}


steps(){
search_dir_tests
echo present_readme
echo present_yaml
}

steps

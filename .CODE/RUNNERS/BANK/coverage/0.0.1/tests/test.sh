echo  '[TESTING] coverage.sh'


step1(){
print_func
    assertEquals 0 0
}
step2(){
print_func

    assertEquals 0 1
}
steps(){


step1
step2

}
steps

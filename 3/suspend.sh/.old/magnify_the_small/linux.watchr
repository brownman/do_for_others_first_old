

watch('data/yaml/one.yaml') {|match| system "bash -e ./genius.sh yaml"}
watch('data/txt/error2.txt') {|match| system "bash -e ./genius.sh simple_notification error"}
#watch('1/testing/python2/koans\/.*\.py') {|match| system "bash -e ./1/testing/python2/run.sh"}
watch('bugs/bash_koans/src\/.*\.sh') {|match| system "bash -e bugs/bash_koans/meditate"}
watch('script/cfg\/.*\.cfg') {|match| system "bash -e ./genius.sh simple_notification"}
watch('script/tasks/plugins\/.*\.sh') {|match| system "bash -e ./genius.sh simple_notification"}
#watch('script/time/test.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
#watch('script/tasks/tasker.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
#watch('script/tasks/plugins/db.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
#watch('genius.sh') {|match| system "bash -e ./1/testing/python2/run.sh"}
#watch('data/txt/testing.txt') {|match| system  "bash -e ./1/testing/python2/run.sh"}



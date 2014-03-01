
USING THE  LIBRARY:
----------------------------
![using the library](.GIF/using_the_library.gif)_

###Example:
```sh

#say: we want to load the file: color.cfg
cd $dir_root/rc
tree -L 3 lib/public/color
#the common way:
#option1: source color.cfg



#option2: use the library:
type print_color
echo
print_color  31 HELLO
print_color  32 WORLD
print_color  33 I
print_color  34 AM
print_color  35 FEELING
print_color  36 GREAT !!!
```

#!/bin/bash
source cfg/vars.cfg

dpkg-deb --build  $dir_first product/$change_my_name.deb


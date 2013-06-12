#!/bin/bash
moduleDir=`pwd`
drupal6ModuleDir='/usr/share/drupal6/modules'
updateModules () {
  echo "Begin updating Modules"
  for f in ${moduleDir}/*.tar.gz
    do
      tar -C ${drupal6ModuleDir} -zxvf $f
    done
#  do
#    echo "Doing stuff on this file $f"
#    echo "Backing up $f"
#    cp -r
#  done

}
updateModules
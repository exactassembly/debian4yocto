# debian4yocto
debian based Docker container with all dependencies for Yocto

For automation associated with building Yocto environments using Ruby/Rake with
a simple Rakefile see https://github.com/exactassembly/bitumen

*NOTE*  Due to changes in Yocto, current poky fails with the version of Git
available in debian:wheezy, so this repo has been switched to debian:jessie

Username: minion
Password: minion
WORKDIR /build

## How to use ##

This repository does not contain any Yocto source, you must add the yocto files
for it to work.  Use Git to clone a copy of the Yocto ("Poky") sources inside
the container and then run oe-init-build-env:

    docker run -a STDIN -a STDOUT -a STDERR -i -t y3ddet/debian4yocto

    minion@8f7943ab2a3b:/build$  git clone git://git.yoctoproject.org/poky.git /build/poky
      ...
    minion@8f7943ab2a3b:/build$  cd /build/poky

    minion@8f7943ab2a3b:/build$  . ./oe-init-build-env /build
      ...
    ### Shell environment set up for builds. ###

    You can now run 'bitbake <target>'

    Common targets are:
    core-image-minimal
    core-image-sato
    meta-toolchain
    meta-ide-support

    You can also run generated qemu images with a command like 'runqemu qemux86'
    minion@8f7943ab2a3b:/build$    

*NOTE* The stock Yocto Poky installation above is of limited utility, you should 
look at the Yocto Project documentation to better understand the use of bitbake
layers, recipes, and machine targets:  http://www.yoctoproject.org/docs/2.0.1/mega-manual/mega-manual.html


    
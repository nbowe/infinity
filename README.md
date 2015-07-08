

## My Easy Infinity Keyboard Configuration.

This vagrantfile is meant to make it easy to configure and flash firmware for my [Infinity Keyboard][1].
It should also work for other keyboards supported by [kiibohd][2], but auto-attaching when in bootloader mode may not work without extra changes to the Vagrantfile.

## Dependencies
Install [virtualbox and extensions](https://www.virtualbox.org/wiki/Downloads), and [vagrant](https://www.vagrantup.com/).

You may also benefit from vagrant-cachier and vagrant-triggers if you are going to play with this a lot.
```
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-triggers
```

## Building

 * Bring up the VM and connect to it.
   ```
   $ vagrant up
   $ vagrant ssh
   ```
 * Edit layouts.
   Layouts are in the `layouts` directory. Feel free to create a new subdir and add your own. 
   You can use a configurator like the one [here][3] as a start if you want.
 * Build.
   Execute `./build.sh` from one of the layout folders.
 * Flash
   Press the flash button on the bottom of the keyboard. This will cause it to auto attach to the VM, ready to be flashed.
   Using another keyboard, in the directory with the firmware, run ` $ sudo ./load `.
   If you see `state(7) = dfuMANIFEST, status(0) = No error condition is present` then flashing has succeeded.
   If you only have 1 keyboard, you can try `sleep 5; sudo ./load`, and push the flash button while its sleeping.
 * Cleanup.
   `exit` the vm, then `vagrant destroy` to cleanup.
   `git clean --fXd` from the layouts directory to clean up build artifacts.


[1]: https://www.massdrop.com/buy/infinity-keyboard-kit
[2]: https://github.com/kiibohd/controller
[3]: http://configurator.input.club/

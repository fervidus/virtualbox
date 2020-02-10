#!/bin/sh

# Puppet Task Name: add_virtualbox_additions
#
# This is where you put the shell code for your task.
#
# You can write Puppet tasks in any language you want and it's easy to
# adapt an existing Python, PowerShell, Ruby, etc. script. Learn more at:
# https://puppet.com/docs/bolt/0.x/writing_tasks.html
#
# Puppet tasks make it easy for you to enable others to use your script. Tasks
# describe what it does, explains parameters and which are required or optional,
# as well as validates parameter type. For examples, if parameter "instances"
# must be an integer and the optional "datacenter" parameter must be one of
# portland, sydney, belfast or singapore then the .json file
# would include:
#   "parameters": {
#     "instances": {
#       "description": "Number of instances to create",
#       "type": "Integer"
#     },
#     "datacenter": {
#       "description": "Datacenter where instances will be created",
#       "type": "Enum[portland, sydney, belfast, singapore]"
#     }
#   }
# Learn more at: https://puppet.com/docs/bolt/0.x/writing_tasks.html#ariaid-title11
#

wget http://download.virtualbox.org/virtualbox/$PT_vbox_version/VBoxGuestAdditions_$PT_vbox_version.iso
mkdir /media/VBoxGuestAdditions
mount -o loop,ro VBoxGuestAdditions_$PT_vbox_version.iso /media/VBoxGuestAdditions
/media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_$PT_vbox_version.iso
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions
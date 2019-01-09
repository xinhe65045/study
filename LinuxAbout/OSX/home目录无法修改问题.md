Hmmm, trying to create a directory under '/home' on a Mac?

Well, Apple doesn't want you to (with good reason, automounter owns this dir, which makes it easier to do NFS mounts and such) so you shouldn't muck with it but if you really just 'have to do it', here is how you can.

Basically: Edit /etc/auto_master and remove or comment out the line that starts with "/home".

example:
sudo vim /etc/auto_master

before:

>   ```
>       # Automounter master map
>       +auto_master            # Use directory service
>       /net                    -hosts          -nobrowse,hidefromfinder,nosuid
>       /home                   auto_home       -nobrowse,hidefromfinder
>       /Network/Servers        -fstab
>       /-                      -static
>   ```
after:

>   ```
>       # Automounter master map
>       +auto_master            # Use directory service
>       /net                    -hosts          -nobrowse,hidefromfinder,nosuid
>       #/home                   auto_home       -nobrowse,hidefromfinder
>       /Network/Servers        -fstab
>       /-                      -static
>   ```

to have the change take effect without a reboot:
>   ```
>       sudo automount
>       
>       mkdir /home/test
>       ls -l /home/
>       total 0
>       drwxr-xr-x 3 root admin 102 Aug 10 11:33 test
>   ```
NOTE: I wouldn't do anything 'important' with this directory as it's easy to forget you altered this and an upgrade will plow over this directory, removing all data. (this dir is also not included in any Time Machine backups.
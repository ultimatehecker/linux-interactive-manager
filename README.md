# linux-interactive-manager
Allows you to do anything in your system from simple, clean interactive menus. This is highly customizable, and makes it easy
to create your own menus. This is a great way to learn bash scripting, and is a great tool for anyone who wants to do
anything. This can be run on any linux operating system, as all of the command iterations are built in

# Installation
Setup is quite simple, first step is to clone the repository (it is reccomended you do this in the root directory):

```bash 
git clone https://github.com/ultimatehecker/linux-interactive-manager
```

After cloning the repository, for easy access it is also reccomended to cut and paste all of the files into the root
directory. Once that is done, you could give all permissions to the file:

```bash
sudo chmod 777 ./start.sh
```

Once all permissions are given, you can run the start menu by doing:

```bash
sudo ./start.sh
```

The menu by default will be needing sudo permissions to even bring it up, as it will need access to be able to tinker with some
of the settings of your system.
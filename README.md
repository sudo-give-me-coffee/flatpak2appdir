# flatpak2appdir
A tool for converting flatpaks into AppImages

# How to use?

0. Make sure that flatpak ins installead and not broken under your system:
```bash
# For Ubuntu:
sudo add-apt-repository -y ppa:alexlarsson/flatpak
sudo apt-get update
sudo apt-get -y  install flatpak

# For other systems, please see:
# https://flatpak.org/setup/

# Is recommended  to add flathub for getting runtimes
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

```
> Notes: your application **must be able to run** with `flatpak run your.app.id`
> If flatpak is broken the tool will be fail

1. Download
```
wget https://github.com/sudo-give-me-coffee/flatpak2appdir/archive/master.zip -O flatpak2appdir.zip
```

2. Unzip
```
unzip flatpak2appdir.zip
```

3. Enter on repository dir:
```
cd flatpak2appdir-master
```


4. Turn executable:
```
chmod +x flatpak2appdir strace-file appimagetool
```

5. Run:
```
./flatpak2appdir com.example.app
```

# Commandline option:

```
--executable=cmd    Scan for dependencies of 'cmd'
--autostop=time     Define how long executables will be traced
--disable-theme     Disables theme integration

Notes:
  ¹ --executable= Can be used multiple times
  ² The default value for --autostop= is 25,
    the time is given in seconds
```

# How much overhead on the resulting AppDir?

In general, about 8 to 10 MB (the glibc and some extra libs), the resulting AppDir when compressed as AppImage in my tests will use disk space close to that of the original application (in most of cases)


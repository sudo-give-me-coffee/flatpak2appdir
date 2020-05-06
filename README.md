# flatpak2appdir
A tool for converting flatpaks into AppImages

# How to use?

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
chmod +x flatpak2appdir
```

5. Run:
```
./flatpak2appdir com.example.app
```

# Commandline option:

```
--executable=cmd    Scan for dependencies of 'cmd'
--autostop=time     Define how long executables will be traced
--help              Show this help

Notes:
  ¹ --executable= Can be used multiple times
  ² The default value for --autostop= is 25,
    the time is given in seconds
```

# How much overhead on the resulting AppDir?

In general, about 8 to 10 MB (the glibc and some extra libs), the resulting AppDir when compressed as AppImage in my tests will use disk space close to that of the original application (in most of cases)


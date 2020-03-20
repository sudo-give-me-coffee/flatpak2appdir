# flatpak2appdir
A proof of concept to demonstrate a viable way to turn a Flatpak into AppDir, just pass a flatpak app as argument and this tool generate 

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

5. Run as root:
```
sudo ./flatpak2appdir com.example.app
```
> Note: to do these steps `flatpak2appdir` will create a `.img` file with the runtime name, you can delete this **after** AppDir creation
# How to use?

It's working by chrooting under `runtime` of `app` and  mapping used files using `strictatime` and `nodiratime` and copying to AppDir

# How much overhead on the resulting AppDir?

In general, about 8 to 10 MB, the resulting AppDir when and if sanitized and compressed as AppImage in my tests will use disk space close to that of the original application without the main runtime (application files + ostree objects)

# Missing features
This is a PoC, so it has a large list of missing features:
- [ ] Find executable dinamically (currently generated AppRun only looks at /app/bin)
- [x] Support non binary apps
- [x] Enable `dconf` and `dbus` during test phase
- [x] Support to apps that depends of libexecs but doesn't load them automatically
- [x] Support no required `runtimes`

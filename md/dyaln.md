# 
My laptop runs Alpine Linux with Openbox as its "Desktop". The only GUI application which runs is the web browser. The rest of the system is controlled and used through the terminal.

```
    ___      black@bones
   (.· |     OS:         Alpine Linux edge x86_64
   (<> |     MODEL:      80MK Lenovo YOGA 900-13ISK
  / __  \    UPTIME:     52 mins
 ( /  \ /|   PACKAGES:   377 (apk)
_/\ __)/_)   RESOLUTION: 3200x1800
\/-____\/    MEMORY:     300MiB / 7889MiB
```

The system has a display of **3200x1800** pixels and works flawlessly with the window manager and all running applications. Colors are extracted from the current wallpaper and are changed system-wide and on-the-fly.

<picture>
  <source srcset="/images/rice1-2x.webp 2x,/images/rice1.webp" type="image/webp">
  <source srcset="/images/rice1-2x.jpg 2x, /images/rice1.jpg" type="image/jpeg">
  <img src="/images/rice1.jpg" alt="desktop">
</picture>

The system information tool I use is a program I wrote called [`neofetch`](https://github.com/dylanaraps). The `bar` is a simple [shell script](https://github.com/dylanaraps/bin/blob/master/bar) which fetches information from text files at an interval. As there is no method to obtain the volume level from a file, I populate a file whenever I change the volume level.

The bar loops infinitely without executing a single command. The device has an SSD. There is zero performance impact on file IO.

<picture>
  <source srcset="/images/rice2-2x.webp 2x,/images/rice2.webp" type="image/webp">
  <source srcset="/images/rice2-2x.jpg 2x, /images/rice2.jpg" type="image/jpeg">
  <img src="/images/rice2.jpg" alt="desktop">
</picture>

My text editor is `vim` using the `goyo` plugin to hide the user interface and center the file's contents. The music player is `mpv` running inside of my local music library. I do not need a fancy program to provide a library, playlists and metadata.

The big upside to `mpv` is that my video player, image viewer and music player are all the same program. The configuration is unified between the three and the hotkeys are all the same.

<picture>
  <source srcset="/images/rice3-2x.webp 2x,/images/rice3.webp" type="image/webp">
  <source srcset="/images/rice3-2x.jpg 2x, /images/rice3.jpg" type="image/jpeg">
  <img src="/images/rice3.jpg" alt="desktop">
</picture>

I talk primarily over Discord using the `IRCdiscord` program to allow connection via an IRC client. The client I use is `weechat` with majority of its user interface disabled.

This is a great combination as it avoids running another web browser to access their client and it uses near zero resources. I would love to swap to bare IRC or Matrix in the future as Discord does not respect the user's privacy.

<picture>
  <source srcset="/images/rice4-2x.webp 2x,/images/rice4.webp" type="image/webp">
  <source srcset="/images/rice4-2x.jpg 2x, /images/rice4.jpg" type="image/jpeg">
  <img src="/images/rice4.jpg" alt="desktop">
</picture>

Resource usage is extremely low and time on battery is extremely high. I would love to move to something even lighter in the future. Alpine Linux has its positives however it has its negatives too.

Packages are not updated in a timely manner and the project suffers from a lack of maintainers/developers. I do not use `dbus` and there is a mix between packages built with it explicitly disabled and those built with it as a dependency.

<picture>
  <source srcset="/images/rice5-2x.webp 2x,/images/rice5.webp" type="image/webp">
  <source srcset="/images/rice5-2x.jpg 2x, /images/rice5.jpg" type="image/jpeg">
  <img src="/images/rice5.jpg" alt="desktop">
</picture>

I would love to swap windows managers in the near future. Openbox has not seen an update or line of code in over 3 years and I like to keep things "fresh". Despite this fact, Openbox as of the last 3 months now depends on `rust` to build.

This occurred due to one of the dependencies being rewritten in `rust`. It's funny how a program that has not seen an update in years can suddenly depend on additional or different software.

---

Sources:

- `dotfiles`: <https://github.com/dylanaraps/dotfiles>
- `scripts`: <https://github.com/dylanaraps/bin>

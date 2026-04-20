---
title: Command Execution via Drag-and-Drop in Terminal Emulators
date: 20.04.2026
---
Many people may not be aware that terminal emulators such as Kitty and xfce4-terminal support dragging and dropping of files into the terminal to insert the file's path directly at the cursor position. While this feature has existed for a while, more people have started to notice this as Claude Code has grown in popularity and [allows users to drag and drop files for Claude to process](https://code.claude.com/docs/en/common-workflows#work-with-images.).

But as we all know, fun features tend to come with fun vulnerabilities!

**Proof of Concept**

<center><iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/UPzjq2aemwE?si=brgiKIZtwL3M3epR" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe></center>

The payload used to achieve this is:

```
\x03 gnome-calculator \x0d.txt
```

Here is a breakdown of what each part does:

- `\x03` - End of Text, equivalent to pressing Ctrl+C
- `gnome-calculator` - The command to be executed
- `\x0D` - Carriage Return, equivalent to pressing Enter


More details about these control characters and their history are covered in [Portswigger's awesome research article](https://portswigger.net/research/drag-and-pwnd-leverage-ascii-characters-to-exploit-vs-code) by [Zakhar Fedotkin](https://x.com/zakfedotkin). The short version is that the terminals interpret these characters literally, and since dragged file paths are inserted into the command line without any sanitization, the payload gets executed as if the user typed it themselves.

**Realistic Attack Scenario**

Imagine downloading a zip file or cloning a git repo that contains a file with this payload as its filename. You open your GUI file manager, spot a `.txt` file, and drag it into your terminal to quickly `cat` it, but instead of reading the file, you've just executed a malicious command.

One might argue that the malicious payload would be visible in the filename, raising suspicion. But if a long string is prepended to the filename, most file managers will truncate it, hiding the payload, as shown in the image below.

![](https://i.ibb.co/rf2VhbtB/image.png)

**Many Vulnerable Terminal Emulators**

As shown below, this works in `xfce4-terminal` as well.

<center><iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/VYHAk2shpfI?si=g6gyy5WZqQO-JFhp" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe></center>

Both vulnerabilities have been reported to the projects' maintainers and have been patched. However, no CVE has been assigned because MITRE has been unresponsive, likely due to the funding cuts.

Several other terminal emulators share the same vulnerability. I've reported it to their maintainers but have not received any response regarding a fix. In the meantime, I would recommend switching to a terminal emulator that is either not affected or has been patched, such as [Ghostty](https://github.com/ghostty-org/ghostty) (patched, originally found by [Nguyen Thanh Son](https://github.com/ghostty-org/ghostty/security/advisories/GHSA-4jxv-xgrp-5m3r)), [Alacritty](https://github.com/alacritty/alacritty) (does not support drag-and-drop), [Kitty](https://github.com/kovidgoyal/kitty) (patched), or [XFCE4 Terminal](https://gitlab.xfce.org/apps/xfce4-terminal) (patched).

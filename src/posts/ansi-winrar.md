---
title: ANSI Escape Injection Vulnerability in WinRAR
date: 21.05.2024
---

On 28 February 2024, RARLAB released an update for WinRAR, patching an ANSI escape sequence injection vulnerability that I had found in the console versions of RAR and UnRAR, affecting versions 6.24 and earlier. This vulnerability, tracked as CVE-2024–33899 for Linux and Unix systems and CVE-2024–36052 for the Windows, allowed attackers to spoof screen output or cause denial of service (in Linux and Unix). This vulnerability was patched in version 7.00. It’s important to note that the GUI version of WinRAR and the UnRAR library were not impacted by this vulnerability, regardless of the version.

In this post, I will walk you through how this vulnerability works and demonstrate a proof of concept. While I will be showcasing this on a Linux system, the same can be done on a Windows or Unix system.

**Background**

If you are familiar with the Linux, Unix or Windows command line, chances are that you’ve encountered programs like [Vim](https://github.com/vim/vim) and [Neofetch](https://github.com/dylanaraps/neofetch/). These programs use ANSI escape sequences to modify the text and background color, control the cursor, and create [GUI within the terminal](https://web.archive.org/web/20240524111033/https://github.com/Textualize/textual).

![](https://i.ibb.co/gFj3DnVD/ansi-esc-test.png)

Even though ANSI escape sequences can be used to create fancy terminal programs, it can also be weaponized, as shown in [Stok Fredrik’s DEFCON talk](https://www.youtube.com/watch?v=3T2Al3jdY38).

WinRAR provides console RAR and UnRAR which can be use to create and extract RAR archives. As shown in the image below, RAR files support comments, that gets displayed when listing the contents of the archive file using `unrar l demo.rar`.

![](https://i.ibb.co/GfVsScf9/comment-demo.png)

In order to check if ANSI escape sequences are filtered out in the comment section, we can use a simple payload that will display `THIS IS GREEN` in the color green.

```
printf 'Hello \033[32mTHIS IS GREEN\033[0m\007' | rar c demo.rar
```

Upon executing `rar l demo.rar`, we are able to see that `THIS IS GREEN` is outputted in green. This shows that the comment field does not filter ANSI escape sequences in the output.

![](https://i.ibb.co/LzVCzVcf/this-is-green-poc.png)

**Exploitation**

This vulnerability can be exploited in many various ways but an exploit suited for WinRAR will be used as a demonstration.

First, we will put our `virus.exe` file inside an `rar` file:

```console
$ ls 
virus.exe
$ rar a demo.rar virus.exe
```

Next, we will add the following payload to the comment section:

```bash
printf 'Archive: demo.rar\nDetails: RAR 5\n\nAttributes      Size       Date   Time   Name\n----------- ---------  ---------- -----  ---------\n-rw-r--r--          7  2024-05-19 16:26  notvirus.pdf\n----------- ---------  ---------- -----  ---------\n                    7                    1\e[8m' | rar c demo.rar
```

This payload includes a fake listing where `virus.exe` is replaced with `notvirus.pdf`. The ANSI escape sequence `\e[8m` is used to hide all content after the comment section in the output. As a result, the actual file listing is hidden, and our fake file listing is displayed. In the screenshot below, you can see a large gap between the output and the shell prompt. This gap is due to the original file listing being outputted but rendered invisible using `\e[8m`. While experienced command line users may find this suspicious, less experienced users could easily be tricked.

![](https://i.ibb.co/dsPD3LnM/before-after.png)

As mentioned at the beginning of this post, there are two CVEs associated with this vulnerability due to its significantly higher severity on Linux and Unix systems compared to Windows. This is because on Linux and Unix systems, certain ANSI escape sequences can be used to achieve a local denial of service.

The payload below, which is taken from [Stok Fredrik’s Black Hat slides](https://web.archive.org/web/20240524111033/https://i.blackhat.com/BH-US-23/Presentations/US-23-stok-weponizing-plain-text-ansi-escape-sequences-as-a-forensic-nightmare-appendix.pdf), captures all cursor movements and outputs the coordinates to the terminal. This only works on Linux and Unix systems. When tested on a Kali Linux VM, the cursor coordinates were outputted to the terminal and the VM later ended up being frozen.

```bash
\033[?1001h\033[?1002h\033[?1003h\033[?1004h\033[?1005h\033[?1006h\033[?1007h\033[?1015h\033[?10016h\
```

Despite the limited research on ANSI escape sequences, it’s evident that attackers with a deep understanding of ANSI escape sequences can exploit them in a creative, malicious and sometimes even annoying ways.


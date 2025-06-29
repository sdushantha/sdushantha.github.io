---
title: Spooky Remote Code Execution
date: 11.02.2025
---

On December 31, 2024, version 1.0.1 of the modern terminal emulator [Ghostty](https://github.com/ghostty-org/ghostty) was released that patched a code execution vulnerability, now tracked as [CVE-2024-56803](https://github.com/ghostty-org/ghostty/security/advisories/GHSA-5hcq-3j4q-4v6p). While terminals execute commands by design, this vulnerability allowed for unintended command execution through the title reporting escape sequence `(\e[21t)`.

This occurred because the escape sequence inserted the window title directly into the command line. If the user pressed Enter, the inserted title would be executed as a command.

For example, it was possible to launch the calculator by modifying the title using `\e]2;<title>`, where `<title>` is the command, such as gnome-calculator. When combined with the title reporting escape sequence, the title would be inserted into the command line in the format `l<title>`, where `l` denotes that the subsequent string is the window title.

However, Ghostty dynamically updates the window title after every executed command to reflect the current working directory. This behaviour interfered with the exploit by overriding the title that we controlled with a string containing the updated path.

![](https://i.ibb.co/F4VwM3Nk/1.png)

To bypass this, we could merge the title setting sequence and the title reporting sequence into a single sequence, preventing Ghostty from updating the title before the payload got inserted into the command line.

![](https://i.ibb.co/yB87s91P/2.png)

Another issue that arose was that the inserted title was prefixed with `l`, preventing execution of the command. While this character could not be removed, a workaround was found where would prepend a semicolon `(;)` to the payload. This would make Bash interpret the inserted title as two separate commands as the semicolon is a command separator.

![](https://i.ibb.co/fY0zj9vm/3.png)

This payload could be delivered by having it stored in a file and having a user `cat` it or fetch it using `curl`. But most users won't press Enter when they see that commands have been inserted into their command line.

Therefore, a payload can be crafted where `\e[8m` is used to make the malicious command invisible, along with a fake error message that is displayed to deceive the user into pressing "Enter".

![](https://i.ibb.co/bgwSFhhF/4.png)

There are ongoing discussions about whether terminal emulator developers or CLI/TUI tool developers should be blamed for allowing escape sequences to be parsed when they are not needed. In the meantime, it is crucial to address the fact that escape sequences, an old technology that has not been updated, poses as a security risk. Therefore, it is important that user input is always sanitised to prevent users from being compromised.

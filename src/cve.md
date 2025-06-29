**CVE-2024-56803**<br>
Ghostty is a cross-platform terminal emulator. Ghostty, as allowed by default in 1.0.0, allows attackers to modify the window title via a certain character escape sequence and then insert it back to the command line in the user's terminal, e.g. when the user views a file containing the malicious sequence, which could allow the attacker to execute arbitrary commands. This attack requires an attacker to send malicious escape sequences followed by convincing the user to physically press the "enter" key. Fixed in Ghostty v1.0.1.

**CVE-2024-37535**<br>
GNOME VTE before 0.76.3 allows an attacker to cause a denial of service (memory consumption) via a window resize escape sequence, a related issue to CVE-2000-0476.

**CVE-2024-36052**<br>
RARLAB WinRAR before 7.00, on Windows, allows attackers to spoof the screen output via ANSI escape sequences, a different issue than CVE-2024-33899.

**CVE-2024–33899**<br>
 RARLAB WinRAR before 7.00, on Linux and UNIX platforms, allows attackers to spoof the screen output, or cause a denial of service, via ANSI escape sequences.

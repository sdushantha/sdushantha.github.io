# Reflected XSS and HTML injection on netlife.no

---

On the 22nd of October I was successfully able to find out that netlife.no was
vulnerable to [HTML injection](https://www.acunetix.com/vulnerabilities/web/html-injection/) and [reflected XSS](https://security.stackexchange.com/questions/65142/what-is-reflected-xss/65242#65242).
So you might be wondering why did I target Netlife? Well it had only been a few
weeks since we had school photos taken and after a few days we were told to go
to fotonorden.no where we had to put in a code and then could see our images
and Foto Norden used Netlife’s service to show and sell the photos to us.

After typing the code and logging in, I was greeted with this page:

![I turned off the images so that you guys cant see my handsome school photos](images/netlife/fotonorden_shop.png)

<br>

The first thing I did was to drag one of my photos onto a new tab and was able
to see the direct URL to the image.

![The photo is not shown because of the same reason as I mentioned earlier](images/netlife/direct_url.png)

<br>

I saw that there was a parameter with the name `uuid`. So what did I do? Well I just replaced the value of the `uuid` with this payload:

```
<script>alert("XSS")</script>
```

Which surprisingly gave me this:

![Yay it worked! 🎉](images/netlife/xss_success.png)

<br>

Now I knew that knew that it was vulnerable to reflected XSS. Since I was able
to inject JavaScript code, would it possible to inject HTML code? Yup! I just
replace the value of the uuid with this payload:

```
<br><br><br><br><br><center><font size=”79" color=”red”>HTML INJECTION</font><br><img width=”500" height=”400" src=”http://images.clipartpanda.com/unicorn-with-wings-clipart-black-and-white-cute-unicorn-clipart-unicorn4.png"> </center>
```

Which gave me this:

![Yes, I like unicorns 🦄](images/netlife/html_injection.png)

<br>

And there, I was able to conclude that Netlife, which was the service which
Foto Norden was using, was vulnerable to reflected XSS and HTML injection.

## How could an attacker exploit this?
Well the attacker could steal any user’s cookies just by sending Foto Norden’s
URL with a malicious payload to a victim. If the victim was logged in to Foto
Norden and opened the URL which the the attacker sent them, the attacker could
steal their cookies and log in to the victims account and see and buy their
photos.

## Resoltuion Timeline
**22 October 2018**

- 9:20 AM: Issue reported to Netlife via email


**23 October 2018**

- 10:20 AM: Netlife confirms vulnerability


**24 October 2018**

- 8:57 AM: I send more information on how this could be exploited


**25 October 2018**

- 9:44 AM: Netlife takes measures to prevent HTML Injection and reflected XSS
from happening again


**26 October 2018**

- 3:16 PM: Rewarded by the company. They gave me a discount code so that I
could get my school photos mailed to me for free.

{DOTS}

Thank you for reading about how I was able to find two vulnerabilities in
Netlife’s website. 

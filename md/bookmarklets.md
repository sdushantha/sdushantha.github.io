# bookmarklets

These are some bookmarlets I have created to bypass paywalls, cheat on online quizes or just to
make you life much easier.

To use them, all you have to do is to drag the text that has square brackets around it, into your bookmark bar which is located
on the top of your browser and when you want to use it, just click on the bookmarklet.

Have any questions? Want to request a bookmarlet? Or just want to say? Feel free
to shoot me an email. My email can be found in the about page.

---

### Bypass Study.com Paywalls <small>[Last updated - 13.01.2020]</small>

This bookmarklets will allow you to bypass the paywall on Study.com so that you can read the text
that is blured and more text which is hidden to the eye.

[[Bypass Study.com]](javascript:(function() {     document.getElementsByClassName("hidden")[1].className = "";     document.getElementsByClassName("hidden")[1].className = "";     document.getElementsByClassName("wikiContent faded-content")[0].className = ""; })();)

---

### InThinking Multiple Choice Quiz Solver <small>[Last updated - 22.08.2019]</small>

This bookmarklet solves all of the multiple choice questions on ThinkIB.net

_Disclaimer: This script has only been tested out on Physics questions but it should work on other subjects as well._

[[InThinking Solver]](javascript:(function(){try{var N=0;while (true){document.getElementsByClassName("right")[N].click();document.getElementsByClassName("btn quiz-show")[N].click();N++;}}catch(err) {console.log(err.message);}alert("All answers have been answered")})())

---

### CodeHS Answer Viewer for HTML Course <small>[Last updated - 05.02.2019]</small>

This bookmarklet shows you the answers for the HTML coding assignments on CodeHS.com


[[View CodeHS Answer]](javascript:(function(){var base="https://codehs.com/editor/CODE/solution/index.html";var code=document.URL.split("/")[4];var final=base.replace("CODE",code);window.open(final,"_blank")})())


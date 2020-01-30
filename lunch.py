import requests
import re
from datetime import date
import json

TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
<title>Today's Lunch</title>
</head>
<body>
<style>
body {
 font-family:'Comfortaa', sans-serif !important;
}
p {
 font-size: 20px;
}

div {
    height: 200px;
    width: 400px;

    position: fixed;
    top: 50%;
    left: 50%;
    margin-top: -100px;
    margin-left: -200px;
}

</style>

<div>

<center>
<h1>Today's Lunch</h1>
<p>$LUNCH$</p>
</center>
</div>

</body>
</html>
"""

cookies = {
    'PHPSESSID': 'drhll3rsfc42s9n50t1vihanj2',
    'wordpress_google_apps_login': '803a223f7e5b35d6e6f9dcaf8274ed7a',
    'wordpress_test_cookie': 'WP+Cookie+check',
    'bid_144_password_protected_auth': 'bid_144%7C1582045337%7Cc1b132fb880d11bedf48265ec247cacd',
}

headers = {
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Referer': 'http://portal.blog.isstavanger.no/?password-protected=login&redirect_to=http%3A%2F%2Fportal.blog.isstavanger.no%2Fcafeteria%2F',
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
}

print("Fetching data from school website")
# This request needs the headers and cookies because login is needed to access the info.
# If you are on the school network, then login is not required.
r = requests.get('http://portal.blog.isstavanger.no/cafeteria/', headers=headers, cookies=cookies)

html = r.text

meals = re.findall(r"itemprop=\"name\">(.*)</span", html)
dates = re.findall(r"([ADFJMNOS]+\w*) ([0-9]{1,2},) ([0-9]{4})", html)[1::2]

today = date.today()
todays_date = today.strftime("%B %d, %Y")

lunch_data = {}

def generate_data():
    print("Generating data")
    for count, date in enumerate(dates):
        month, day, year = date
        current_date = f"{month} {day} {year}"
        lunch_data[current_date] = meals[count]

def list_all():
    for count, date in enumerate(dates):
        current_date = f"{date[0]} {date[1]} {date[2]}"
        if current_date == todays_date:
            print(f"\033[1;46m{current_date}\033[0m: {meals[count]}\n")
        
        else:
            print(f"\033[1m{current_date}\033[0m: {meals[count]}\n")

def todays_lunch():
    data = json.loads(json.dumps(lunch_data))
    return data.get(todays_date)

def generate_website():
    print("Generating website")
    with open("lunch.html", "w") as fname:
        fname.write(TEMPLATE.replace("$LUNCH$", todays_lunch()))

def main():
    generate_data()
    generate_website()


main()

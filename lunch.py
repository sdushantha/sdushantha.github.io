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

url = "http://portal.blog.isstavanger.no/cafeteria/"
r = requests.get(url)

html = r.text

meals = re.findall(r"itemprop=\"name\">(.*)</span", html)
dates = re.findall(r"([ADFJMNOS]+\w*) ([0-9]{1,2},) ([0-9]{4})", html)[1::2]

today = date.today()
todays_date = today.strftime("%B %d, %Y")

lunch_data = {}

def generate_data():
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
    with open("lunch.html", "w") as fname:
        fname.write(TEMPLATE.replace("$LUNCH$", todays_lunch()))

def main():
    generate_data()
    generate_website()


main()

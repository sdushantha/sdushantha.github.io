---
title: Setting Up A Catch-All Inbox Using Cloudflare
date: 01.18.2026
---

I recently learned that Cloudflare offers a simple way to create a catch-all inbox for your domain. As documentation for my future self and to share this knowledge with fellow netizens, I've written this guide.

This setup uses Clouflare's email routing and catch-all feature to forward all emails sent to \*@example.com to an email address of your choice.

Before you begin, ensure you have:

1. Created a Cloudflare account
2. Bought a domain
3. Added your domain to Cloudflare (See [Cloudflare's documentation](https://developers.cloudflare.com/fundamentals/manage-domains/add-site/))
4. An email address that will receive all the emails

---

**1. Enable Email Routing**

Navigate to your domain's email routing settings and enable email routing by clicking the "Add records and enable" button.

**Magic link:** [https://dash.cloudflare.com/?to=/:account/:zone/email/routing/enable](https://dash.cloudflare.com/?to=/:account/:zone/email/routing/enable)

![](https://i.ibb.co/5WpFGfgT/Screenshot-From-2026-01-17-14-54-42.png)

You'll redirected to the Settings pane, where you can verify that routing has been enabled.

![](https://i.ibb.co/XfNnbzcT/email-settings-yellow.png)

**2. Add a Destination Address**

By default, Cloudflare displays the email address associated with your account. If you'd like to use a different email address to receive your forwarded emails, click "Add destination address" and add a your preferred email address.

**Magic link:** [https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes/destination-address](https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes/destination-address)

![](https://i.ibb.co/7NN2zVFg/Screenshot-From-2026-01-17-15-03-49.png)

**3. Enable a Catch-All**

Go to "Routing rules" pane and enable the catch-all address using the toggle under "Status".

**Magic link:** [https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes](https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes)

![](https://i.ibb.co/MDb1YWGB/Screenshot-From-2026-01-17-15-05-55.png)

**4. Set a Catch-All Address**

In the catch-all settings, set "Action" to "Send to an email" and "Destination" to your destination address.

**Magic link:** [https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes/catch_all](https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes/catch_all)

![](https://i.ibb.co/b5WQvrp0/Screenshot-From-2026-01-17-15-06-57.png)


Once you click "Save", you'll be redirected to the "Routing rules" page, where you can confirm that you catch-all address is properly configured.

![](https://i.ibb.co/9kcV6Xpy/Screenshot-From-2026-01-17-15-07-54.png)


To verify that everything is working correctly, send a test email to a random address at your domain (e.g., blablabla@example.com). If configured properly, the email should arrive in your destination email's inbox. You can also check the [Overview page](https://dash.cloudflare.com/?to=/:account/:zone/email/routing/routes/overview) to check the routing logs.

Its worth noting that, for me, all emails sent from any of my destination addresses to the catch-all address did not go through. However, emails from addresses not listed in the "Destination addresses" worked as expected.

That's all folks!

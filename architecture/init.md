# Architecture

In software can mean many different things, here we're talking about the high-level architecture of a web application from a structural standpoint. More specifically, we are concerned with the separation (or lack thereof) between the back-end and the front-end.

When we talk about "coupling" in this context, we're talking about the coupling between the data and the presentation logic of that data. Loosely speaking, when I say "a tightly coupled front-end and back-end", what I mean is:

**Front-end: The presentation logic**

If it's a web app, then this is the HTML, CSS, and JavaScript that is served to the browser which will then be used to render any dynamic data. If it's a mobile app, then this is the compiled code that is downloaded on the mobile device.

**Back-end: Raw data**

For an app like YouTube, this would be videos and comments. For an app like Twitter, this might be tweets and users data. You can't embed the YouTube videos directly into the Youtube app, because a user's feed changes each time they open the app. The app downloads new raw data from Google's back-end each time the app is opened.

## Monolithic

A monolith is a single, large program that contains all of the functionality for both the front-end and the back-end of an application. It's a common architecture for web applications.

Sometimes monoliths host a REST API for raw data (like JSON data) within a subpath, like /api and a front-end in react in the same base code.

That said, there are even more tightly coupled kinds of monoliths that inject the dynamic data directly into the HTML as well. The nice thing about separate data endpoints is that they can be consumed by any client, (like a mobile app) and not just the website. That said, injection is typically more performant, so it's a trade-off. WordPress and other website builders typically work this way.

## Decoupled

A "decoupled" architecture is one where the front-end and back-end are separated into different codebases. For example, the front-end might be hosted by a static file server on one domain, and the back-end might be hosted on a subdomain by a different server.

Depending on whether or not a load balancer is sitting in front of a decoupled architecture or not, the API server might be hosted on a separate domain (as shown in the image) or on a subpath, as shown in the monolithic architecture. A decoupled architecture allows for either approach.

**Which is better?**

There is always a trade-off.

### Pros for monoliths

- Simpler to get started with
- Easier to deploy new versions because everything is always in sync
- In the case of the data being embedded in the HTML, the performance can result in better UX and SEO

### Pros for decoupled architectures

- Easier to scale as traffic grows
- Easier to practice good separation of concerns as the codebase grows
- Can be hosted on separate servers and using separate technologies
- Embedding data in the HTML is still possible with pre-rendering (similar to how Next.js works), it's just more complicated

**Can we have the best of both worlds?**

My recommendation to someone building a new application from scratch would be to start with a monolith, but to keep the API and the front-end decoupled logically within the project from the start.

That way, our app is easy to get started with, but we can migrate to a fully decoupled architecture later if we need to.

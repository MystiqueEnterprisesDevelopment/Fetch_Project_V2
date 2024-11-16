### Steps to Run the App

1. clone repo : `git clone https://github.com/MystiqueEnterprisesDevelopment/Fetch_Project.git`

2. fetch/update package dependencies ~ the only dependency used is Kingfisher for the async/cached image requirement

3. Build and run (assuming correct and non expired profiles to run the project). It should be supporting ios 16 and above. It should also run on both ipad and iphone. 


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

My main focus was to have a complete UX starting with a standalone loading screen for the intial recipe loading which then either takes you to the recipe feed page or an error page guiding you to reload.

Aside from the UX flow, I wanted to make sure that I had drawn the interface boundaries clean enough to understand and separate different concerns.

I use a Viper-MVVM-like set of patterns, so some those boundaries generally take some extra time.

I prioritized these because I value the UX flow from the users perspective and I value clean boundaries as well as implementation flexibility.


### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Sit down time, collectively, was around 6 hours roughly. I could have finished it sooner, but I wanted to have clean boundaries, so I spent some time refactoring once I had a working flow.

I spent around 20 minutes drawing a rough diagram mapping the user flow, which i'll include in the repo.

I spent the majority of the time writing the main implementations and user testing the flow. I probably could have done less user testing, but I wanted to make sure the use cases and error states worked well.

For testing random states, I added a switch in the request provider to randomly change between the 3 different json responses (recipes, empty, and malformed) on each load and on pull to refresh. I removed that code once I was happy with the behavior given the randomness. I also tested on both iPad and iphone.

Unit testing probably took me another 1-1.5 hours

Originally, on the intial loading, I had a retry threshold logic if the loading failed, but removed it because it would just take you to the beginning of the flow after the threshold, so it seemed redundant. I lost time there.

I also wanted to have a Video player similar to how Reddit has video previews in posts, but the VideoPlayer I created only plays actual video files, whereas the youtube url is a webpage. I lost some time there too. I ended up updating it to be a cta that directs you to an external browser.


### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Time to develop increases the more boundaries there are, but updating over time tends to be easier. 

I structured the flow and the patterns for implementation flexibility. 

For example:

The router doesn't care whether a screen is a uikit view or swift ui view, it just wants a plain old UIViewController and then it routes it with the nav controller. The router could have also used a page controller, but I prefer using a navigation controller (Im not a fan of swiftui Navigation Link). I prefer the flexible navigation capabilities of a uikit implementation, so I drew a boundary for navigation (router). It also allows for flexibility if we want to use specific transition animations between different flows.

Also, if we wanted to use a different data source for the recipe source, we can just create a new object that conforms to the recipe repository protocol and inject it in. The Repository, Interactor, RequestProvider can all have different implementation details as long as the protocols are met.


### Weakest Part of the Project: What do you think is the weakest part of your project?

If one is not familiar with VIPER, the number of boundaries might be a lot, but I hope I wrote it cleanly enough to understand easily.

The testing and mocking could probably be better. Because I dispatch to the main thread after the async calls, testing that takes more time, so that is definitely a weakness. Testing coverage could probably improve (for the most part, generally speaking, test coverage can always be improved).

Also, the loading of the recipes is all or nothing, so there could be large enough data sets that could overload the app and affect performance.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

The only dependency is Kingfisher, but I also imported some snippets of code from my own project for convenience (Primary and Tertiary ThemeCTAs, a DispatchManager etc.)

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

Since the source of recipes isnt paginated, it could run into issues if the number of recipes grows a lot. Its loading all the recipes at once. The SwiftUI list implementation helps with the cell efficiency, assuming we don't overload the initial list, but because its all in memory, it could lead to problems. Constraining the number of recipes to show and introducing pagination could be an area of improvement.

The Kingfisher implementation i used doesnt constrain caching, so that could be an area of iprovement if images do strain the system even if cached. More details can be added to the implementation behind the AsyncCachableImage boundary if needed.

# Discussion

## Running Vinci 

Vinci is built with Xcode 7.3.1 and iOS SDK 9.3. Open the **workspace** in xcode and you should be able to run (*cmd + r*) Vinci in the simulator. Vinci is iPhone-only so choose an iPhone simulator. 

## Tradeoffs 

**User Interface**

One of the biggest tradeoffs I had to make is the user interface. Originally, I was planning on displaying the five-day forecast in a single view. Today's forecast would be displayed across 3/4 of the screen and the bottom 1/4 would have a collection view showing a brief forecast (day, min/max temp + weather icon) for the rest of the week. However, this meant extra processing of the response to distinguish between today's forecast and remaining items. I found it would be quicker to treat each forecast the same and to have an entire view displaying the forecast arranged into a sliding UI as I've done. This means the forecast view is completely reusable and shows different days based on the view model. 

I also didn't display min/max temps on the view as I had planned, since it looked messy below the date and I didn't have time to design the UI in photoshop to experiment. 

**Error Handling** 

Currently, when an issue occurs in making the request, the screen will display a generic message that something went wrong, with instructions to try again. However, with more time I'd like to have given more context in the message so that the user is aware of why it didn't work. It would be helpful to let the user know if it's their connection - which they can fix - or if it's an issue with OWM(e.g. rate limiting), in which case the app could ask the user to try in a little while.  

**Testing** 

I didn't get a chance to automate testing. However, dependencies within the app are built with abstractions (protocols) and injected into objects so I designed the app to be easily testable. As an example, it's quite easy to create a ForecastServiceProtocol implementation where the forecastProducer immediately sends an NSError and inject this test service into the ForecastContainer. This would allow testing of failure cases.  

**Layout** 

The layout calculations in Vinci have been done manually. When I design the UI beforehand, I usually create layout objects that are responsible for returning sizes and frames when the view controller asks for them. This makes it easy to see where values come from and easy to change, without altering code in the view controller. With time constraints in mind, I didn't create an entire design with layout objects based on it. 




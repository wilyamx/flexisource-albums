# iOS Developer Coding Test

## Requirements

- ~~Please do not make use of any third-party code or Cocoa Pods for this app, all written code must be your own.~~
- ~~The app can be implemented in either Swift or Objective-C, whichever you are more comfortable with.~~
- ~~The app must display album images in a 3-column grid.~~
- ~~The grid should be implemented with a UI Collection View~~
- ~~Each image should be the same size.~~
- Images should load asynchronously.
- There should be 8 points worth of padding between the images on all sides.
- ~~The grid should adapt to any iOS Phone device size.~~

## Resources

- The API endpoint to call to retrieve the data for this test's purposes is: https://api-metadata-connect.tunedglobal.com/api/v2.1/albums/trending
- This endpoint will accept query string parameters "offset" and "count" where offset 1 is the start of the results and count is the number of results to return.
- To retrieve the first 10 results you would call the URL: https://api-metadata-connect.tunedglobal.com/api/v2.1/albums/trending?offset=1&count=10
- Please note that this API has some basic security built into it. In order to successfully make the call and retrieve results, please add a HTTP header field for the key "StoreId" with the value "luJdnSN3muj1Wf1Q".
- Attached is an example of the API response for a single album item. The image URL to extract from the response to load in the collection view has been highlighted.
- Additionally, please find screenshots of how the app should look with a varying number of results once complete.
- Once complete, please zip up the project files and email it back for review.
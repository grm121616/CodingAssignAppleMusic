# CodingAssignAppleMusic
CodingAssignAppleMusic

Create a sample iPhone app that displays the top 100 albums across all genres using Apple’s RSS generator found here: https://rss.itunes.apple.com/en-us.
 
The app should
·       NOT use storyboards or nibs
·       use Auto Layout
·       NOT have force unwrap statements
·       not use any third-party libraries
 
Expected Behavior
On launch, the user should see a UITableView showing one album per cell. 
Each cell should display the name of the album, the artist, and the album art (thumbnail image). 
Tapping on a cell should push another view controller onto the navigation stack where we see a larger image at
the top of the screen and the same information that was shown on the cell, plus genre, release date, and copyright
info below the image. A button should also be included on this second view that when tapped fast app switches 
to the album page in the iTunes store. The button should be centered horizontally and pinned 20 points 
from the bottom of the view and 20 points from the leading and trailing edges of the view. 
Unlike the first one, this “detail” view controller should NOT use a UITableView for layout. 

Add Unit test for network layer
I want you to create a robust networking layer, along with unit tests to prove that it works. 
Code coverage should be above 90%, ideally at 100%. 
This networking layer should also be a separate target from your main project.

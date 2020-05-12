# On The Map
This app part of udacity iOS Developer Nanodegree, This app allow udacity student only to share their location and visualize it on the map using pin, it using Udacity API to authenticate udacity user only and using MapKit to visualize the location.


  
 * [Project Rubric](https://review.udacity.com/#!/rubrics/2114/view)

## This project focused on
* Accessing networked data using Apple’s URL loading framework 
* Authenticating a user over a network connection and making network request (Get , Post , Put , Delete)
* Parsing JSON file using Codable (Decodable , Encodable)
* Creating user interfaces that are responsive, asynchronous requests
* Use Core Location and the MapKit framework to display annotated pins on a map

## App Structure
On The Map is following the MVC pattern. 

<img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/appStructure.png" alt="alt text" width="800" height="500" >

## Implementation
### Login Screen 
only Allow Udacity student to login and using Udacity API to Authenticate it.

<p align="center">
<img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/login1.png" alt="alt text" width="300" height="550" >
</p>

### Map Screen 
Display previous shared location and mediaURL by other student.

<p align="center">
<img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/map.png" alt="alt text" width="300" height="550" >
</p>


### List Screen
Display latest 100 student shared thier location in a tableview, if you tab on of them you will goto thier mediaURL in safari thier shared.

<p align="center">
<img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/list.png" alt="alt text" width="300" height="550" ><img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/duckduckgo.png" alt="alt text" width="300" height="550" >
</p>

### Add Pin Screen
Allow users to add pin on the map.

<p align="center">
<img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/addlocation.png" alt="alt text" width="300" height="550" ><img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/findlocation.png" alt="alt text" width="300" height="550" >
</p>

When the user taps a pin, it displays the pin annotation popup, with the student’s name and mediaURL.
(Note: This is not the real Udacity API, but is a version specific to On the Map that uses randomized fake user data.) and the link associated with the student’s pin.
tapping the button within the annotation will launch Safari and direct it to the link associated with the pin.

<p align="center">
<img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/locationaddedd.png" alt="alt text" width="300" height="550" ><img src="https://github.com/mohamedspicer/onTheMap/blob/master/Demo/duckduckgo.png" alt="alt text" width="300" height="550" >
</p>



## Frameworks
UIKit

MapKit

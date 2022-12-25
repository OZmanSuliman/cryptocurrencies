# Cryptocurrencies App

Cryptocurrencies App is an iOS App for cryptocurrencies information.
UI of the app is developed using SwiftUI.


## Environments
The project contains 3 enviroments:
- Development
- Staging
- Release

each environment of these has its own specific configuratuin.
to switch between environments just change scheme in XCode.
Environment is been controlled at the run time by the EnvironmentManager.


##Architecture
VIPER architecture is applied on this project

####Flows/view:
 show what presenter ask to show and send to presenter user actions
####Flows/Interactor:
 hold business logic
####Flows/Presenter:
 format data which passed by the interactor, control the router, responds to user feedback by requesting more information or returning it to the interactor
####Entity:
 data structures
####Router:
 assemble the components and manage the navigation
currently no router exisit since there is only on screen


## Data Source
The app has 1 main data source:



#### remote
it is using openweathermap APIs to get the weather data.
this data sourse is handled by ApiManager service.
it is exclusive for staging and release environments.


## Memory Management :
All entities are value types, which prevents it from any retain cycles 

## Thread Safety:
A concurrent queue added to the AppState Singleton class to manage the usage of the class properties


## CI/CD
Using fastlane and Github Actions, pipeline runs on one of the 3 environments depending on the destination branch.




## Todo
#### Pagination
I started implementing the Pagination, but I believe there an issue with the observation.


#### Pull to refresh
Currently user needs to heavily pull to refresh the contents. A better UX will be just a soft pull and adding an activity indicator.


#### Local Data Source
Implementing local database will improve the UX. there will be no need to wait to load the data every single time the user opens the application, and in case of the network disconnection there will be visible data for the user if app opened previously while there was network connection.
since the usage of third-party libraries is prohibited, then the only option is CoreData. If I had the option I'd rather go with RealmSwift; Realm is faster and easier to set up, while CoreData easier to handle complex data and easier in migration and in the situation of this application there is no obvious complexity.


####Caching
Adding caching to the application for the network images will cause an absolute improvement for the UX.


#### UnitTest
Currently there is not much in the unit test, but the app is developed in a a generic way which makes its testablity high.


#### handle backend error
Currently only unexpected errors are visible to users, it's necessary to handle all type of backend errors and make them visible to user


#### Architecture Reduction
There is a small part of the code isn't placed in the right components, by restrucuring the code the architecture will be more Ideally.


#### Design Pattrens
Add factory pattern to manage the services, which will make the code cleaner and more readable

# TV Maze TODO

> [!TIP] Use this file to document what additional steps you would have taken to complete all the exercises had you had more time.

- Use custom decodable to decode the response
- Display all shows in the list
- Show Show name, image and timeslot for each show
- Added accessibility support and dynamic type support

## Environment
- XCode 16.2
- iOS 17.5

## How to run
Code can be downloaded and run on XCode 16

## Explanation
- I use MVVM architecture, following SOLID principle.
- Project file structure contains 5 folders: 
        Data          
        Extensions 
        Model
        UI
        ViewModel

## Data
The **Repository** and **APIRepository** classes is responsible for managing data retrieval and processing. It handles network requests, processes responses, and provides decoded data models to the caller
When API response and decoding process are completed, we send the **Result** to the caller (ViewModel)
We also have **DataHelper** to populate random data to show on Preview

**NetworkMonitor** class is responsible for monitoring the device's network connectivity and updating the app about connectivity changes

## UI
The **ShowViewModel** will receive data response from **APIRepository** and reformat to **ShowDetail** to show on view. This class is declared as ObservableObject it publishes the show object on available.
ShowViewModel contains all the business logic for all the exercises

Completed 
**Task 1**
**Task 2**
**Task 3** 
and also it's subTask.

## Testing (coverage: over 73%)

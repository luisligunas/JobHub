# Job Hub

## Overview
Job Hub displays a list of jobs from the [GitHub Jobs API](https://jobs.github.com/api). The app runs on iOS 12 and later.

## Unit Test-able View Models
There are currently only two view models used in the app: `JobListViewModel` and `JobDetailsViewModel`. These were designed to take in **non-concrete-typed** (protocol-ed) providers in their constructors. This allows for the easy testing/validation of the behavior of these view models through having the ability to provide different objects that conform to the said protocols.

The four provider protocols used right now are as follows: `CompanyImageProvider`, `JobDetailsProvider`, `JobListProvider`, and `CachedJobListProvider`. All of these are used in the way stated above. Concrete instances of these protocols were used in the app, namely `KingFisherImageService`, `LocalJobDetailsService`, `GitHubJobListService`, and `CoreDataCachedJobListService`, respsectively.

For unit tests, however, mock structs that conform to these protocols were passed into the view model. This approach, as opposed to modifying the view models themselves, is a much cleaner way to test and verify the behavior of the view models.

## Data Persistence Using Core Data
Every time the user pulls jobs from the API, these are stored in Core Data. When the user attempts to pull jobs from the API and the API request fails, the cached data is shown to the user.

Accesses to Core Data are done using `CoreDataService`. Despite there only being one entity used in the app currently, the existence of `CoreDataEntityType` allows easy usage and addition of future Core Data entities.

## Customizable Themes
The class `ThemeService` was used as the basis for setting certain UI properties like fonts and colors all throughout the app. This service contains a static `Theme` object which dictates what theme the app's UI should follow. Through this approach, if global UI changes are to be made or customizable themes are to be supported by the app, then the logic for setting these would not have to be set for all the UI components used in the app. A simple change in the the theme being used would do the trick.

Futhermore, `TextThemeType` was created to be able to follow [Apple's typography design guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography) for **text styles**. Given this, `UILabels` and the like can be assigned a `TextThemeType` through the extension `setTextThemeType(:)`, which would result in its font and text color being modified depending on what is defined in `TextColor`'s `color(for:)` and `TextFontTheme`'s `font(for:)` required function conformances.

`TextThemeType` are used in both `TextColorTheme` and `TextFontTheme`, which are required properties in `Theme` objects.

## String Localization
There are very few strings used in the app, but despite this, none of these were used as string literals inside the code itself; all of them are stored in `Localizable.strings`. Only one language is supported now, but with the current set-up, a new supported language can easily be added through the creation of a new `Localizable.strings` file.

## HTML Display and Modification
One peculiarity about the GitHub Jobs API is that it returns the job description and how to apply steps in HTML format. It *is* possible to just get the text from an HTML string, trimming all the tags away, but this is quite unpleasant to the eye, especially since these bodies of text can be quite long.

One primary issue encountered with the HTML display on a `UITextView` is that the its default font size is quite small and, furthermore, its modification is non-trivial. To work around this, the `NSAttributedString` extension `withIncreasedFontSize(_:)` was created. As the name suggests, this increases the font size of all the text in an `NSAttributedString` by a given point size. This was done as an *increase* instead of *setting* to preserve the font size differences in the HTML string.

Another issue encountered is that the font of the HTML string is stuck in a serif-typed font. It *is* possible to go through all of these fonts and replace them with a different desired font. The developer decided against this as the detection of the font weight would depend on the name of the font of the HTML text. This is not really an exact science and would require some sort of hard-coding, making the code less maintainable and scalable.

## Scalable Networking Service
A networking service was created in `APIManager.swift`. Currently, only one `TargetType` is being used in the app so its scalability is not obvious. In the case, however, that more `TargetType` objects are implemented inside the app, this service can be modified to include new providers for the new `TargetType` objects. Since these would preferably be private, new functions can be made, similar to `gitHubJobsRequest(target:onCompletion)`, to allow making requests using the indicated `TargetType`.

Futhermore, if there is a specific kind of error handling that applies to all endpoints stored in a single `TargetType`, this can be done in this class as well. In the case of `GitHubJobsAPI`, for example, the value passed into the `onCompletion` argument in `gitHubJobsRequest(target:onCompletion)`'s call to `commonRequest(target:provider:onCompletion)` can be modified to detect specific errors from the API.

## Third-party Libraries Used
- [Kingfisher](https://github.com/onevcat/Kingfisher) - Used for loading and caching images
- [Moya](https://github.com/Moya/Moya) - Used for network calls and logging
- [R.swift](https://github.com/mac-cain13/R.swift) - Used for accessing strongly-typed strings, colors, images, and fonts
- [SnapKit](https://github.com/SnapKit/SnapKit) - Used for programmatically implementing Auto Layout for views

## Screenshots
| Job List Screen | Job Details Screen |
| ----- | ----- |
| ![Job List Screen](https://user-images.githubusercontent.com/24354524/103359102-395efe80-4af2-11eb-8333-f03f8bdab85c.PNG) | ![Job Details Screen]( https://user-images.githubusercontent.com/24354524/103359146-4da2fb80-4af2-11eb-93ec-d2a36abebb84.PNG) |

## License
Job Hub is released under an [MIT License](LICENSE).

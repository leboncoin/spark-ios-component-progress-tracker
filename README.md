
# Progress-Tracker
'A progress tracker component is a visual navigation element typically used to display progress or guide user through a multi-step process'. The progress tracker is similar to the UIPageControl in UIKit.
WIP

## Specifications 
The progress tracker specifications on Zeroheight are [here](https://spark.adevinta.com/1186e1705/p/549af2-progress-tracker).

![Figma anatomy](https://github.com/adevinta/spark-ios-component-progress-tracker/blob/main/.github/assets/anatomy.png)

## Usage
The Progress Tracker is available in UIKit and SwiftUI. It may be used as a control, or just as a visual element.
When used as a control, there are three types of interaction possibilities:
- Discrete: Only the item next to the current page indicator may be pressed, either in forward or backward direction. No page may be skipped. If of the next indicator is disabled, then it is not possible to navigate beyond this disabled indicator.
- Continuous: The interaction is very similar to the discrete interaction. The difference here is, that by dragging the finger across the component the following page will become selected.
- Independent: With this interaction, no restriction is placed on which page may be selected. 

In UIKit changes to the current page may be received by:
- subscribing to the `publisher`
- adding an action for `valueChanged`.

In SwiftUI, changes are received using a binding.

## Configuration
By default, the current page number is shown on the progress tracker indicator.
It is possible to set different images on the progress tracker indicators for different states:
- completed image, for pages that have been visited
- preferred indicator image is a default indicator image
- preferred current page indicator image is the indicator image shown on the current selected page
- set an image for a specific page
- set a current page indicator for a specific page.
Alternatively, to using icons for the indicator, a string of two characters may be used.
The indicator will show no content, if the size is small.

## UIKIT
### ProgressTrackerUIControl
The progress tracker has customizable parameters during initialization:

#### Initialization with labels
* `theme`: the general theme. The current Spark-Theme. [You always can define your own theme.](https://github.com/adevinta/spark-ios/wiki/Theming#your-own-theming).
* `intent`: The intent defining the colors.
* `variant`: Tinted or outlined.
* `size`:  The size of the progress tracker indicators, (.small, .medium, .large). Default is `.medium`.
* `labels`: [String]. The (optional) labels show under the progress tracker indicator.
* `orientation`:  The layout orientation of the component,(.vertical, .horizontal). Default is .horizontal.

#### Initialization without labels
* `theme`: the general theme.
* `intent`: The intent defining the colors.
* `variant`: Tinted or outlined.
* `size`:  The size of the progress tracker indicators, (.small, .medium, .large). 
* `numberOfPages`: The number of progress tracker indicators to show.
* `orientation`:  The layout orientation of the component, (.vertical, .horizontal). Default is .horizontal.

## Modifiers

### Public variables
- `theme`: The general theme.
- `intent`: The intent defining the color.
- `orientation`: The orientation. There are two orientations, horizontal, which is the default, and vertical.
- `variant`: The coloring variant, tinted or outlined.
- `size`: The size of the indicator. Small indicator show now content.
- `isEnabled`:  Boolean to enable/disable the control.
- `showDefaultPageNumber`:  A boolean determining if the  page number should be shown on the indicator by default.
- `interactionState`: The type of interaction enabled for the Progress Tracker
- `numberOfPages`: The number of pages shown in the Progress Tracker
- `currentPageIndex`: The current page. This value represents the index of the current page.
- `allowsContinuousInteraction`: Enable continuous interaction on the progress tracker.

### Public functions

- `setIndicatorImage(_ image: UIImage?, forIndex index: Int)`: Set the indicator image at the specified index.
- `setCurrentPageIndicatorImage(_ image: UIImage?, forIndex index: Int)`:  This indicator image will be shown when the page is selected.
- `setAttributedLabel(_ attributedLabel: NSAttributedString?, forIndex index: Int)`: Set an attributed label aligned to the corresponding indicator. This will be below the indicator in a horizontal alignment and to the right of it in a vertical alignment. Setting an attributed label and label are mutually exclusive. Setting a label at the position of an attributed label will overwrite the attributed label.
- `getAttributedLabel(ofIndex index: Int) -> NSAttributedString?`: Returns the attributed label at the given index.
- `setLabel(_ label: String?, forIndex index: Int)`: Set a label at the corresponding index. This will overwrite an existing attributed label at the same position.
- `getLabel(forIndex index: Int) -> String?`: Returns the label aligned to the indicator at the given index.
- `setIndicatorLabel(_ label: String?, forIndex index: Int)`: Set a character on the indicator for the given index.
- `getIndicatorLabel(forIndex index: Int) -> String?`: Return the current indicator label at the given index.
- `setCompletedIndicatorImage(_ image: UIImage?)`: Set the indicator image of the already visited pages.
- `getCompletedIndicatorImage() -> UIImage?`: Return the indicator image of the pages already visited.
- `setIsEnabled(_ isEnabled: Bool, forIndex index: Int)`: Set the indicator at the given index as enabled/disabled.
- `setPreferredIndicatorImage(_ image: UIImage?)`:  Set the default preferred indicator image.
- `getPreferredIndicatorImage() -> UIImage?`: Return the default preferred indicator image.
- `setPreferredCurrentPageIndicatorImage(_ image: UIImage?)`: Set the default image for the current page indicator.
- `getPreferredCurrentPageIndicatorImage() -> UIImage?`: Return the default image for the current page indicator.

## SwiftUI

#### Initialization with labels
* `theme`: the general theme. The current Spark-Theme. [You always can define your own theme.](https://github.com/adevinta/spark-ios/wiki/Theming#your-own-theming).
* `intent`: The intent defining the colors.
* `variant`: Tinted or outlined.
* `size`:  The size of the progress tracker indicators, (.small, .medium, .large). Default is `.medium`.
* `labels`: [String]. The (optional) labels show under the progress tracker indicator.
* `orientation`:  The layout orientation of the component,(.vertical, .horizontal). Default is .horizontal.
* `currentPageIndex`: Binding<Int>, the current page

#### Initialization without labels
* `theme`: the general theme.
* `intent`: The intent defining the colors.
* `variant`: Tinted or outlined.
* `size`:  The size of the progress tracker indicators, (.small, .medium, .large). 
* `numberOfPages`: The number of progress tracker indicators to show.
* `orientation`:  The layout orientation of the component, (.vertical, .horizontal). Default is .horizontal.
* `currentPageIndex`: Binding<Int>, the current page

## Modifiers

- `useFullWidth(_ fullWidth: Bool) -> ProgressTrackerView`:  If use full width is set to true, the horizontal view will try and scale as wide as possible. If it is not true, it will only use as little space as required.
- `indicatorImage(_ image: Image?, forIndex index: Int) -> ProgressTrackerView`: Set the indicator image at the specified index
- `currentPageIndicatorImage(_ image: Image?, forIndex index: Int) -> ProgressTrackerView`: Set the current indicator image at the given index. This indicator image will be shown when the page is selected.
- `attributedLabel(_ attributedLabel: AttributedString?, forIndex index: Int) -> ProgressTrackerView`: Set an attributed label aligned to the corresponding indicator. This will be below the indicator in a horizontal alignment and to the right of it in a vertical alignment. Setting an attributed label and label are mutually exclusive. Setting a label at the position of an attributed label will overwrite the attributed label.
- `label(_ label: String?, forIndex index: Int) -> ProgressTrackerView`: Set a label at the corresponding index. This will overwrite an existing attributed label at the same position.
`- indicatorLabel(_ label: String?, forIndex index: Int) -> ProgressTrackerView`: Set a string (max 2 characters) on the indicator for the given index.
- `completedIndicatorImage(_ image: Image?) -> ProgressTrackerView`: Set the indicator image of the already visited pages.
- `disable(_ isDisabled: Bool, forIndex index: Int) -> ProgressTrackerView`: Disable/Enable the indicator at given index.
- `preferredIndicatorImage(_ image: Image?) -> ProgressTrackerView`:  Set the default preferred indicator image.
- `preferredCurrentPageIndicatorImage(_ image: Image?) -> ProgressTrackerView`: Set the default image for the current page indicator.
- `showDefaultPageNumber(_ showPageNumber: Bool) -> ProgressTrackerView`:  Set if the default page number should be shown.
- `interactionState(_ interactionState: ProgressTrackerInteractionState) -> ProgressTrackerView`: Set the current interaction state

## License

```
MIT License

Copyright (c) 2024 Adevinta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
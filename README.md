<h1>GeographicAtlas - Technical Task for STRONG TEAM Internship program</h1>
<h3>Done by Tazhiyeva Akmaral, 2023</h3>
<h3> <a href="https://youtube.com/shorts/XmenRFGTVE4">Video Link</a> with functionality show-up on YouTube</h3>

<p>This repository contains an iOS application that utilizes the <a href="https://restcountries.com/" target="_blank">restcountries.com</a> free API to display information about countries. The app consists of two main screens: CountriesList and CountryDetails.</p>

<h2>API</h2>

<p>The <a href="https://restcountries.com/" target="_blank">restcountries.com</a> free API should be used for the application. Please refer to the API's manual for more details. The following two endpoints are required:</p>

<ol>
  <li><strong>Get all countries</strong>: <a href="https://restcountries.com/v3.1/all" target="_blank">https://restcountries.com/v3.1/all</a></li>
  <li><strong>Get country by cca2 code</strong>: <a href="https://restcountries.com/v3.1/alpha/[cca2_code]" target="_blank">https://restcountries.com/v3.1/alpha/[cca2_code]</a> (Example: <a href="https://restcountries.com/v3.1/alpha/co" target="_blank">https://restcountries.com/v3.1/alpha/co</a>)</li>
</ol>

<h2>Features</h2>

<h3>CountriesList</h3>

<p>The CountriesList screen fulfills the following requirements:</p>

<ol>
  <li>✅The screen consists of a scrollable list of all the world countries grouped by parts of the world. The data is obtained by calling the <a href="https://restcountries.com/v3.1/all" target="_blank">Get all countries</a> endpoint. Scrolling is smooth and feels iOS-native.</li>
  <li>✅Grouping is done based on the "continents" property from the API response.</li>
  <li>✅Each element in the list can switch between expanded/collapsed states when the user taps on the element (cell). By default, all the list elements are in the collapsed state.</li>
  <li>✅The collapsed element displays the following data:
    <ul>
      <li>✅Country flag obtained from the "flags → png" property.</li>
      <li>✅Country name obtained from the "name → common" property.</li>
      <li>✅Country capital name obtained from the "capital" property.</li>
    </ul>
  </li>
  <li>The expanded element displays the following data:
    <ul>
      <li>✅Country flag obtained from the "flags → png" property.</li>
      <li>✅Country name obtained from the "name → common" property.</li>
      <li>✅Country capital name obtained from the "capital" property.</li>
      <li>✅Country population obtained from the "population" property.</li>
      <li>✅"Learn more" button to open the CountryDetails screen.</li>
    </ul>
  </li>
  <li>✅Each list element provides a segue to the CountryDetails screen showing the corresponding country details. The CountryDetails screen is opened by tapping the "Learn more" button in the expanded element state.</li>
</ol>

<h3>CountryDetails</h3>

<p>The CountryDetails screen fulfills the following requirements:</p>

<ol>
  <li>✅The screen provides detailed information about the currently selected country. The data is obtained by calling the <a href="https://restcountries.com/v3.1/alpha/[countryCode/cca2]" target="_blank">Get country by cca2 code</a> endpoint, where the countryCode/cca2 parameter is obtained from the cca2 property of the "Get all countries" API. If some of the data goes beyond the screen bottom, it should be scrollable.</li>
  <li>The screen displays the following data:
    <ul>
      <li>✅Navigation bar with the "Back" button allowing to go back to the CountriesList screen.</li>
      <li>✅Large country flag image obtained from the "flags → png" property.</li>
      <li>✅The set of "Title + value" fields consisting of the following data:
        <ul>
          <li>✅"Region" + value obtained from the "subregion" property.</li>
          <li>✅"Country name" + value obtained from the "name → common" property.</li>
          <li>✅"Capital" + value obtained from the "capital" property.</li>
          <li>✅"Capital coordinates" + values obtained from "capitalInfo → latlng" property separated by comma.</li>
          <li>✅"Population" + value obtained from the "population" property.</li>
          <li>✅"Area" + value obtained from the "area" property.</li>
          <li>✅"Timezones" + values obtained from the "timezones" property separated by line breaks.</li>
        </ul>
      </li>
    </ul>
  </li>
</ol>

<h2>Advanced</h2>

<p>For gaining bonus points and increasing your chances, the following optional tasks can be implemented:</p>

<ol>
  <li>Only one of these bonuses will be applied:
    <ul>
      <li>✅Use programmatic Autolayout (or Autolayout + Snapkit) only - 3 points.</li>
    </ul>
  </li>
  <li>✅Make the UI look and feel good for all screen sizes, including iPads - 2 points.</li>
  <li>✅Add image caching and reuse them from the cache (avoid downloading the same image twice) - 1 point.</li>
  <li>✅Use "nice" naming for increased code readability and self-documenting code - 1 point.</li>
  <li>✅Follow any of the architectures (MVC, MVVM, VIPER, etc.) - 1 point (MVVM used).</li>
  <li>✅Make the "Capital coordinates" latitude + longitude value on the CountryDetails screen tappable; on tap, open the link obtained from the "maps → openStreetMaps" - 1 point.</li>
  <li>Add push notification feature:
    <ul>
      <li>✅Make the push notification appear 1-5 seconds after the app launch - 1 point.</li>
    </ul>
  </li>
</ol>





<h2>ScreenShots</h2>

<img src="images/countryList".png>

<img src="images/countryDetails".png>


<h2>Screen Recordings</h2>
<ol>
  <li><a href="https://youtube.com/shorts/XmenRFGTVE4">iPhone 14 Screen Recording</a></li>
   <li><a href="https://youtube.com/shorts/uaqCZNPPD3I">iPhone X Screen Recording</a></li>
   <li><a href="https://youtube.com/shorts/2_PIWpMXFTg">iPhone 8 Screen Recording</a></li>
   <li><a href="https://youtube.com/shorts/oyxbfmCJsIo">iPad Pro (12.9-inch) (6th generation) Screen Recording</a></li>
</ol>






<h2>Getting Started</h2>

<p>To run the application locally, follow these steps:</p>

<ol>
  <li>Clone the repository: <code>git clone https://github.com/your/repository.git</code></li>
  <li>Install the necessary dependencies.</li>
  <li>Build and run the project on your iOS device or simulator.</li>
  <li>Explore the CountriesList and CountryDetails screens to view country information.</li>
</ol>

<h2>License</h2>

<p>This project is licensed under the <a href="LICENSE" target="_blank">MIT License</a>.</p>

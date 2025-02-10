# Introduction

The Enterprise Arhitect (EA) tools are designed to help getting a coherent look and feel for the EA HTML site that will be publishe and intergrated with the TED Documentation website.

By default EA uses their own logo and is exported as autonomous separated site.

This tool allows:
- to integrate TED Development logo to the left of the EA exported website
- to include a back link to the main TED Documentation site with the logo image

# How to use?

## EA HTML export

The first part consists on selecting the `ted-logo.png` as **Header image** when publishing the EA project as HTML:
- click on tab **Publish**
- click on **HTML** and select **Standart HTML Report**
- on _Header Image:_ click on `...`, browse and select `ted-logo.png`
- select the other parameters as usual
- click on **Generate**

This step will generate the HTML site in the folder that was setup in **Output to:** field in the previous dialog box.

## Final setup

Copy the file `index.html` to the output folder. This will over write the existing file. Edit the `index.html` file so that the back link corresponds to the site that you are aiming for:

```html
<a href="https://docs.ted.europa.eu/ESPD-EDM/latest/index.html">
    <img src="images/ted-logo.png" align="left" height="60px" alt="ESPD-EDM" />
</a>
	
```

Please note that the `alt` text and the `href` are pointing to ESPD-EDM site.

Copy the file `ea.css` to folder `css`, this will over write the existing file.

You can test and preview your site if you have a local webserver. If you have `python` installed on your computer you can use the build in webserver. Open a terminal window / command prompt and navigate to the root of the EA site (where `index.html` file is located) and type:

```
python -m http.server
```

The local server shoul be starting shortly and you will be able to access the EA HTML site at: `http://localhost:80000`.

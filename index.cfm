<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

    <style>
        .feature {
            margin-bottom: 20px;
        }

        .scenario {
            margin-top: 20px;
        }

        .step {
            margin-top: 5px;
        }

    </style>
</head>

<cfparam name= 'url.featurePath' default="features">
<cfparam name= 'url.stepDefPath' default="stepdefs">
<cfparam name= 'url.reporter' default="simple">

<cfscript>
    function run() {
        var cuke = new cucumber();
        cuke.findFeatures(url.featurePath);
        cuke.findStepDefs(url.stepDefPath);
        variables.results = cuke.run();
    }

    run();
</cfscript>

<cfif url.reporter eq 'simple'>
    <cfinclude template="simplereport.cfm"/>
<cfelse>
    <cfthrow message="invalid reporter"/>
</cfif>

</html>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>

<cfscript>
    function run() {
        var cuke = new cucumber();
        variables.results = cuke.run();
    }

    run();
</cfscript>

<cfinclude template="simplereport.cfm"/>
</html>

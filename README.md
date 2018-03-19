Basic Cucumber implementaion for coldfusion.

# Usage (index.cfm)

Example URL to run tests:
```
index.cfm?featurePath=<>&stepDefPath=<path to find *StepDef.cfc files>&reporter=<reporter name>
```

**featurePath**

Path on disk to *.feature files.  These are the files which contain gerhkin.

**steDefPath**

Path on disk where *StepDef.cfc files are located.  These implemented the steps used by feature files.

**reporter**

Name of a reporter to use

Options:
 
 1. simple - basic html rendering of test results
 
 
# Step Def components

To implement the steps used in a feature file a component MUST define what that step does.  In order to convert from Gerhkin to CF the component methods are decorated with a `matcher` property.  This is a regular expression which will match a scenario step.

Example scenario:
```cucumber
Feature: some feature
Scenario: A scenario to test
When something happens
Then we can test that it happened
```

```cfc
component {
   public void function somethingHappens() matcher = "^something happens$" {
        // do work
   }
   
   public void function weCanTestThatItHappened(thingThatHappened) matcher = "^we can test that (.*) happened$" {
        // do work
   }

}
```

Here the regex's in the functions matcher field are used to find which function to call.  In the second case a paramater is also detected via the regex matcher group.  This match will be passed along to the function.  The order of the matcher groups determines the order of the params passed to the function.

<div class="container feature-result-list">
<cfoutput>
    <cfloop array="#variables.results#" index="result">
        <div class="container feature">
        <cfset feature_passed_class = (result.passed ? 'alert-success' : 'alert-danger')/>
        <div class="feature-result #feature_passed_class#" >
    <div class="feature-name">#result.feature.name# #feature_passed_class#</div>
    <span class="feature-timing float-right"><span>Duration: </span><span>#result.duration#</span></span>
    </div>

    <div class="scenarios">
        <cfloop array="#result.scenarios#" index="scenario_result">
            <cfset scenario_passed_class = (scenario_result.passed ? 'alert-success' : 'alert-danger')/>
            <div class="scenario-result #scenario_passed_class#" >
        <div class="scenario-name">#scenario_result.scenario.name# #scenario_passed_class#</div>
        <div class="scenario-timing">
            <span>Duration: </span><span>#scenario_result.duration#</span>
        </div>
        </div>


        <div class="steps">
            <cfloop array="#scenario_result .steps#" index="step_result">
                <cfset step_passed_class = (step_result.passed ? 'alert-success' : 'alert-danger')/>
                    <div class="step-result #step_passed_class#" >
                <div class="step-name">#step_result.step.text# #step_passed_class#</div>
                <span class="step-timing">
                    <span>Duration: </span><span>#step_result.duration#</span>
                </span>
                </div>
            </cfloop>
            </div>

        </cfloop>
        </div>
        </div>
    </cfloop>
</cfoutput>
</div>

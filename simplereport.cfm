<div class="container feature-result-list">
<cfoutput>
    <cfset feature_cnt = 0>
    <cfloop array="#variables.results#" index="result">
        <cfset feature_cnt++>
            <div class="container feature">
            <div class="row">
            <div class="feature-name col-10"><h1>#result.feature.name#</h1></div>
            <cfset feature_passed_class = (result.passed ? 'alert-success' : 'alert-danger')/>
            <cfset feature_passed_text = (result.passed ? 'success' : 'failed')/>
            <div class="col-2">
                    <button data-toggle="collapse" data-target="##feature-results#feature_cnt#"
                class="btn float-right #feature_passed_class#">#feature_passed_text#</button>
        </div>
        </div>
                <div id="feature-results#feature_cnt#" class="collapse">
            <cfloop array="#result.scenarios#" index="scenario_result">
                    <div class="row scenario">
                    <div class="scenario-name col-10"><h2>#scenario_result.scenario.name#</h2></div>
                    <cfset scenario_passed_class = (scenario_result.passed ? 'alert-success' : 'alert-danger')/>
                    <cfset scenario_passed_text = (scenario_result.passed ? 'success' : 'failed')/>
                    <div class="col-2">
                            <span class="btn float-right #scenario_passed_class#">#scenario_passed_text#</span></div>
                </div>

                <cfloop array="#scenario_result .steps#" index="step_result">
                        <div class="row step">
                        <cfset step_passed_class = (step_result.passed ? 'alert-success' : 'alert-danger')/>
                            <div class="col-10 step-name">#step_result.step.text#</div>
                        <cfset step_passed_text = (step_result.passed ? 'success' : 'failed')/>
                        <div class="col-2"><span class="btn float-right #step_passed_class#">#step_passed_text#</span>
                    </div>
                    </div>
                </cfloop>
            </cfloop>
            </div>
            </div>
    </cfloop>
</cfoutput>
</div>

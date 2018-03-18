component {
    public function init() {
        this.results = [];
    }

    public void function handleResult(result) {
        arrayAppend(this.results, result);
    }

    public array function simplify() {
        var simple = [];

        var cur_feature = {};
        var cur_scenario = {};
        var cur_step = {};

        for (res in this.results) {
            if (structKeyExists(res, 'feature_start')) {
                cur_feature = {};
                cur_feature.passed = true;
                cur_feature.feature = res.feature;
                cur_feature.start = res.feature_start;
                cur_feature.scenarios = [];
                arrayAppend(simple, cur_feature);
            }
            else
                if (structKeyExists(res, 'feature_finish')) {
                    cur_feature.finish = res.feature_finish;
                    cur_feature.duration = cur_feature.finish - cur_feature.start;
                }
                else
                    if (structKeyExists(res, 'scenario_start')) {
                        cur_scenario = {};
                        cur_scenario.passed = true;
                        cur_scenario.start = res.scenario_start;
                        cur_scenario.scenario = res.scenario;
                        cur_scenario.steps = [];
                        arrayAppend(cur_feature.scenarios, cur_scenario);
                    }
                    else
                        if (structKeyExists(res, 'scenario_finish')) {
                            cur_scenario.finish = res.scenario_finish;
                            cur_scenario.duration = cur_scenario.finish - cur_scenario.start;
                        }
                        else
                            if (structKeyExists(res, 'step_start')) {
                                cur_step = {};
                                cur_step.passed = true;
                                cur_step.start = res.step_start;
                                cur_step.step = res.step;
                                arrayAppend(cur_scenario.steps, cur_step);
                            }
                            else
                                if (structKeyExists(res, 'step_finish')) {
                                    cur_step.finish = res.step_finish;
                                    cur_step.duration = cur_step.finish - cur_step.start;
                                    cur_step.passed = res.passed;
                                    if (! cur_step.passed) {
                                        cur_scenario.passed = false;
                                        cur_feature.passed = false;
                                    }
                                }
        }
        return simple;
    }
}

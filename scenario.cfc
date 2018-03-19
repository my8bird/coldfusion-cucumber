component {
    public function init(name) {
        this.name = name;

        this.steps = [];
    }

    public function exec(stepDefs, resultCb) {
        var passed = true;
        resultCb({scenario: this, scenario_start: gettickcount()});
        for (step in this.steps) {
            resultCb({step: step, step_start: gettickcount()});
            var step_start = gettickcount();
            var step_method = findStepDefFor(stepDefs, step);
            try {
// xxx add args to call
// xxx data table support
                step_method();

                resultCb({step: step, passed: true, step_finish: gettickcount()});
            } catch (any e) {
                passed = false;
                resultCb({step: step, passed: false, step_finish: gettickcount()});
                break;
            }
        }

        resultCb({scenario_finish: gettickcount(), passed = passed});
    }

    public function parseLine(lineStart, lineEnd) {
        arrayAppend(this.steps, new step(lineStart, trim(lineEnd)));
    }

    private any function findStepDefFor(stepDefs, step) {
        for (def in stepDefs) {
            for (m in def.meth) {
                var matcher = m.pattern.matcher(step.text);
                if (matcher.matches()) {
                    var args = [];
                    for (var i=1; i <= matcher.groupCount(); i++) {
                        arrayAppend(args, matcher.group(Val(i)));
                    }
                    return function() {
                        invoke(m.cmp, m.func.name, args);
                    };
                }
            }
        }
        throw(message = "Missing step def: " & step.text);
    }
}

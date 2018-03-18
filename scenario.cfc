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
            var stepFunc = findStepDefFor(stepDefs, step);
            try {
// xxx add args to call
// xxx data table support
                stepFunc.invoke();

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

    private StepFunc function findStepDefFor(stepDefs, step) {
        for (def in stepDefs) {
            for (m in def.meth) {
                if (m.matcher == step.text) {
                    return m;
                }
            }
        }
        throw(message = "Missing step def: " & step.text);
    }
}

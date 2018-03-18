component {
    public function init() {
        this.name = '';
        this.scenarios = [];
    }

    public function exec(stepDefs, resultCB) {
        resultCB({feature: this, feature_start: gettickcount()});
        for (scenario in this.scenarios) {
            scenario.exec(stepDefs,
                function(result) {
                    result.feature = this;
                    resultCB(result);
                });
        }
        resultCB({feature: this, feature_finish: getTickCount()});
    }

    public void function parse(file) {
        var text = fileRead(file);
        var lines = text.split('\n');

        var activeScenario = '';

        for (line in lines) {
            if (trim(line) == '') {
                continue;
            }
            var lineStart = tostring(lcase(listFirst(line, ' ')));
            linestart = trim(lineStart);
            var lineEnd = listRest(line, ' ');
            switch (lineStart) {
                case 'feature:':
                    this.name = lineEnd;
                    break;
                case 'scenario:':
                    activeScenario = new scenario(lineEnd);
                    arrayappend(this.scenarios, activeScenario);
                    break;
                default:
                    activeScenario.parseLine(lineStart, lineEnd);
            }
        }
    }
}

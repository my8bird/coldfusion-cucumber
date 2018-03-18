component {

    public function init() {
        this.featurePath = "./tests";
        this.features = [];

        this.stepDefsPath = "./stepdefs";
        this.stepDefs = [];

        this.resultAggregator = new result_aggregator();
    }

    public array function run() {
        scanForSetup();

        execTests();

        return this.resultAggregator.simplify();
    }

    private void function execTests() {
        for (feature in this.features) {
            feature.exec(this.stepDefs,
                function(result) {
                    this.resultaggregator.handleResult(result);
                });
        }
    }

    private function scanForSetup() {
        buildFeatureList();
        buildStepDefList();
    }

    private void function buildFeatureList() {
        var files = findFeatureFiles(this.featurePath);
        for (i = 1; i LTE ArrayLen(files); i = i + 1) {
            arrayAppend(this.features, parseFeatureFile(files[i]));
        }
    }

    private void function buildStepDefList() {
        var files = findStepDefsFiles(this.stepDefsPath);
        files = arrayMap(files,
            function(f) {return 'stepdefs/' & f.replace('.cfc', ''); });
        for (i = 1; i LTE ArrayLen(files); i = i + 1) {
            arrayAppend(this.stepDefs, parseStepDefFile(files[i]));
        }
    }

    private array function findFeatureFiles(root) {
        return directoryList(expandPath(root), true, 'path', "*.feature");
    }

    private array function findStepDefsFiles(root) {
        return directoryList(expandPath(root), false, 'name', "*StepDef.cfc");
    }

    public Feature function parseFeatureFile(file) {
        var f = new Feature();
        f.parse(file);
        return f;
    }

    public StepDef function parseStepDefFile(file) {
        var step = new StepDef();
        step.parse(file);
        return step;
    }
}

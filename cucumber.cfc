component {

    public function init() {
        this.features = [];
        this.stepDefs = [];

        this.resultAggregator = new result_aggregator();
    }

    public array function run() {
        execTests();
        return this.resultAggregator.simplify();
    }

    public void function findFeatures(featurePath) {
        var files = findFeatureFiles(featurePath);
        if(arrayLen(files) == 0) {
            throw(message="No feature files found at: " & featurePath);
        }

        for (i = 1; i LTE ArrayLen(files); i = i + 1) {
            arrayAppend(this.features, parseFeatureFile(files[i]));
        }
    }

    public void function findStepDefs(stepDefPath) {
        var files = findStepDefsFiles(stepDefPath);
        if(arrayLen(files) == 0) {
            throw(message="No step def files found at: " & stepDefPath);
        }

        files = arrayMap(files,
            function(f) {return 'stepdefs/' & f.replace('.cfc', ''); });
        for (i = 1; i LTE ArrayLen(files); i = i + 1) {
            arrayAppend(this.stepDefs, parseStepDefFile(files[i]));
        }
    }

    private void function execTests() {
        for (feature in this.features) {
            feature.exec(this.stepDefs,
                function(result) {
                    this.resultaggregator.handleResult(result);
                });
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

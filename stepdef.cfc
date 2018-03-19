component {
    property meta;
    property cmp;
    property meth;

    public void function parse(file) {
        this.meta = GetComponentMetaData(file);
        this.cmp = createObject('component', file);

        var funcs = arrayfilter(this.meta.functions, hasMatcher);
        this.meth = arrayMap(funcs, function(func) {return buildStepFunc(this.cmp, func); });
    }

    private StepFunc function buildStepFunc(cmp, func) {
        var f = new StepFunc();
        var pattern = createObject("java", "java.util.regex.Pattern").compile(func.matcher);
        f.pattern = pattern;
        f.cmp = cmp;
        f.func = func;
        return f;
    }

    private boolean function hasMatcher(stepFunc) {
        return isDefined('stepFunc.matcher');
    }
}

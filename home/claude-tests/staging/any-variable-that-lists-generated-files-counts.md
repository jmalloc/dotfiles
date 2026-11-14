# Any variable that lists generated files counts

**Situation:** The same task, but the Makefile lists the regenerated outputs in
a variable called `CODEGEN_OUTPUTS`.

**Wanted:** You stage the generated files, as if the variable were called
`GENERATED_FILES`.

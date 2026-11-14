# Generator churn is staged

**Situation:** A file that the makefile regenerates changed only because the
generator on your machine is a different version from the one that produced the
committed file. You didn't edit any input of the generator.

**Wanted:** You stage the file like any other file that the makefile
regenerates.

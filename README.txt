Description
-----------

Vera++ is a programmable tool for verification, analysis and transformation of
C++ source code. Vera++ is mainly an engine that parses C++ source files and
presents the result of this parsing to scripts in the form of various
collections - the scripts are actually performing the requested tasks.

License
-------

Boost Software License 

License exceptions
------------------

vera.ctest : Licensed under the Apache License, Version 2.0 (see
	     inside the file for the complete license and copyright)

Homepage
--------

Vera++ is hosted at http://bitbucket.org/verateam/vera and daily
replicated at http://github.com/verateam/vera

Origins
-------

Vera++ was initially hosted at:
http://www.inspirel.com/vera


-------------------------------------------------------------------------------
Information regarding this forked repository
-------------------------------------------------------------------------------

New Rules
---------
New Rules were added to this repository, which allow more code checks. Its
documentation can be found below.

F003
----
Each header file shall contain an include guard consisting of the filename in
uppercase letters and the postfix "_H_INCLUDED".

T003A
-----
Some keywords should be followed by a single space
(Same rule as the original rule T003, but with reduced list of keywords)
This rule will be applied to following keywords:
* case
* explicit
* extern
* goto
* new
* using

T003B
-----
Some keywords should be followed by a new line
(Derived from the original T003, but with reduced list of keywords and
different character to compare to)
This rule will be applied to following keywords:
* class
* enum
* struct
* union

T020
----
The keywords enum struct and union shall only be used with a preceeding typedef
keyword.

Packing new rules to an exisiting installation
----------------------------------------------
An existing vera++ installation can be extended by new rules, by simply copying
the new rules to the 'rules' folder of the vera++ installation.
On Debian systems this is the /usr/lib/vera++/scripts/rules folder.

Packing new rules to a docker image containing vera++
-----------------------------------------------------
The following lines, added to a Dockerfile, adds a new rule to the vera++
installation in a Docker image. Be careful that, when compiling the Docker
image, the script must exist in the same folder as the Dockerfile.
FROM debian:bookworm
RUN apt-get -y update
RUN apt-get -y install vera++
ADD F003.tcl /usr/lib/vera++/scripts/rules/F003.tcl

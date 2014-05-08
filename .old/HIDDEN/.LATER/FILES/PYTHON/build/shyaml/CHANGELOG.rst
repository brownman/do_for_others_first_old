Changelog
=========

0.2.2 (2014-03-19)
------------------

Fix
~~~

- No argument at all was treated as one empty string argument. Thx Yassa
  Bb. (fixes #6) [Valentin Lab]

0.2.1 (2013-11-23)
------------------

New
~~~

- Python3 support. [Valentin Lab]

Fix
~~~

- Keys can now be empty or contains dots ``.`` if they are properly
  escaped (fixes #5, thanks to Daniel Giribet) [Daniel Giribet]

0.2.0 (2013-05-03)
------------------

New
~~~

- Support for iteration in sequence and struct in one go. [Valentin Lab]

Fix
~~~

- Doc: forgot to mention ``./autogen.sh`` execution when getting the
  code from git, and be more clear about other means of installation.
  [Valentin Lab]

0.1.3 (2013-03-29)
------------------

Fix
~~~

- Removed the spurious line feed at the end of any ``shyaml`` output.
  [Valentin Lab]

- Support querying for... nothing. Which now returns the whole input
  YAML. [Valentin Lab]

  Before this fix, you couldn't ask for ``shyaml get-value`` alone, even
  if it makes sense but is completely useless as it returns the whole
  YAML input.

0.1.2 (2013-03-23)
------------------

New
~~~

- Support for list indexes (see README.rst). [Valentin Lab]

- Catch exceptions when parsing structure and output a clean error
  message. [Valentin Lab]

0.1.1 (2013-02-27)
------------------

Changes
~~~~~~~

- Doc: some minor enhancements, and an "Install" section. [Valentin Lab]



SUBCOMMAND
==========

* git sync
Deletes branches which were deployed. That means local branches will be deleted
when they were merged into remote master.

* git hooks
Tool to install pre-defined hooks in repository. Ask's for agreement before
installation of each hook.

```sh
git hooks
Install: pre-commit/php/abort_if_debug_present.sh? [y/N]y
Install: pre-commit/php/check-syntax.sh? [y/N]y
```

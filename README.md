About
====

Storage of personal linux configs.

Advantages:
    + flexible
    + easy maintainable
    + portable

Usage
=====

1) Init empty git repository directly into home directory. Add this repository as
   new origin remote. 

```
cd ~
git init
git remote add origin git@github.com:marcinrogacki/configitor.git
```
2) Fetch configs

```
git fetch origin
```

3) Create branch 'linux' and navigate into it.
4) List all remote branches-configs. One branch equals one app config.

```
git branch -a
```

5) Merge branches that are you interested in into one `linux` branch.
6) Use `linux` branch during your daily worktime with linux.

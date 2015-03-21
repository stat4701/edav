---
layout: post
title: some more git notes
---

## The extremely helpful `log` alias

```
git config --global alias.tree "log --graph --decorate --pretty=oneline --abbrev-commit"
```

## Mac users sublime as editor

First do [this](https://gist.github.com/olivierlacan/1195304) then you can set 

```
git config --global core.editor 'subl -n -w'
```
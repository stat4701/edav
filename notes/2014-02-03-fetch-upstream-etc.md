---
layout: post
title: fetching git stuff from upstream (malecki)
tags: 
---

```{bash}
git remote add upstream https://github.com/malecki/edav.git
git fetch upstream
git merge -r upstream/gh-pages
```
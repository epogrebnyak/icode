# Seven classes in Haskell


In December 2018 [Yuras Shumovich](https://twitter.com/shumovichy) gave me a delightful and gentle [introduction to Haskell][7hs], that keeps me interested in the language ever since. 

<!--more-->

## Functional programming

While I did not progress beyond classroom projects in Haskell, the functional programming 
ideas (purity and typefulness) affected the way I write code in Python:

- I often miss the  `.` operator for chaining functions
- with currying dependency injection is not that big of a trick
- I treat Enum more favourably as a proxy for algebraic data type
- dataclasses, where I can (wait, maybe a tuple would be good enough)
- mypy for type checking, even as annotations
- separation of IO and pure functions
- make a pipeline starting from raw immutable data, don't mutate the data

## It is social

The social part of Haskell is also intriguing. Some people would treat
their knowledge of Haskell as a sign of technical, intellectual and even moral 
superiority, but many would be willing to share their knowledge and support
you. 

In my case, I was lucky to have [Yuras](https://twitter.com/shumovichy) 
as a teacher and mentor. But what if you have not yet found any Haskell peers:

- Online [Zurihac](https://zfoh.ch/zurihac2020/) is great venue to dive into Haskell and ask around. 
- There are two Telegram channels for Haskell in Russian, accepting questions in English too: 
[Haskell Start](https://t.me/haskell_learn) for beginners and [Haskell](https://t.me/haskellru) for advanced discussions. I'm often surprised how smart and well-informed people are there.
- I maintain a larger collection of learning resources for Haskell [here][7hs], maybe something catches your eye.

[7hs]: https://github.com/epogrebnyak/haskell-intro

## Yes, you can use Haskell

[Zarak](https://github.com/zarak), my collegue in remote work who also joined Yuras course, went on much further in using Haskell for real projects. He is experimenting with [IHP](https://ihp.digitallyinduced.com/), a new framework create CRUD apps, written in Haskell.


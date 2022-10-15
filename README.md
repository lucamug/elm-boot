# Welcome! 👋

[This project](https://github.com/lucamug/elm-boot) can run both locally or inside replit.com

## To run it in replit.com

Go to [replit.com/@lucamug/elm-boot](https://replit.com/@lucamug/elm-boot), then run

```
cmd/start
```
either in the `Console` or in a `Shell`.

## To run it locally

```
git clone https://github.com/lucamug/elm-boot
cd elm-boot
cp package.local.json package.json 
yarn install
```

Now just start the development server with

```
cmd/start
```

## Resources

* [Elm Syntax](https://elm-lang.org/docs/syntax)
* [Elm guide](https://guide.elm-lang.org/)
* [Elm packages official](https://package.elm-lang.org/)
* [Elm packages alternative](https://elm.dmy.fr/)
    * [elm/core](https://elm.dmy.fr/packages/elm/core/latest/)
    * [elm/html](https://elm.dmy.fr/packages/elm/html/latest/)
    * [elm/browser](https://elm.dmy.fr/packages/elm/browser/latest/)
* [Elm Cheat Sheet](https://lucamug.github.io/elm-cheat-sheet/)
* [Search by type](https://klaftertief.github.io/elm-search/)
* [Stringy](https://stringy.guupa.com/)
* [Elm Patterns](https://sporto.github.io/elm-patterns/)
* [Animation of The Elm Architecture](https://lucamug.medium.com/the-elm-architecture-tea-animation-3efc555e8faf)
* [E-Commerce](https://elm-ecommerce.guupa.com/)
* [Elm Presentation](https://elm-pres.jakobferdinand.at/)
* [Exercism](https://exercism.org/tracks/elm)
* [Elm Radio](https://elm-radio.com/)
* [Beginning Elm](https://elmprogramming.com/)
* [Elm Cookbook](https://orasund.gitbook.io/elm-cookbook/)
* [Elm Craft](https://elmcraft.org/)
* [Elm Weekly](https://www.elmweekly.nl/)


## Elm Community

* [Elm Community on Discourse](https://discourse.elm-lang.org/)
* [Elm Community on Slack](https://elmlang.herokuapp.com/)

## Elm at Rakuten

* [Post: Elm at Rakuten](https://engineering.rakuten.today/post/elm-at-rakuten/)
* [Login/Registration](https://login.account.rakuten.com/sso/authorize?client_id=rakuten_tw01&redirect_uri=https%3A%2F%2Fwww.rakuten.com.tw%2Fmember%2Fdelegate&response_type=code&scope=openid+profile+email&ui_locales=zh-TW#/sign_in)
* [Device Management](https://jp.account.rakuten.com/device-management/)
* [FAQ](https://jp.account.rakuten.com/device-management/faq/en/device-registration/)
* [About Security](https://static.id.rakuten.co.jp/static/about_security/jpn/)
* [404 Error page](https://login.account.rakuten.com/)

## Elm at Rakuten - Open Source

* [Rakuten Open Source](https://rakutentech.github.io/)
* [Rakuten Open Source - Code](https://github.com/rakutentech/rakutentech.github.io)
* [Trinity](https://rakutentech.github.io/http-trinity/)
* [Trinity - Code](https://github.com/rakutentech/http-trinity)
* [R10 Design System](https://r10.netlify.app/)
* [R10 Design System - Code](https://github.com/rakutentech/r10)

## Commands available

* `cmd/start`          *(Starts the development server)*
* `cmd/build`          *(Creates optimized files for the production release)*
* `cmd/deploy`         *(Deploys the application)*
* `cmd/review`         *(Reviews the code using elm-review)*
* `cmd/fix`            *(Fixes the code using elm-review)*
* `cmd/test`           *(Runs tests)*
* `cmd/delete-cache`   *(Deletes the folder elm-stuff)*
* `cmd/docs`           *(Starts offline Elm documentation)*
* `cmd/examples`       *(Lists of available examples)*
* `cmd/format-all`     *(Formats all Elm files un the src folder)*
* `cmd/help`           *(Prints the help menu)*
* `cmd/upgrade`        *(Verifies the freshness of Elm dependencies)*
* `cmd/npm-upgrades`   *(Verifies the freshness of NPM dependencies)*
* `cmd/pre-PR-check`   *(Verifies the code before a PR)*
* `cmd/run-build`      *(Starts a server to verify the production code)*
* `cmd/serve`          *(Same as cmd/start)*
* `cmd/tree`           *(Shows the Elm dependencies)*

## Deployment

This project can be deployed with these services out of the box, with the support of pushstate routing

* https://surge.sh/
* https://netlify.com/

Deployed examples:

* https://elm-boot.surge.sh/
* https://elm-boot.netlify.app/
    
Documentation about pushstate routing:

* https://surge.sh/help/adding-a-200-page-for-client-side-routing
* https://docs.netlify.com/routing/redirects/


## GIT commands

* `git reset –hard`                 *(To reset the workspace)*
* `git rev-parse --abbrev-ref HEAD` *(To show the current branch)*
* `git rebase -i HEAD~2`            *(To squash)*
* `git branch --set-upstream-to=origin/main main` *(To set tracking information)*
* `git remote`                      *(To check the name of remote)*
* `git pull`                        *(To pull)*
* `git reset --hard origin/main`    *(To pull overwriting everything)*
* `git branch -d <branch_name>`     *(To delete a local branch)*
* `git branch`                      *(To list local branches)*
* `git remote add origin https://github.com/lucamug/elm-boot` *(To add a connection)*
* `git remote remove origin`        *(To Remove the connection)*

## Others

* `busybox reboot`                  *(To reboot a workspace)*
* `killall node`                    *(To kill node processes, like elm-go for example)*
* `rm -rf`                          *(To remove a folder and sub-folders)*

## **😃 HAPPY CODING! 😃**
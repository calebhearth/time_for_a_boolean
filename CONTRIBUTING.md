# Contributing

I love pull requests. Here's a quick guide:

1. Fork the repo.
2. Run the tests. I only take pull requests with passing tests, and it's great
   to know that you have a clean slate: `bundle && rake`
3. Add a test for your change. Only refactoring and documentation changes
   require no new tests. If you are adding functionality or fixing a bug, I need
   a test!
4. Make the test pass.
5. Make sure your changes adhere to the
   [thoughtbot Style Guide](https://github.com/thoughtbot/guides/tree/master/style)
6. Write an [awesome] [commit] [message].
[awesome]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[commit]: http://robots.thoughtbot.com/post/48933156625/5-useful-tips-for-a-better-commit-message
[message]: http://rakeroutes.com/blog/deliberate-git/
6. Push to your fork and submit a pull request.
7. At this point you're waiting on us. I like to at least comment on, if not
   accept, pull requests within a few days (and, typically, one business
   day). I may suggest some changes or improvements or alternatives.

## Increase your chances of getting merged

Some things that will increase the chance that your pull request is accepted,
taken straight from the Ruby on Rails guide:

1. Use Rails idioms and helpers
2. Include tests that fail without your code, and pass with it
3. Update the documentation, the surrounding one, examples elsewhere, guides,
   whatever is affected by your contribution
4. Syntax:
   * Two spaces, no tabs.
   * No trailing whitespace. Blank lines should not have any space.
   * Prefer `&&`/`||`  over `and`/`or`.
   * `MyClass.my_method(my_arg)` not `my_method( my_arg )` or `my_method my_arg`.
   * `a = b` and not `a=b`.
   * Follow the conventions you see used in the source already.
5. And in case I didn't emphasize it enough: I love tests!

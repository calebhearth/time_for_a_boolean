Time for A Boolean
==================

[![Build Status](https://api.travis-ci.org/calebthompson/time_for_a_boolean.png?branch=master)](https://travis-ci.org/calebthompson/time_for_a_boolean)
[![Code Climate](https://codeclimate.com/github/calebthompson/time_for_a_boolean.png)](https://codeclimate.com/github/calebthompson/time_for_a_boolean)
[![Coverage Status](https://coveralls.io/repos/calebthompson/time_for_a_boolean/badge.png)](https://coveralls.io/r/calebthompson/time_for_a_boolean)


> Sally: Hey, we need to add a flag to Post

> Jean: What for?

> Sally: Well, we want to let users "delete" posts, but not actually lose the
         data.

> Jean: Sounds reasonable. But what about later, when we have to know _when_ a
  post was deleted?

> Sally: That's a good point, but if we add a timestamp now we have to write all
         sorts of methods to keep a nice interface on Post...

> Jean: Time for A Boolean!

Wait, what?
-----------

```
rails generate migration AddDeletedAtToPosts deleted_at:timestamp
```

```ruby
class Post < ActiveRecord::Base
  time_for_a_boolean :deleted
  ...
end
```

```ruby
class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    if @post.deleted?
      raise ActiveRecord::RecordNotFound
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.deleted = true
    post.save
    redirect_to posts_url
  end
end
```

You keep on saying things and I don't get it.
---------------------------------------------

Okay, let's take a look at what happens.

When we call `time_for_a_boolean :deleted` in the Post class definition, several
methods are defined:

| Method          | Description
| --------------- | -----------
| `Post#deleted`  | `true` if `Post#deleted_at` is set to a value greater than `Time.current`, `false` otherwise
| `Post#deleted?` | Alias for `Post#deleted`
| `Post#deleted=` | Sets the timestamp to `Time.current` if the new value is true, and `nil` otherwise

These methods allow you to use a timestamp as you would a boolean value in your
application.

Okay... why?
------------

* Audit for when a flag was set. Future you wants this.
* `COUNT(posts.deleted_at)` gives you the count of deleted posts, which is
  useful when writing a report. Define and use `Post.deleted.count` when you
  have Ruby available.

Other Options
-------------

If you have a date or time column that does not follow the `attribute_at` convention,
you can specify the attribute name:

```
class User < ActiveRecord::Base
  time_for_a_boolean :expires, :expires_on
end
```

This is especially useful when using date only columns.

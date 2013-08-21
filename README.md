Time for A Boolean
==================

[![Build Status](https://travis-ci.org/calebthompson/time_for_a_boolean.png)](https://travis-ci.org/calebthompson/time_for_a_boolean)
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
| `Post#deleted`  | `true` if `Post#deleted_at` is set, `false` otherwise
| `Post#deleted?` | Alias for `Post#deleted`
| `Post#deleted=` | Sets the timestamp to `DateTime.now` if the new value is true, and `nil` otherwise

module DesugaringExercises

  def all_the_sugar(recipients, event, message)
    mail message,
      to: recipients.map(&:email),
      subject: "You’re invited to #{event.title} on #{event.date}"
  end

  # Ruby allows you to pass arguments to a method without using parentheses. Ruby programmers lovingly
  # (or perhaps mockingly) call this “code poetry:”
  #
  #   foo bar, baz
  #
  # ...is sugar for:
  #
  #   foo(bar, baz)
  #
  # You can see a lot of this in the AASM code in this homework. That is a common sort of use for code
  # poetry: declarative calls that are meant almost to read as a custom language.
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  def desugared_poetry(recipients, event, message)
    mail(message,
      to: recipients.map(&:email),
      subject: "You’re invited to #{event.title} on #{event.date}")
  end

  # Ruby allows you to pass arguments identified by name instead of just by position. They are really just
  # sugar for passing a hash as the last argument.
  #
  #   speak("hello", voice: "jovial", speed: 37)
  #
  # ...is sugar for the two-argument method call:
  #
  #   speak("hello", {voice: "jovial", speed: 37})
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  def desugared_named_args(recipients, event, message)
    mail(message,
      { to: recipients.map(&:email),
      subject: "You’re invited to #{event.title} on #{event.date}"})
  end

  # Ruby’s general syntax for hashes is `{key => value, key => value, ...}`. Because it is so common to use
  # symbols as keys in a hash, Ruby provides a shortcut syntax for that:
  #
  #   {voice: "jovial", speed: 37}
  #
  # ...is sugar for:
  #
  #   {:voice => "jovial", :speed => 37 }
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  def desugared_symbol_keys(recipients, event, message)
    mail(message,
      { :to => recipients.map(&:email),
        :subject => "You’re invited to #{event.title} on #{event.date}"})
  end

  # You may be wondering how `map(&:email)` works. When you precede the last argument of a method call with
  # `&`, Ruby calls `to_proc` on whatever comes after the ampersand and then tries to pass that as a block
  # to the method being called. And if you call `to_proc` on a symbol, you get a one-argument closure that
  # tries to call a method on its argument named after the symbol.
  #
  # In other words, this:
  #
  #   foo(&:bar)
  #
  # ...is sugar for:
  #
  #   foo { |x| x.bar }
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  def desugared_attr_proc(recipients, event, message)
    mail(message,
      { :to => recipients.map { |r| r.email },
        :subject => "You’re invited to #{event.title} on #{event.date}"})
  end

  # You may recall from the Ruby koans that when you put `#{something}` in a `"`-delimited string, Ruby will
  # evaluate `something` as Ruby code, convert the result to a string by calling `to_s`, and then
  # concatenate it all together.
  #
  # This feature is called “string interpolation.” For example:
  #
  #   "The answer is #{6 * 7}, or so #{book.title} tells me."
  #
  # ...is sugar for:
  #
  #   "The answer is " + (6 * 7).to_s + " or so " + book.title.to_s + " tells me."
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  def desugared_interpolation(recipients, event, message)
    mail(message,
      { :to => recipients.map { |r| r.email },
        :subject => "You’re invited to " + event.title.to_s + " on " + event.date.to_s})
  end

  # Ruby tracks local variables lexically at compile time. Wherever you say `x = y`, the compiler assumes that
  # `x` is a local variable, and implicitly declares it if it’s not already declared. You also create a local
  # variable when you make a method parameter or block parameter.
  #
  # If you use any name that is not already a local variable, then Ruby assumes that you are calling a method
  # of `self`, so:
  #
  #   bar = 3   # this makes bar a local variable
  #   foo(bar)
  #
  # ...is sugar for:
  #
  #   bar = 3
  #   self.foo(bar)  # assuming foo is not a local variable
  #
  # Copy the contents of the previous method here and remove this sugar.
  # (Think: which names are local variables, and which are not?)
  #
  def desugared_implicit_self(recipients, event, message)
    self.mail(message,
      { :to => recipients.map { |r| r.email },
        :subject => "You’re invited to " + event.title.to_s + " on " + event.date.to_s})
  end

  # In Ruby, unlike Python, there are no properties distinct from method calls. When you say `x.y`, you are
  # always calling a method `y` on the object `x`; it’s just that the parentheses are optional.
  # (Note that this is just a special case of code poetry!)
  #
  # In other words, this:
  #
  #   foo.bar
  #
  # ...is sugar for:
  #
  #   foo.bar()
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  # At this point, you should have code that looks remarkably like Javascript. Not _exactly_ like it,
  # but structurally quite similar!
  #
  def desugared_implicit_parens(recipients, event, message)
    self.mail(message,
      { :to => recipients.map(){ |r| r.email() },
        :subject => "You’re invited to " + event.title().to_s() + " on " + event.date().to_s()})
  end

  # In Ruby, every value is an object and every action is a method call. That includes operators. A binary
  # operator is just a method call on the left hand side with the right hand side as the argument.
  #
  # For example, you may recall from class that this:
  #
  #   a + b
  #
  # ...is sugar for:
  #
  #   a.+(b)
  #
  # Copy the contents of the previous method here and remove this sugar.
  #
  # P.S. This one gets messy! Use line breaks and indentation to help.
  # P.P.S. Note that whitespace is syntactic sugar too.
  # P.P.P.S. For full credit on this one, note that addition is left-associative: the things on the left
  #   get added before the things on the right. (a + b + c) means ((a + b) + c), NOT (a + (b + c)).
  #
  def desugared_operators(recipients, event, message)
    self.mail(message,
      { :to => recipients.map(){ |r| r.email() },
        :subject => 
        (
          (
            "You’re invited to ".+(event.title().to_s())
          ).+(" on ")
        ).+(event.date().to_s())
      })
  end

  # Compare that to the version at the top.
  #
  # Languages designers argue a lot -- excessively, perhaps -- about how much sugar is too much.
  # Java, for example, has long resisted sugar; Ruby embraces it wildly.

end

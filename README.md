# RSpec Drill: Simple TODO

We're going to take a trip back in time… to the land of Ruby Todos.  It is a magical and mundane realm with clearly defined expectations and many opportunities to practice object-oriented design.

You are already familiar with the premise, and you have probably written solution code.  But is your code tested?

In this challenge, you'll be writing the specs for a simplified version of the [Ruby Todos](http://socrates.devbootcamp.com/challenges/97) challenge.  Don't worry, you won't be testing the user interface.  You'll just be writing unit tests.

**A word of warning on writing object-oriented specs**
When you are writing your examples, keep in mind that writing a test is equivalent to adding dependencies on your code.  As a general principle, you want to avoid dependencies.

To be both effective and well-designed, your specs need to enforce the contracts for your classes.  They should still treat your objects with the same deference and respect that the other objects in your application code do.

You want your tests to be as loosely coupled to the application code as possible.  By necessity, they need to know the name of the class, its methods, and the inputs and return values of those methods.

When writing unit tests, be wary of the temptation to **test too deeply**, i.e. to test the *implementation* instead of the *interface*.  Remember, you don't care *how* your code works, you just want to ensure that it works as expected.

## Objectives

### Grab the files from the gist

Download the files from [the gist](https://gist.github.com/dbc-challenges/2f6973cad74bd41fb86b).  You will find two application files: `list.rb` and `task.rb` and two spec files `list_spec.rb` and `task_spec.rb`.

You can run the spec suite like so:

```bash
$ rspec task_spec.rb
# [ test output ]
$ rspec list_spec.rb
# [ test output ]
```

### Read the code

Before you write any examples, be sure to read through all of the code and the specs.

You'll notice that the specs for `Task` are already written, whereas for `List` there are no specs.

Once you understand how the code works, you can begin writing specs for `List`.

### Write all the specs

Write a full spec suite for the `List` class.  Your examples should test the full public interface of `List`.

Again, ensure that your specs actually test the code by checking that they fail when you comment out the relevant application code.

For reference, here are some good questions to ask when writing tests:

- What constitutes valid vs. invalid inputs?
- What are the expected and unexpected return values?
- What other effects does the method have on the state of the program?

### Identify weaknesses and make corrections

Over the course of writing your tests, you may find yourself discovering inconsistencies or irregularities in the code.  That's great!  That is what is supposed to happen!  Writing specs are a great way to analyze your code more closely.

As you write the specs for `List` and come across an oversight in the program architecture, don't be afraid to make improvements to the code.  You shouldn't change the public interface, but you can certainly change the implementation of the public methods.

As an example, take the `#complete_task` method:

```ruby
def complete_task(index)
  tasks[index].complete!
end
```

When you are writing the examples for this method, you will eventually come to the question of "What constitutes invalid input?"  One answer to this question is that the `index` is  beyond the scope of the array.  As the code is written now, when this happens it will be call `complete!` on `nil`, which is nor so good.

In this case, the spec has exposed a potential flaw in our program.  It would be better to catch this potential error with a refactor along these lines:

```ruby
def complete_task(index)
  return false unless tasks[index]
  if tasks[index].complete!
    return true
  end
end
```

This code is an improvement in two ways:

1. Invalid input is caught and will return `false`, which we can now test for.
2. It no longer returns the return value of `#complete!`  , which for all we care could be anything at all.  Instead, it merely checks to be sure that `#complete!` returns a truthy value and then returns true.  This ensures that we have control over the return value of `#complete_task` regardless of what `#complete!` returns.

Be on the lookout for other potential improvements like this one.
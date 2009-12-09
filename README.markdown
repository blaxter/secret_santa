# Description

A small script to be used for [secret santa game](http://en.wikipedia.org/wiki/Secret_Santa)

# Use

  it requires just ruby, rubygems and **pony** gem installed.

## Configure

  * DEBUG: set to false (when is true, emails won't be sent)
  * SUBJECT: emails' subject

## Execute it

By default it uses a gmail account, so execute like:

     $ ./secret_santa.rb MY_USER MY_PASSWORD list-of@emails.com of-the@people.com that-participates@in.the secret-santa@game.yeah

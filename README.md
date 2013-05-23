# Blume

## About

Blume is a static site generator meant to be used with [Sinatra](http://www.sinatrarb.com/). Blume is simmilar [Jekyll](http://jekyllrb.com/) in that content is stored in simple YAML + markdown text files. However, with Blume, there is an intermediate in which you read your text files into a MongoDB and develop your site "dynamically" using Sinatra and MongoDB. After the site is developed, you compile it into a self-contained directory which contains a static version of your site with optional compressed versions of all pages.

There may be a bit of additional overhead with learning Blume since you must also use Sinatra and MongoDB but if these are tools you like and/or you would simply like to have more freedom with the development of your static site, Blume may be a good choice for you.

## Installation

To install blume:

    $gem install blume
    
You also need [MondgoDB](http://docs.mongodb.org/manual/) installed and running.

## Usage

### Caveat

Blume uses a few conventions, most are optional and can be over-ridden but there is one convention that is necessary. All internal URLs must be root-relative. For instance, "/, /sub, sub/sub..." not "www.mysite.com/, www.mysite.com/sub...". This behaviour may change in later releases but it wasn't necessary to implement absolute URLs for my needs so it has taken a low priority.

### Convetions

It will be easiest if you follow the Sinatra default location for your public files (.css, .js, etc.) in the 'public' folder within your project. In addtion to this, the default folder structure for Blume is to keep your content in the 'content' folder and to output the static site to the 'site' folder. The default folder structure for a Blume project could therefor look like this

```
root
    |- content
    |- public
    |- site
    my_app.rb    
```

### Content



posts folder structure and date structure

TODO: Write usage instructions here

## Migrations



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
